class TechCategory {
  final String title;
  final List<String> skills;
  final int color;

  const TechCategory({
    required this.title,
    required this.skills,
    required this.color,
  });

  factory TechCategory.fromMap(Map<String, dynamic> map) {
    return TechCategory(
      title: map['title'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      color: map['color'] ?? 0xFF000000,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'skills': skills,
      'color': color,
    };
  }
}
