import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirebaseFirestore _db;

  TaskRepositoryImpl({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<TaskModel> get _col =>
      _db.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (snap, _) => TaskModel.fromJson(snap.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  @override
  Future<List<Task>> getTasks({required String projectId}) async {
    try {
      final snap = await _col
          .where('project_id', isEqualTo: projectId)
          .orderBy('created_at', descending: true)
          .get();
      return snap.docs.map((d) => d.data().toEntity()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur Firestore', statusCode: 500);
    }
  }

  @override
  Future<Task> getTask(String id) async {
    try {
      final snap = await _col.doc(id).get();
      if (!snap.exists) throw NotFoundException('Tâche introuvable: $id');
      return snap.data()!.toEntity();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur Firestore');
    }
  }

  @override
  Future<Task> createTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      await _col.doc(task.id).set(model);
      return task;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur lors de la création');
    }
  }

  @override
  Future<Task> updateTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      await _col.doc(task.id).set(model, SetOptions(merge: true));
      return task;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur lors de la mise à jour');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _col.doc(id).delete();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur lors de la suppression');
    }
  }

  @override
  Stream<List<Task>> watchTasks({required String projectId}) {
    return _col
        .where('project_id', isEqualTo: projectId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data().toEntity()).toList());
  }

  @override
  Future<List<Task>> getTasksDueToday(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snap = await _col
        .where('user_id', isEqualTo: userId)
        .where('due_date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('due_date', isLessThan: Timestamp.fromDate(endOfDay))
        .where('status', isNotEqualTo: TaskStatus.done.name)
        .get();

    return snap.docs.map((d) => d.data().toEntity()).toList();
  }

  @override
  Future<List<Task>> getOverdueTasks(String userId) async {
    final snap = await _col
        .where('user_id', isEqualTo: userId)
        .where('due_date', isLessThan: Timestamp.fromDate(DateTime.now()))
        .where('status', isNotEqualTo: TaskStatus.done.name)
        .get();

    return snap.docs.map((d) => d.data().toEntity()).toList();
  }
}
