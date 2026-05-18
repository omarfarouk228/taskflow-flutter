import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/features/tasks/domain/entities/task.dart';
import 'package:taskflow/features/tasks/presentation/widgets/task_list_tile.dart';
import 'package:taskflow/core/theme/app_theme.dart';

void main() {
  const mockTask = Task(
    id: '1',
    title: 'Terminer le rapport Q2',
    projectId: 'project-1',
    userId: 'user-1',
    priority: Priority.high,
    status: TaskStatus.todo,
  );

  Widget buildWidget(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('TaskListTile', () {
    testWidgets('affiche le titre de la tâche', (tester) async {
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: mockTask, onToggle: () {}, onTap: () {}),
        ),
      );

      expect(find.text('Terminer le rapport Q2'), findsOneWidget);
    });

    testWidgets('affiche une checkbox non cochée pour une tâche à faire', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: mockTask, onToggle: () {}, onTap: () {}),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('affiche une checkbox cochée pour une tâche terminée', (
      tester,
    ) async {
      final doneTask = mockTask.markDone();
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: doneTask, onToggle: () {}, onTap: () {}),
        ),
      );

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('appelle onToggle quand on tape la checkbox', (tester) async {
      bool toggled = false;
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(
            task: mockTask,
            onToggle: () => toggled = true,
            onTap: () {},
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(toggled, isTrue);
    });

    testWidgets('appelle onTap quand on tape la tuile', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(
            task: mockTask,
            onToggle: () {},
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(InkWell).first);
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('affiche la date d\'échéance si présente', (tester) async {
      final taskWithDate = mockTask.copyWith(dueDate: DateTime(2025, 12, 25));
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: taskWithDate, onToggle: () {}, onTap: () {}),
        ),
      );

      // La date formatée doit apparaître
      expect(find.textContaining('25'), findsWidgets);
    });

    testWidgets('affiche la description si présente', (tester) async {
      final taskWithDesc = mockTask.copyWith(
        description: 'Analyser les données Q2',
      );
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: taskWithDesc, onToggle: () {}, onTap: () {}),
        ),
      );

      expect(find.text('Analyser les données Q2'), findsOneWidget);
    });

    testWidgets('texte barré pour une tâche terminée', (tester) async {
      final doneTask = mockTask.markDone();
      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: doneTask, onToggle: () {}, onTap: () {}),
        ),
      );

      final texts = tester.widgetList<Text>(
        find.text('Terminer le rapport Q2'),
      );
      final hasStrikethrough = texts.any(
        (t) => t.style?.decoration == TextDecoration.lineThrough,
      );
      expect(hasStrikethrough, isTrue);
    });

    testWidgets('passe les guidelines d\'accessibilité', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        buildWidget(
          TaskListTile(task: mockTask, onToggle: () {}, onTap: () {}),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });
  });
}
