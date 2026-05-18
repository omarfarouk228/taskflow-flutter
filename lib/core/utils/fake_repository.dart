import 'package:uuid/uuid.dart';

import '../../features/tasks/domain/entities/task.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';

/// Repository factice utilisé pendant le développement
/// et dans les tests unitaires — aucune dépendance Firebase.
class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    Task(
      id: 'task-1',
      title: 'Finaliser la maquette Figma',
      projectId: 'project-1',
      userId: 'user-1',
      description: 'Revoir les écrans Accueil, Détail et Paramètres',
      priority: Priority.high,
      status: TaskStatus.inProgress,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Task(
      id: 'task-2',
      title: 'Implémenter l\'authentification Firebase',
      projectId: 'project-1',
      userId: 'user-1',
      priority: Priority.critical,
      status: TaskStatus.todo,
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Task(
      id: 'task-3',
      title: 'Écrire les tests unitaires',
      projectId: 'project-1',
      userId: 'user-1',
      description: 'Coverage minimum : 80%',
      priority: Priority.medium,
      status: TaskStatus.todo,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Task(
      id: 'task-4',
      title: 'Configurer GitHub Actions',
      projectId: 'project-2',
      userId: 'user-1',
      priority: Priority.low,
      status: TaskStatus.done,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Task(
      id: 'task-5',
      title: 'Rapport en retard',
      projectId: 'project-1',
      userId: 'user-1',
      priority: Priority.high,
      status: TaskStatus.todo,
      dueDate: DateTime.now().subtract(const Duration(days: 1)), // En retard
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  Future<List<Task>> getTasks({required String projectId}) async {
    await _simulateDelay();
    return _tasks.where((t) => t.projectId == projectId).toList();
  }

  @override
  Future<Task> getTask(String id) async {
    await _simulateDelay();
    return _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Tâche introuvable: $id'),
    );
  }

  @override
  Future<Task> createTask(Task task) async {
    await _simulateDelay(ms: 300);
    final newTask = task.copyWith(
      id: task.id.isEmpty ? const Uuid().v4() : task.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _tasks.add(newTask);
    return newTask;
  }

  @override
  Future<Task> updateTask(Task task) async {
    await _simulateDelay(ms: 200);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) throw Exception('Tâche introuvable: ${task.id}');
    final updated = task.copyWith(updatedAt: DateTime.now());
    _tasks[index] = updated;
    return updated;
  }

  @override
  Future<void> deleteTask(String id) async {
    await _simulateDelay(ms: 200);
    _tasks.removeWhere((t) => t.id == id);
  }

  @override
  Stream<List<Task>> watchTasks({required String projectId}) async* {
    while (true) {
      yield _tasks.where((t) => t.projectId == projectId).toList();
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Future<List<Task>> getTasksDueToday(String userId) async {
    await _simulateDelay();
    final now = DateTime.now();
    return _tasks.where((t) {
      if (t.userId != userId || t.dueDate == null) return false;
      return t.dueDate!.year == now.year &&
          t.dueDate!.month == now.month &&
          t.dueDate!.day == now.day;
    }).toList();
  }

  @override
  Future<List<Task>> getOverdueTasks(String userId) async {
    await _simulateDelay();
    return _tasks
        .where((t) => t.userId == userId && t.isOverdue)
        .toList();
  }

  Future<void> _simulateDelay({int ms = 500}) =>
      Future.delayed(Duration(milliseconds: ms));
}
