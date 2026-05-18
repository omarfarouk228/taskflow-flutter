// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskRepository)
final taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'c0c3885ce12e10ab0e52f5af2e4cbf4d7df22e47';

@ProviderFor(createTaskUseCase)
final createTaskUseCaseProvider = CreateTaskUseCaseProvider._();

final class CreateTaskUseCaseProvider
    extends
        $FunctionalProvider<
          CreateTaskUseCase,
          CreateTaskUseCase,
          CreateTaskUseCase
        >
    with $Provider<CreateTaskUseCase> {
  CreateTaskUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateTaskUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateTaskUseCase create(Ref ref) {
    return createTaskUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTaskUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTaskUseCase>(value),
    );
  }
}

String _$createTaskUseCaseHash() => r'7c4abe1d5a23b971a733aa23ff51144afae82656';

@ProviderFor(tasksStream)
final tasksStreamProvider = TasksStreamFamily._();

final class TasksStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          Stream<List<Task>>
        >
    with $FutureModifier<List<Task>>, $StreamProvider<List<Task>> {
  TasksStreamProvider._({
    required TasksStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tasksStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tasksStreamHash();

  @override
  String toString() {
    return r'tasksStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Task>> create(Ref ref) {
    final argument = this.argument as String;
    return tasksStream(ref, projectId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tasksStreamHash() => r'e088b374edb2838b90a72e75df68f877d582bba2';

final class TasksStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Task>>, String> {
  TasksStreamFamily._()
    : super(
        retry: null,
        name: r'tasksStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TasksStreamProvider call({required String projectId}) =>
      TasksStreamProvider._(argument: projectId, from: this);

  @override
  String toString() => r'tasksStreamProvider';
}

@ProviderFor(TasksNotifier)
final tasksProvider = TasksNotifierFamily._();

final class TasksNotifierProvider
    extends $AsyncNotifierProvider<TasksNotifier, List<Task>> {
  TasksNotifierProvider._({
    required TasksNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tasksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tasksNotifierHash();

  @override
  String toString() {
    return r'tasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TasksNotifier create() => TasksNotifier();

  @override
  bool operator ==(Object other) {
    return other is TasksNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tasksNotifierHash() => r'd6cb908f0bb34418ea29ce6f18699cc887600dc8';

final class TasksNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TasksNotifier,
          AsyncValue<List<Task>>,
          List<Task>,
          FutureOr<List<Task>>,
          String
        > {
  TasksNotifierFamily._()
    : super(
        retry: null,
        name: r'tasksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TasksNotifierProvider call({required String projectId}) =>
      TasksNotifierProvider._(argument: projectId, from: this);

  @override
  String toString() => r'tasksProvider';
}

abstract class _$TasksNotifier extends $AsyncNotifier<List<Task>> {
  late final _$args = ref.$arg as String;
  String get projectId => _$args;

  FutureOr<List<Task>> build({required String projectId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Task>>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Task>>, List<Task>>,
              AsyncValue<List<Task>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(projectId: _$args));
  }
}

@ProviderFor(TaskFilterNotifier)
final taskFilterProvider = TaskFilterNotifierProvider._();

final class TaskFilterNotifierProvider
    extends $NotifierProvider<TaskFilterNotifier, TaskFilter> {
  TaskFilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskFilterNotifierHash();

  @$internal
  @override
  TaskFilterNotifier create() => TaskFilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskFilter>(value),
    );
  }
}

String _$taskFilterNotifierHash() =>
    r'f7852eee7a9da49b8f4f7bc3f941e699115aafc7';

abstract class _$TaskFilterNotifier extends $Notifier<TaskFilter> {
  TaskFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TaskFilter, TaskFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskFilter, TaskFilter>,
              TaskFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredTasks)
final filteredTasksProvider = FilteredTasksFamily._();

final class FilteredTasksProvider
    extends $FunctionalProvider<List<Task>, List<Task>, List<Task>>
    with $Provider<List<Task>> {
  FilteredTasksProvider._({
    required FilteredTasksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredTasksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredTasksHash();

  @override
  String toString() {
    return r'filteredTasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Task> create(Ref ref) {
    final argument = this.argument as String;
    return filteredTasks(ref, projectId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Task> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Task>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredTasksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredTasksHash() => r'3c5ff1ee8aca846a74e64f8fe984f4da97473e8b';

final class FilteredTasksFamily extends $Family
    with $FunctionalFamilyOverride<List<Task>, String> {
  FilteredTasksFamily._()
    : super(
        retry: null,
        name: r'filteredTasksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredTasksProvider call({required String projectId}) =>
      FilteredTasksProvider._(argument: projectId, from: this);

  @override
  String toString() => r'filteredTasksProvider';
}

@ProviderFor(tasksDueToday)
final tasksDueTodayProvider = TasksDueTodayProvider._();

final class TasksDueTodayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          FutureOr<List<Task>>
        >
    with $FutureModifier<List<Task>>, $FutureProvider<List<Task>> {
  TasksDueTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksDueTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksDueTodayHash();

  @$internal
  @override
  $FutureProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Task>> create(Ref ref) {
    return tasksDueToday(ref);
  }
}

String _$tasksDueTodayHash() => r'604a251a8c03ade114cc42e9756a392fc6786429';
