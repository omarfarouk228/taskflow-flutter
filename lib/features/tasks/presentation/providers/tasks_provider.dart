import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

part 'tasks_provider.g.dart';

// ── Repository ───────────────────────────────────────────
@riverpod
TaskRepository taskRepository(Ref ref) =>
    TaskRepositoryImpl();

// ── Use Cases ────────────────────────────────────────────
@riverpod
CreateTaskUseCase createTaskUseCase(Ref ref) =>
    CreateTaskUseCase(ref.watch(taskRepositoryProvider));

// ── Stream temps réel Firestore ──────────────────────────
@riverpod
Stream<List<Task>> tasksStream(
  Ref ref, {
  required String projectId,
}) {
  return ref.watch(taskRepositoryProvider).watchTasks(projectId: projectId);
}

// ── Notifier principal des tâches ────────────────────────
@riverpod
class TasksNotifier extends _$TasksNotifier {
  @override
  Future<List<Task>> build({required String projectId}) async {
    return ref.watch(taskRepositoryProvider).getTasks(projectId: projectId);
  }

  Future<void> createTask(CreateTaskParams params) async {
    final useCase = ref.read(createTaskUseCaseProvider);
    final newTask = await useCase(params);

    // Optimistic update
    state = AsyncData([newTask, ...?state.value]);

    // Programmer la notification si date définie
    if (newTask.dueDate != null) {
      // NotificationService.scheduleTaskReminder(...)
    }
  }

  Future<void> toggleTask(String taskId) async {
    final repo = ref.read(taskRepositoryProvider);
    final current = state.value ?? [];
    final task = current.firstWhere((t) => t.id == taskId);
    final updated = task.isCompleted ? task.markTodo() : task.markDone();

    // Optimistic update
    state = AsyncData(
      current.map((t) => t.id == taskId ? updated : t).toList(),
    );

    try {
      await repo.updateTask(updated);
    } catch (_) {
      // Rollback
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    final repo = ref.read(taskRepositoryProvider);
    final current = state.value ?? [];

    state = AsyncData(
      current.map((t) => t.id == task.id ? task : t).toList(),
    );

    try {
      await repo.updateTask(task);
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    final repo = ref.read(taskRepositoryProvider);
    final current = state.value ?? [];

    state = AsyncData(current.where((t) => t.id != taskId).toList());

    try {
      await repo.deleteTask(taskId);
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(taskRepositoryProvider).getTasks(projectId: projectId),
    );
  }
}

// ── Filtre et triage ─────────────────────────────────────
enum TaskFilter { all, todo, inProgress, done, overdue }

@riverpod
class TaskFilterNotifier extends _$TaskFilterNotifier {
  @override
  TaskFilter build() => TaskFilter.all;
  void set(TaskFilter f) => state = f;
}

@riverpod
List<Task> filteredTasks(
  Ref ref, {
  required String projectId,
}) {
  final tasksAsync =
      ref.watch(tasksProvider(projectId: projectId));
  final filter = ref.watch(taskFilterProvider);

  final tasks = tasksAsync.value ?? [];

  return switch (filter) {
    TaskFilter.all => tasks,
    TaskFilter.todo =>
      tasks.where((t) => t.status == TaskStatus.todo).toList(),
    TaskFilter.inProgress =>
      tasks.where((t) => t.status == TaskStatus.inProgress).toList(),
    TaskFilter.done =>
      tasks.where((t) => t.status == TaskStatus.done).toList(),
    TaskFilter.overdue => tasks.where((t) => t.isOverdue).toList(),
  };
}

// ── Tâches du jour pour HomeScreen ──────────────────────
@riverpod
Future<List<Task>> tasksDueToday(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Future.value([]);
  return ref.watch(taskRepositoryProvider).getTasksDueToday(user.uid);
}
