import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/task.dart';
import '../providers/tasks_provider.dart';
import '../widgets/priority_badge.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;
  final Task? initialTask;

  const TaskDetailScreen({
    super.key,
    required this.taskId,
    this.initialTask,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Si on a la tâche en extra, l'utiliser directement
    // Sinon charger depuis le provider
    final task = initialTask;
    if (task == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete') {
                final confirm = await context.showConfirmDialog(
                  title: 'Supprimer la tâche',
                  content: 'Cette action est irréversible.',
                  confirmLabel: 'Supprimer',
                  isDestructive: true,
                );
                if (confirm == true && context.mounted) {
                  await ref
                      .read(tasksProvider(
                              projectId: task.projectId)
                          .notifier)
                      .deleteTask(task.id);
                  if (context.mounted) context.pop();
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                ]),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statut
              Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    shape: const CircleBorder(),
                    onChanged: (_) => ref
                        .read(tasksProvider(
                                projectId: task.projectId)
                            .notifier)
                        .toggleTask(task.id),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Chip(
                    label: Text(task.status.label),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Titre
              Text(
                task.title,
                style: context.texts.headlineMedium?.copyWith(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Description
              if (task.description.isNotEmpty) ...[
                Text('Description', style: context.texts.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(task.description, style: context.texts.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Métadonnées
              const Divider(),
              const SizedBox(height: AppSpacing.md),

              _MetaTile(
                icon: Icons.flag_outlined,
                label: 'Priorité',
                child: PriorityBadge(priority: task.priority, showLabel: true),
              ),

              if (task.dueDate != null)
                _MetaTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Échéance',
                  child: Text(
                    task.dueDate!.formatted,
                    style: TextStyle(
                      color: task.isOverdue ? Colors.red : null,
                      fontWeight: task.isOverdue ? FontWeight.w600 : null,
                    ),
                  ),
                ),

              if (task.createdAt != null)
                _MetaTile(
                  icon: Icons.access_time,
                  label: 'Créée le',
                  child: Text(task.createdAt!.formatted),
                ),

              if (task.completedAt != null)
                _MetaTile(
                  icon: Icons.check_circle_outline,
                  label: 'Terminée le',
                  child: Text(task.completedAt!.formatted),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ref
            .read(tasksProvider(projectId: task.projectId).notifier)
            .toggleTask(task.id),
        icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
        label: Text(task.isCompleted ? 'Remettre à faire' : 'Marquer terminée'),
      ),
    );
  }
}

class _MetaTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _MetaTile({
    required this.icon,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: context.texts.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
