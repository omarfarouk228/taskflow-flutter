import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/task.dart';
import 'priority_badge.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const TaskListTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: onDelete != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await context.showConfirmDialog(
          title: 'Supprimer la tâche',
          content: 'Cette action est irréversible.',
          confirmLabel: 'Supprimer',
          isDestructive: true,
        );
      },
      onDismissed: (_) => onDelete?.call(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox avec Semantics
              Semantics(
                label:
                    '${task.isCompleted ? "Marquer comme non terminée" : "Marquer comme terminée"}: ${task.title}',
                button: true,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => onToggle(),
                      shape: const CircleBorder(),
                      side: BorderSide(
                        color: task.isOverdue
                            ? Colors.red
                            : context.colors.outline,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Titre + infos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      task.title,
                      style: context.texts.bodyMedium?.copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted
                            ? context.colors.onSurfaceVariant
                            : null,
                        fontWeight: task.priority == Priority.critical ||
                                task.priority == Priority.high
                            ? FontWeight.w600
                            : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        task.description,
                        style: context.texts.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (task.dueDate != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: task.isOverdue
                                ? Colors.red
                                : context.colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.dueDate!.formatted,
                            style: context.texts.labelSmall?.copyWith(
                              color: task.isOverdue
                                  ? Colors.red
                                  : context.colors.onSurfaceVariant,
                              fontWeight: task.isOverdue ? FontWeight.w600 : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Badge priorité
              const SizedBox(width: AppSpacing.sm),
              PriorityBadge(priority: task.priority),
            ],
          ),
        ),
      ),
    );
  }
}
