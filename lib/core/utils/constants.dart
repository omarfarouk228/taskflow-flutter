/// Constantes globales de l'application
abstract class AppConstants {
  // Nom de l'app
  static const String appName = 'TaskFlow';
  static const String appVersion = '1.0.0';
  static const String appBuild = '1';

  // URLs
  static const String apiBaseUrl = 'https://api.taskflow.dev/v1';
  static const String privacyUrl = 'https://taskflow.kofcorp.com/privacy';
  static const String termsUrl = 'https://taskflow.kofcorp.com/terms';

  // Firestore collections
  static const String tasksCollection = 'tasks';
  static const String projectsCollection = 'projects';
  static const String usersCollection = 'users';

  // SharedPreferences keys
  static const String kThemeKey = 'theme_mode';
  static const String kOnboardingKey = 'onboarding_done';
  static const String kNotificationsKey = 'notifications_enabled';

  // Limites
  static const int maxTaskTitleLength = 200;
  static const int maxDescriptionLength = 2000;
  static const int maxProjectsPerUser = 50;
  static const int maxTasksPerProject = 500;

  // Durées
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);
  static const Duration apiTimeout = Duration(seconds: 10);
  static const Duration cacheExpiry = Duration(hours: 24);
}

/// Couleurs de priorité (indépendantes du thème)
abstract class PriorityColors {
  static const low = 0xFF4CAF50;      // Vert
  static const medium = 0xFF2196F3;   // Bleu
  static const high = 0xFFFF9800;     // Orange
  static const critical = 0xFFF44336; // Rouge
}

/// Couleurs de projet disponibles
abstract class ProjectColors {
  static const List<int> palette = [
    0xFF0553B1, // Flutter Blue
    0xFF7C3AED, // Violet
    0xFF059669, // Vert émeraude
    0xFFDC2626, // Rouge
    0xFFD97706, // Orange ambre
    0xFF0891B2, // Cyan
    0xFFDB2777, // Rose
    0xFF65A30D, // Vert lime
    0xFF4F46E5, // Indigo
    0xFF0F766E, // Teal
  ];
}
