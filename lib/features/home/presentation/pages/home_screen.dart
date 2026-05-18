import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../projects/presentation/providers/projects_provider.dart';
import '../../../projects/presentation/widgets/project_card.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../../tasks/presentation/providers/tasks_provider.dart';
import '../../../tasks/presentation/widgets/task_list_skeleton.dart';
import '../../../tasks/presentation/widgets/task_list_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final projectsAsync = ref.watch(projectsProvider);
    final tasksTodayAsync = ref.watch(tasksDueTodayProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(projectsProvider);
            ref.invalidate(tasksDueTodayProvider);
          },
          child: CustomScrollView(
            slivers: [
              // ── En-tête ────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: context.colors.primaryContainer,
                            child: Text(
                              user?.initials ?? '?',
                              style: TextStyle(
                                color: context.colors.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bonjour,',
                                  style: context.texts.bodySmall?.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  user?.name ?? 'Utilisateur',
                                  style: context.texts.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // ── Stats rapides ────────────────────────
                      tasksTodayAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data: (tasks) => _StatsRow(tasks: tasks),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Section Projets ───────────────────────────────
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Projets', style: context.texts.titleMedium),
                          TextButton(
                            onPressed: () =>
                                context.goNamed(AppRoutes.projects),
                            child: const Text('Voir tout'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: projectsAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Erreur : $e')),
                        data: (projects) => projects.isEmpty
                            ? _EmptyProjects(
                                onAdd: () =>
                                    context.goNamed(AppRoutes.projects),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                ),
                                itemCount: projects.length,
                                itemBuilder: (_, i) => ProjectCard(
                                  project: projects[i],
                                  onTap: () => context.goNamed(
                                    AppRoutes.projectDetail,
                                    pathParameters: {
                                      'projectId': projects[i].id,
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section Tâches d'aujourd'hui ──────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.xl,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: Text(
                    "Tâches d'aujourd'hui",
                    style: context.texts.titleMedium,
                  ),
                ),
              ),

              tasksTodayAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: TaskListSkeleton(itemCount: 3),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: Center(child: Text('Erreur : $e')),
                ),
                data: (tasks) => tasks.isEmpty
                    ? const SliverToBoxAdapter(child: _EmptyTasks())
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, i) => TaskListTile(
                            task: tasks[i],
                            onToggle: () => ref
                                .read(
                                  tasksProvider(
                                    projectId: tasks[i].projectId,
                                  ).notifier,
                                )
                                .toggleTask(tasks[i].id),
                            onTap: () => context.goNamed(
                              AppRoutes.taskDetail,
                              pathParameters: {
                                'projectId': tasks[i].projectId,
                                'taskId': tasks[i].id,
                              },
                              extra: tasks[i],
                            ),
                          ),
                          childCount: tasks.length,
                        ),
                      ),
              ),

              const SliverPadding(
                padding: EdgeInsets.only(bottom: AppSpacing.xxl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<Task> tasks;
  const _StatsRow({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;
    final done = tasks.where((t) => t.isCompleted).length;
    final overdue = tasks.where((t) => t.isOverdue).length;

    return Row(
      children: [
        _StatCard(label: 'Aujourd\'hui', value: total, icon: Icons.today),
        const SizedBox(width: AppSpacing.sm),
        _StatCard(
          label: 'Terminées',
          value: done,
          icon: Icons.check_circle_outline,
          color: Colors.green,
        ),
        const SizedBox(width: AppSpacing.sm),
        _StatCard(
          label: 'En retard',
          value: overdue,
          icon: Icons.warning_amber_outlined,
          color: overdue > 0 ? Colors.red : null,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colors.primary;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: c.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: c, size: 20),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '$value',
              style: context.texts.headlineMedium?.copyWith(
                color: c,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: context.texts.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyProjects extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyProjects({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open,
            size: 40,
            color: context.colors.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Créer un projet'),
          ),
        ],
      ),
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Icon(Icons.task_alt, size: 48, color: context.colors.outlineVariant),
          const SizedBox(height: AppSpacing.md),
          Text(
            "Aucune tâche pour aujourd'hui 🎉",
            style: context.texts.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
