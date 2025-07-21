class RouteNames {
  // Prevent instantiation
  RouteNames._();

  // Main routes
  static const String splash = '/';
  static const String home = '/ahemadabbas-vagh';

  // Future routes (for potential expansion)
  static const String about = '/about';
  static const String projects = '/projects';
  static const String experience = '/experience';
  static const String contact = '/contact';
  static const String approach = '/approach';
  static const String profile = '/profile';

  // Dynamic routes (for future use)
  static String projectDetails(String projectId) => '/project/$projectId';
  static String experienceDetails(String experienceId) =>
      '/experience/$experienceId';
}
