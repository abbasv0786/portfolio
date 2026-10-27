class Project {
  final String? id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? iOSUrl;
  final String? androidUrl;
  final String? liveUrl;
  final String? category;
  final int order;

  const Project({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.iOSUrl,
    this.androidUrl,
    this.liveUrl,
    this.category,
    this.order = 0,
  });

  factory Project.fromMap(Map<String, dynamic> map, [String? docId]) {
    return Project(
      id: docId ?? map['id'] as String?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      technologies: List<String>.from(map['technologies'] ?? []),
      iOSUrl: map['iOSUrl'] as String?,
      androidUrl: map['androidUrl'] as String?,
      liveUrl: map['liveUrl'] as String?,
      category: map['category'] as String?,
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'iOSUrl': iOSUrl,
      'androidUrl': androidUrl,
      'liveUrl': liveUrl,
      'category': category,
      'order': order,
    };
  }

  Project copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? technologies,
    String? iOSUrl,
    String? androidUrl,
    String? liveUrl,
    String? category,
    int? order,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      iOSUrl: iOSUrl ?? this.iOSUrl,
      androidUrl: androidUrl ?? this.androidUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      category: category ?? this.category,
      order: order ?? this.order,
    );
  }
}
