class TechCategory {
  final String? id;
  final String title;
  final List<String> skills;
  final int color;
  final int order;

  const TechCategory({
    this.id,
    required this.title,
    required this.skills,
    required this.color,
    this.order = 0,
  });

  factory TechCategory.fromMap(Map<String, dynamic> map, [String? docId]) {
    return TechCategory(
      id: docId ?? map['id'] as String?,
      title: map['title'] as String? ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      color: map['color'] as int? ?? 0xFF000000,
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'skills': skills,
      'color': color,
      'order': order,
    };
  }

  TechCategory copyWith({
    String? id,
    String? title,
    List<String>? skills,
    int? color,
    int? order,
  }) {
    return TechCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      skills: skills ?? this.skills,
      color: color ?? this.color,
      order: order ?? this.order,
    );
  }
}
