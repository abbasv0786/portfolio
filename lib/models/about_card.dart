class AboutCard {
  final String title;
  final String description;
  final String icon;

  const AboutCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory AboutCard.fromMap(Map<String, String> map) {
    return AboutCard(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
    };
  }
}
