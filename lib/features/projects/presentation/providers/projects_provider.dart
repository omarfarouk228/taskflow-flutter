import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/repositories/project_repository_impl.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

part 'projects_provider.g.dart';

@riverpod
ProjectRepository projectRepository(Ref ref) =>
    ProjectRepositoryImpl();

@riverpod
Stream<List<Project>> projectsStream(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();
  return ref.watch(projectRepositoryProvider).watchProjects(user.uid);
}

@riverpod
class ProjectsNotifier extends _$ProjectsNotifier {
  @override
  Future<List<Project>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];
    return ref.watch(projectRepositoryProvider).getProjects(user.uid);
  }

  Future<Project> createProject({
    required String title,
    String description = '',
    int colorValue = 0xFF0553B1,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) throw Exception('Non authentifié');

    final project = Project(
      id: const Uuid().v4(),
      title: title,
      userId: user.uid,
      description: description,
      colorValue: colorValue,
      createdAt: DateTime.now(),
    );

    final created =
        await ref.read(projectRepositoryProvider).createProject(project);
    state = AsyncData([created, ...?state.value]);
    return created;
  }

  Future<void> deleteProject(String projectId) async {
    final current = state.value ?? [];
    state = AsyncData(current.where((p) => p.id != projectId).toList());
    try {
      await ref.read(projectRepositoryProvider).deleteProject(projectId);
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }
}
