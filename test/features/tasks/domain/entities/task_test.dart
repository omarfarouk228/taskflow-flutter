import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/features/tasks/domain/entities/task.dart';

void main() {
  const baseTask = Task(
    id: '1',
    title: 'Test Task',
    projectId: 'p1',
    userId: 'u1',
  );

  group('Task entity', () {
    test('isCompleted est false par défaut', () {
      expect(baseTask.isCompleted, isFalse);
    });

    test('markDone() change le statut en done', () {
      final done = baseTask.markDone();
      expect(done.isCompleted, isTrue);
      expect(done.status, equals(TaskStatus.done));
      expect(done.completedAt, isNotNull);
    });

    test('markTodo() réinitialise le statut', () {
      final done = baseTask.markDone();
      final todo = done.markTodo();
      expect(todo.isCompleted, isFalse);
      expect(todo.completedAt, isNull);
    });

    test('isOverdue est true si date passée et non terminée', () {
      final overdue = baseTask.copyWith(
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
      );
      expect(overdue.isOverdue, isTrue);
    });

    test('isOverdue est false si tâche terminée même si date passée', () {
      final done = baseTask
          .copyWith(dueDate: DateTime.now().subtract(const Duration(days: 1)))
          .markDone();
      expect(done.isOverdue, isFalse);
    });

    test('isDueToday est true si échéance aujourd\'hui', () {
      final today = baseTask.copyWith(dueDate: DateTime.now());
      expect(today.isDueToday, isTrue);
    });

    test('isDueToday est false si échéance demain', () {
      final tomorrow = baseTask.copyWith(
        dueDate: DateTime.now().add(const Duration(days: 1)),
      );
      expect(tomorrow.isDueToday, isFalse);
    });

    test('Priority a le bon label', () {
      expect(Priority.low.label, equals('Basse'));
      expect(Priority.medium.label, equals('Moyenne'));
      expect(Priority.high.label, equals('Haute'));
      expect(Priority.critical.label, equals('Critique'));
    });
  });
}
