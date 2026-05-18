import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

enum Priority {
  low,
  medium,
  high,
  critical;

  String get label => switch (this) {
    Priority.low => 'Basse',
    Priority.medium => 'Moyenne',
    Priority.high => 'Haute',
    Priority.critical => 'Critique',
  };

  int get order => index;
}

enum TaskStatus {
  todo,
  inProgress,
  done;

  String get label => switch (this) {
    TaskStatus.todo => 'À faire',
    TaskStatus.inProgress => 'En cours',
    TaskStatus.done => 'Terminé',
  };
}

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String projectId,
    required String userId,
    @Default('') String description,
    @Default(Priority.medium) Priority priority,
    @Default(TaskStatus.todo) TaskStatus status,
    @Default([]) List<String> tagIds,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    String? assigneeId,
  }) = _Task;

  const Task._();

  bool get isCompleted => status == TaskStatus.done;

  bool get isOverdue =>
      dueDate != null && dueDate!.isBefore(DateTime.now()) && !isCompleted;

  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }

  Task markDone() => copyWith(
    status: TaskStatus.done,
    completedAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  Task markTodo() => copyWith(
    status: TaskStatus.todo,
    completedAt: null,
    updatedAt: DateTime.now(),
  );
}
