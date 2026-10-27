class Experience {
  final String? id;
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> technologies;
  final String companyUrl;
  final String? location;
  final String? type;
  final int order;

  const Experience({
    this.id,
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.companyUrl,
    this.location,
    this.type,
    this.order = 0,
  });

  factory Experience.fromMap(Map<String, dynamic> map, [String? docId]) {
    return Experience(
      id: docId ?? map['id'] as String?,
      company: map['company'] as String? ?? '',
      position: map['position'] as String? ?? '',
      duration: map['duration'] as String? ?? '',
      description: map['description'] as String? ?? '',
      technologies: List<String>.from(map['technologies'] ?? []),
      companyUrl: map['companyUrl'] as String? ?? '',
      location: map['location'] as String?,
      type: map['type'] as String?,
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'position': position,
      'duration': duration,
      'description': description,
      'technologies': technologies,
      'companyUrl': companyUrl,
      'location': location,
      'type': type,
      'order': order,
    };
  }

  Experience copyWith({
    String? id,
    String? company,
    String? position,
    String? duration,
    String? description,
    List<String>? technologies,
    String? companyUrl,
    String? location,
    String? type,
    int? order,
  }) {
    return Experience(
      id: id ?? this.id,
      company: company ?? this.company,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      companyUrl: companyUrl ?? this.companyUrl,
      location: location ?? this.location,
      type: type ?? this.type,
      order: order ?? this.order,
    );
  }
}
