import 'package:cloud_firestore/cloud_firestore.dart';

class ContactMessage {
  final String? id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const ContactMessage({
    this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  factory ContactMessage.fromMap(Map<String, dynamic> map, [String? docId]) {
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      if (val is int) return DateTime.fromMillisecondsSinceEpoch(val);
      return DateTime.now();
    }

    return ContactMessage(
      id: docId ?? map['id'] as String?,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      message: map['message'] as String? ?? '',
      createdAt: parseDate(map['createdAt']),
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'createdAt': Timestamp.fromDate(createdAt),
      'isRead': isRead,
    };
  }

  ContactMessage copyWith({
    String? id,
    String? name,
    String? email,
    String? message,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return ContactMessage(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
