import 'package:get/get.dart';

class ApproachPhase {
  final int id;
  final String title;
  final String description;
  final String icon;
  final String duration;
  final List<String> details;
  final int color;
  final RxBool isExpanded = false.obs;

  ApproachPhase({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.duration,
    required this.details,
    required this.color,
  });

  factory ApproachPhase.fromMap(Map<String, dynamic> map) {
    return ApproachPhase(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
      duration: map['duration'] ?? '',
      details: List<String>.from(map['details'] ?? []),
      color: map['color'] ?? 0xFF000000,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'duration': duration,
      'details': details,
      'color': color,
    };
  }
}
