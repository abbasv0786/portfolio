class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? iOSUrl;
  final String? androidUrl;
  final String? liveUrl;

  final String? category;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.iOSUrl,
    this.androidUrl,
    this.liveUrl,
    this.category,
  });
}
