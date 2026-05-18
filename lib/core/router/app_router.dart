import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/projects/presentation/pages/project_detail_screen.dart';
import '../../features/projects/presentation/pages/projects_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/tasks/domain/entities/task.dart';
import '../../features/tasks/presentation/pages/add_task_screen.dart';
import '../../features/tasks/presentation/pages/task_detail_screen.dart';
import '../shell/scaffold_with_nav.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const login = 'login';
  static const register = 'register';
  static const home = 'home';
  static const projects = 'projects';
  static const projectDetail = 'project-detail';
  static const taskDetail = 'task-detail';
  static const addTask = 'add-task';
  static const settings = 'settings';
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/home';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authRepositoryProvider).authStateChanges,
    ),
    routes: [
      // Auth routes
      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),

      // Shell: tab navigation
      ShellRoute(
        builder: (context, state, child) =>
            ScaffoldWithNav(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: AppRoutes.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: '/projects',
            name: AppRoutes.projects,
            builder: (_, __) => const ProjectsScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: AppRoutes.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),

      // Project detail (outside shell, full screen)
      GoRoute(
        path: '/project/:projectId',
        name: AppRoutes.projectDetail,
        builder: (context, state) => ProjectDetailScreen(
          projectId: state.pathParameters['projectId']!,
        ),
        routes: [
          GoRoute(
            path: 'task/new',
            name: AppRoutes.addTask,
            builder: (context, state) => AddTaskScreen(
              projectId: state.pathParameters['projectId']!,
            ),
          ),
          GoRoute(
            path: 'task/:taskId',
            name: AppRoutes.taskDetail,
            builder: (context, state) {
              final task = state.extra as Task?;
              return TaskDetailScreen(
                taskId: state.pathParameters['taskId']!,
                initialTask: task,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page introuvable: ${state.error}'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper: rafraîchir GoRouter quand un Stream émet
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
