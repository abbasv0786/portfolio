class AppAssets {
  // Prevent instantiation
  AppAssets._();

  // Base paths
  static const String _imagesPath = 'assets/images/';

  // Profile images
  static const String profileImage = '${_imagesPath}profile.jpg';
  static const String profilePlaceholder =
      '${_imagesPath}profile_placeholder.png';

  // Project images
  static const String expenseTrackerImage = '${_imagesPath}expense_tracker.jpg';
  static const String weatherAppImage = '${_imagesPath}weather_app.jpg';
  static const String carSlayerImage = '${_imagesPath}car_slayer.jpg';
  static const String stakifyImage = '${_imagesPath}stakify.jpg';

  // Placeholder URLs (temporary - replace with actual assets)
  static const String profileImageUrl =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=96&h=96&fit=crop&crop=face';
  static const String expenseTrackerUrl =
      'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800&h=600&fit=crop';
  static const String weatherAppUrl =
      'https://images.unsplash.com/photo-1592210454359-9043f067919b?w=800&h=600&fit=crop';
  static const String carSlayerUrl =
      'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800&h=600&fit=crop';
  static const String stakifyUrl =
      'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=800&h=600&fit=crop';
}
