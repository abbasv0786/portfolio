class SocialLink {
  final String? id;
  final String name;
  final String url;
  final String icon;
  final String username;
  final int order;

  const SocialLink({
    this.id,
    required this.name,
    required this.url,
    required this.icon,
    required this.username,
    this.order = 0,
  });

  factory SocialLink.fromMap(Map<String, dynamic> map, [String? docId]) {
    return SocialLink(
      id: docId ?? map['id'] as String?,
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
      icon: map['icon'] as String? ?? '',
      username: map['username'] as String? ?? '',
      order: map['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'icon': icon,
      'username': username,
      'order': order,
    };
  }

  SocialLink copyWith({
    String? id,
    String? name,
    String? url,
    String? icon,
    String? username,
    int? order,
  }) {
    return SocialLink(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      username: username ?? this.username,
      order: order ?? this.order,
    );
  }
}
