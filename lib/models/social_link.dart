class SocialLink {
  final String name;
  final String url;
  final String icon;
  final String username;

  const SocialLink({
    required this.name,
    required this.url,
    required this.icon,
    required this.username,
  });

  factory SocialLink.fromMap(Map<String, String> map) {
    return SocialLink(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      icon: map['icon'] ?? '',
      username: map['username'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'url': url,
      'icon': icon,
      'username': username,
    };
  }
}
