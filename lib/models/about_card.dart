class AboutCard {
  final String? id;
  final String title;
  final String description;
  final String icon;
  final int order;

  const AboutCard({
    this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.order = 0,
  });

  factory AboutCard.fromMap(Map<String, dynamic> map, [String? docId]) {
    return AboutCard(
      id: docId ?? map['id'] as String?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'order': order,
    };
  }

  AboutCard copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    int? order,
  }) {
    return AboutCard(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      order: order ?? this.order,
    );
  }
}
