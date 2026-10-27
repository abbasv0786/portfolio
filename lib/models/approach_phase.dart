import 'package:get/get.dart';

class ApproachPhase {
  final String? id;
  final int phaseNumber;
  final String title;
  final String description;
  final String icon;
  final String duration;
  final List<String> details;
  final int color;
  final int order;
  final RxBool isExpanded = false.obs;

  ApproachPhase({
    this.id,
    required this.phaseNumber,
    required this.title,
    required this.description,
    required this.icon,
    required this.duration,
    required this.details,
    required this.color,
    this.order = 0,
  });

  factory ApproachPhase.fromMap(Map<String, dynamic> map, [String? docId]) {
    return ApproachPhase(
      id: docId ?? map['id']?.toString(),
      phaseNumber: map['phaseNumber'] as int? ?? (map['id'] is int ? map['id'] as int : 0),
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
      duration: map['duration'] as String? ?? '',
      details: List<String>.from(map['details'] ?? []),
      color: map['color'] as int? ?? 0xFF000000,
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phaseNumber': phaseNumber,
      'title': title,
      'description': description,
      'icon': icon,
      'duration': duration,
      'details': details,
      'color': color,
      'order': order,
    };
  }

  ApproachPhase copyWith({
    String? id,
    int? phaseNumber,
    String? title,
    String? description,
    String? icon,
    String? duration,
    List<String>? details,
    int? color,
    int? order,
  }) {
    return ApproachPhase(
      id: id ?? this.id,
      phaseNumber: phaseNumber ?? this.phaseNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      duration: duration ?? this.duration,
      details: details ?? this.details,
      color: color ?? this.color,
      order: order ?? this.order,
    );
  }
}
