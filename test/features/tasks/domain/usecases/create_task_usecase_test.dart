import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:taskflow/features/tasks/domain/entities/task.dart';
import 'package:taskflow/features/tasks/domain/repositories/task_repository.dart';
import 'package:taskflow/features/tasks/domain/usecases/create_task_usecase.dart';
import 'package:taskflow/core/error/exceptions.dart';

@GenerateMocks([TaskRepository])
import 'create_task_usecase_test.mocks.dart';

void main() {
  late CreateTaskUseCase sut;
  late MockTaskRepository mockRepo;

  setUp(() {
    mockRepo = MockTaskRepository();
    sut = CreateTaskUseCase(mockRepo);
  });

  // Helper
  CreateTaskParams validParams({String title = 'Ma tâche'}) => CreateTaskParams(
    title: title,
    projectId: 'project-1',
    userId: 'user-1',
    priority: Priority.medium,
  );

  Task fakeTask(CreateTaskParams p) => Task(
    id: 'task-1',
    title: p.title.trim(),
    projectId: p.projectId,
    userId: p.userId,
    priority: p.priority,
  );

  group('CreateTaskUseCase - Succès', () {
    test('retourne la tâche créée', () async {
      final params = validParams();
      final expected = fakeTask(params);
      when(mockRepo.createTask(any)).thenAnswer((_) async => expected);

      final result = await sut(params);

      expect(result.title, equals('Ma tâche'));
      expect(result.projectId, equals('project-1'));
      verify(mockRepo.createTask(any)).called(1);
    });

    test('trim le titre avant la création', () async {
      final params = validParams(title: '  Rapport Q2  ');
      when(mockRepo.createTask(any)).thenAnswer((inv) async {
        final task = inv.positionalArguments[0] as Task;
        return task;
      });

      final result = await sut(params);
      expect(result.title, equals('Rapport Q2'));
    });

    test('assigne la priorité correctement', () async {
      const params = CreateTaskParams(
        title: 'Urgent',
        projectId: 'p1',
        userId: 'u1',
        priority: Priority.critical,
      );
      when(mockRepo.createTask(any)).thenAnswer((inv) async {
        return inv.positionalArguments[0] as Task;
      });

      final result = await sut(params);
      expect(result.priority, equals(Priority.critical));
    });

    test('n\'appelle pas le repo si la date est valide', () async {
      final params = CreateTaskParams(
        title: 'Tâche future',
        projectId: 'p1',
        userId: 'u1',
        dueDate: DateTime.now().add(const Duration(days: 1)),
      );
      when(mockRepo.createTask(any)).thenAnswer((inv) async {
        return inv.positionalArguments[0] as Task;
      });

      final result = await sut(params);
      expect(result.dueDate, isNotNull);
    });
  });

  group('CreateTaskUseCase - Validation', () {
    test('lève ValidationException si titre vide', () async {
      expect(
        () => sut(validParams(title: '')),
        throwsA(isA<ValidationException>()),
      );
      verifyNever(mockRepo.createTask(any));
    });

    test(
      'lève ValidationException si titre contient seulement des espaces',
      () async {
        expect(
          () => sut(validParams(title: '    ')),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test('lève ValidationException si date dans le passé', () {
      final params = CreateTaskParams(
        title: 'Tâche passée',
        projectId: 'p1',
        userId: 'u1',
        dueDate: DateTime.now().subtract(const Duration(hours: 2)),
      );
      expect(() => sut(params), throwsA(isA<ValidationException>()));
      verifyNever(mockRepo.createTask(any));
    });

    test('lève ValidationException si titre trop long', () {
      expect(
        () => sut(validParams(title: 'A' * 201)),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('CreateTaskUseCase - Erreurs réseau', () {
    test('propage les exceptions du repository', () async {
      when(
        mockRepo.createTask(any),
      ).thenThrow(const NetworkException('Pas de connexion'));

      expect(() => sut(validParams()), throwsA(isA<NetworkException>()));
    });
  });
}
