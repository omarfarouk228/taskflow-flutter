import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final FirebaseFirestore _db;
  ProjectRepositoryImpl({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('projects');

  Project _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return Project(
      id: doc.id,
      title: d['title'] as String,
      userId: d['user_id'] as String,
      description: d['description'] as String? ?? '',
      colorValue: d['color_value'] as int? ?? 0xFF0553B1,
      taskCount: d['task_count'] as int? ?? 0,
      completedCount: d['completed_count'] as int? ?? 0,
      createdAt: (d['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (d['updated_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> _toMap(Project p) => {
        'title': p.title,
        'user_id': p.userId,
        'description': p.description,
        'color_value': p.colorValue,
        'task_count': p.taskCount,
        'completed_count': p.completedCount,
        'created_at':
            p.createdAt != null ? Timestamp.fromDate(p.createdAt!) : null,
        'updated_at': Timestamp.fromDate(DateTime.now()),
      };

  @override
  Future<List<Project>> getProjects(String userId) async {
    try {
      final snap = await _col
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .get();
      return snap.docs.map(_fromDoc).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Erreur Firestore');
    }
  }

  @override
  Future<Project> getProject(String id) async {
    final snap =
        await _col.doc(id).get();
    if (!snap.exists) throw NotFoundException('Projet introuvable: $id');
    return _fromDoc(snap);
  }

  @override
  Future<Project> createProject(Project project) async {
    final id = project.id.isEmpty ? const Uuid().v4() : project.id;
    final p = project.copyWith(id: id, createdAt: DateTime.now());
    await _col.doc(id).set(_toMap(p));
    return p;
  }

  @override
  Future<Project> updateProject(Project project) async {
    await _col.doc(project.id).update(_toMap(project));
    return project;
  }

  @override
  Future<void> deleteProject(String id) => _col.doc(id).delete();

  @override
  Stream<List<Project>> watchProjects(String userId) {
    return _col
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((s) => s.docs.map(_fromDoc).toList());
  }
}
