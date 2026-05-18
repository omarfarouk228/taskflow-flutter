import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';

class PriorityBadge extends StatelessWidget {
  final Priority priority;
  final bool showLabel;

  const PriorityBadge({
    super.key,
    required this.priority,
    this.showLabel = false,
  });

  Color _color(BuildContext context) => switch (priority) {
        Priority.low => Colors.green,
        Priority.medium => Colors.blue,
        Priority.high => Colors.orange,
        Priority.critical => Colors.red,
      };

  IconData get _icon => switch (priority) {
        Priority.low => Icons.arrow_downward,
        Priority.medium => Icons.remove,
        Priority.high => Icons.arrow_upward,
        Priority.critical => Icons.priority_high,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color(context);

    if (showLabel) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              priority.label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Semantics(
      label: 'Priorité ${priority.label}',
      child: Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
