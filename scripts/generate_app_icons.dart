import 'dart:io';

void main() async {
  // Create directories if they don't exist
  await _createDirectories();

  // Generate Android icons
  await _generateAndroidIcons();

  // Generate iOS icons
  await _generateIOSIcons();

  // Generate Web icons
  await _generateWebIcons();
}

Future<void> _createDirectories() async {
  final directories = [
    'android/app/src/main/res/mipmap-hdpi',
    'android/app/src/main/res/mipmap-mdpi',
    'android/app/src/main/res/mipmap-xhdpi',
    'android/app/src/main/res/mipmap-xxhdpi',
    'android/app/src/main/res/mipmap-xxxhdpi',
    'ios/Runner/Assets.xcassets/AppIcon.appiconset',
    'web/icons',
  ];

  for (final dir in directories) {
    await Directory(dir).create(recursive: true);
  }
}

Future<void> _generateAndroidIcons() async {
  final sizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
  };

  for (final entry in sizes.entries) {
    final size = entry.value;
    const fileName = 'ic_launcher.png';
    final outputPath = 'android/app/src/main/res/${entry.key}/$fileName';

    // Generate icon using a simple gradient design
    await _generateIcon(outputPath, size);
  }
}

Future<void> _generateIOSIcons() async {
  final sizes = [20, 29, 40, 58, 60, 76, 80, 87, 120, 152, 167, 180, 1024];

  for (final size in sizes) {
    final fileName = 'Icon-App-${size}x$size@1x.png';
    final outputPath =
        'ios/Runner/Assets.xcassets/AppIcon.appiconset/$fileName';

    await _generateIcon(outputPath, size);
  }
}

Future<void> _generateWebIcons() async {
  final sizes = [192, 512];

  for (final size in sizes) {
    final fileName = 'Icon-$size.png';
    final outputPath = 'web/icons/$fileName';

    await _generateIcon(outputPath, size);
  }

  // Generate maskable icons
  for (final size in sizes) {
    final fileName = 'Icon-maskable-$size.png';
    final outputPath = 'web/icons/$fileName';

    await _generateIcon(outputPath, size);
  }
}

Future<void> _generateIcon(String outputPath, int size) async {
  // Create a simple gradient icon programmatically

  // For now, we'll create a placeholder file
  // In a real implementation, you'd use a library like flutter_svg or dart:ui to convert SVG to PNG
  final file = File(outputPath);
  await file.writeAsString('Generated icon for size $size');
}
