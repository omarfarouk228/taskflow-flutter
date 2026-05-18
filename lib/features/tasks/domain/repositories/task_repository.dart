import '../entities/task.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getTasks({required String projectId});
  Future<Task> getTask(String id);
  Future<Task> createTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String id);
  Stream<List<Task>> watchTasks({required String projectId});
  Future<List<Task>> getTasksDueToday(String userId);
  Future<List<Task>> getOverdueTasks(String userId);
}
