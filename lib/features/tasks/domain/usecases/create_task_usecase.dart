import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTaskParams {
  final String title;
  final String projectId;
  final String userId;
  final String description;
  final Priority priority;
  final DateTime? dueDate;

  const CreateTaskParams({
    required this.title,
    required this.projectId,
    required this.userId,
    this.description = '',
    this.priority = Priority.medium,
    this.dueDate,
  });
}

class CreateTaskUseCase {
  final TaskRepository _repository;
  const CreateTaskUseCase(this._repository);

  Future<Task> call(CreateTaskParams params) async {
    // Validation métier
    final trimmedTitle = params.title.trim();
    if (trimmedTitle.isEmpty) {
      throw const ValidationException('Le titre ne peut pas être vide.');
    }
    if (trimmedTitle.length > 200) {
      throw const ValidationException('Le titre est trop long (max 200 car.).');
    }
    if (params.dueDate != null &&
        params.dueDate!.isBefore(
          DateTime.now().subtract(const Duration(minutes: 1)),
        )) {
      throw const ValidationException(
          'La date d\'échéance ne peut pas être dans le passé.');
    }

    final task = Task(
      id: const Uuid().v4(),
      title: trimmedTitle,
      projectId: params.projectId,
      userId: params.userId,
      description: params.description.trim(),
      priority: params.priority,
      dueDate: params.dueDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return _repository.createTask(task);
  }
}
