import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/presentation/providers/tasks_provider.dart';
import '../../../tasks/presentation/widgets/task_list_skeleton.dart';
import '../../../tasks/presentation/widgets/task_list_tile.dart';
import '../providers/projects_provider.dart';

class ProjectDetailScreen extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsProvider);
    final project = projectsAsync.value
        ?.firstWhere((p) => p.id == widget.projectId, orElse: () => throw '');

    final tasksAsync = ref.watch(
      tasksProvider(projectId: widget.projectId),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // En-tête coloré
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: project?.color,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                project?.title ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: project != null
                      ? LinearGradient(
                          colors: [project.color, project.color.withValues(alpha: 0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                ),
                child: project != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: AppSpacing.lg,
                          bottom: 56,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${project.taskCount} tâche${project.taskCount > 1 ? "s" : ""}  •  ${project.progressPercent}% terminé',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () => context.goNamed(
                  AppRoutes.addTask,
                  pathParameters: {'projectId': widget.projectId},
                ),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              tabs: const [
                Tab(text: 'À faire'),
                Tab(text: 'En cours'),
                Tab(text: 'Terminées'),
              ],
            ),
          ),

          // Contenu par onglet
          SliverFillRemaining(
            child: tasksAsync.when(
              loading: () => const TaskListSkeleton(),
              error: (e, _) => Center(child: Text('Erreur : $e')),
              data: (tasks) => TabBarView(
                controller: _tabController,
                children: [
                  _TaskTab(
                    tasks: tasks.where((t) => t.status == TaskStatus.todo).toList(),
                    projectId: widget.projectId,
                  ),
                  _TaskTab(
                    tasks: tasks.where((t) => t.status == TaskStatus.inProgress).toList(),
                    projectId: widget.projectId,
                  ),
                  _TaskTab(
                    tasks: tasks.where((t) => t.status == TaskStatus.done).toList(),
                    projectId: widget.projectId,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTab extends ConsumerWidget {
  final List<Task> tasks;
  final String projectId;
  const _TaskTab({required this.tasks, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt,
                size: 48, color: context.colors.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            Text('Aucune tâche ici',
                style: context.texts.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref
          .read(tasksProvider(projectId: projectId).notifier)
          .refresh(),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, i) => TaskListTile(
          task: tasks[i],
          onToggle: () => ref
              .read(tasksProvider(projectId: projectId).notifier)
              .toggleTask(tasks[i].id),
          onTap: () => context.goNamed(
            AppRoutes.taskDetail,
            pathParameters: {
              'projectId': projectId,
              'taskId': tasks[i].id,
            },
            extra: tasks[i],
          ),
          onDelete: () => ref
              .read(tasksProvider(projectId: projectId).notifier)
              .deleteTask(tasks[i].id),
        ),
      ),
    );
  }
}
