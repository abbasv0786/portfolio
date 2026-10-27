class ProfileInfo {
  final String? id;
  final String name;
  final String title;
  final String subtitle;
  final String tagline;
  final String description;
  final String location;
  final String availability;
  final String email;
  final String phone;
  final String whatsapp;
  final String discord;
  final String telegram;
  final String linkedin;
  final String twitter;
  final String instagram;
  final String github;
  final String portfolioUrl;
  final String cvUrl;
  final String profileImageUrl;
  final String footerDescription;
  final String footerCopyright;
  final String yearsOfExperience;
  final String completedProjects;
  final List<String> typingWords;

  const ProfileInfo({
    this.id,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.tagline,
    required this.description,
    required this.location,
    required this.availability,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.discord,
    required this.telegram,
    required this.linkedin,
    required this.twitter,
    required this.instagram,
    required this.github,
    required this.portfolioUrl,
    required this.cvUrl,
    this.profileImageUrl = '',
    required this.footerDescription,
    required this.footerCopyright,
    required this.yearsOfExperience,
    required this.completedProjects,
    required this.typingWords,
  });

  factory ProfileInfo.fromMap(Map<String, dynamic> map, [String? docId]) {
    return ProfileInfo(
      id: docId ?? map['id'] as String?,
      name: map['name'] as String? ?? 'AhemadAbbas Vagh',
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      tagline: map['tagline'] as String? ?? '',
      description: map['description'] as String? ?? '',
      location: map['location'] as String? ?? 'Remote, Worldwide',
      availability: map['availability'] as String? ?? 'Available for new opportunities',
      email: map['email'] as String? ?? 'abbasv0786@gmail.com',
      phone: map['phone'] as String? ?? '+919714907429',
      whatsapp: map['whatsapp'] as String? ?? '+919714907429',
      discord: map['discord'] as String? ?? 'abbasv786',
      telegram: map['telegram'] as String? ?? '@AbbasV0786',
      linkedin: map['linkedin'] as String? ?? 'https://www.linkedin.com/in/ahemadabbas-vagh-b9a080171',
      twitter: map['twitter'] as String? ?? 'https://twitter.com/AhemadAbbasVagh',
      instagram: map['instagram'] as String? ?? 'https://www.instagram.com/ahemadabbasvagh',
      github: map['github'] as String? ?? 'https://github.com/abbasv0786',
      portfolioUrl: map['portfolioUrl'] as String? ?? 'https://abbasv0786.github.io/portfolio/#/ahemadabbas-vagh',
      cvUrl: map['cvUrl'] as String? ?? '',
      profileImageUrl: map['profileImageUrl'] as String? ?? '',
      footerDescription: map['footerDescription'] as String? ?? 'Passionate engineer driving complex implementations and building production-ready solutions.',
      footerCopyright: map['footerCopyright'] as String? ?? '© 2026 AhemadAbbas Vagh. All rights reserved.',
      yearsOfExperience: map['yearsOfExperience'] as String? ?? '8+',
      completedProjects: map['completedProjects'] as String? ?? '20+',
      typingWords: List<String>.from(map['typingWords'] ?? [
        'Forward Deployed Engineer',
        'Implementation & Integration Lead',
        'Python / JavaScript / SQL Developer',
        'AI-Native Platform Specialist',
        'Cross-Functional Technical Leader',
      ]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'subtitle': subtitle,
      'tagline': tagline,
      'description': description,
      'location': location,
      'availability': availability,
      'email': email,
      'phone': phone,
      'whatsapp': whatsapp,
      'discord': discord,
      'telegram': telegram,
      'linkedin': linkedin,
      'twitter': twitter,
      'instagram': instagram,
      'github': github,
      'portfolioUrl': portfolioUrl,
      'cvUrl': cvUrl,
      'profileImageUrl': profileImageUrl,
      'footerDescription': footerDescription,
      'footerCopyright': footerCopyright,
      'yearsOfExperience': yearsOfExperience,
      'completedProjects': completedProjects,
      'typingWords': typingWords,
    };
  }

  ProfileInfo copyWith({
    String? id,
    String? name,
    String? title,
    String? subtitle,
    String? tagline,
    String? description,
    String? location,
    String? availability,
    String? email,
    String? phone,
    String? whatsapp,
    String? discord,
    String? telegram,
    String? linkedin,
    String? twitter,
    String? instagram,
    String? github,
    String? portfolioUrl,
    String? cvUrl,
    String? profileImageUrl,
    String? footerDescription,
    String? footerCopyright,
    String? yearsOfExperience,
    String? completedProjects,
    List<String>? typingWords,
  }) {
    return ProfileInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      discord: discord ?? this.discord,
      telegram: telegram ?? this.telegram,
      linkedin: linkedin ?? this.linkedin,
      twitter: twitter ?? this.twitter,
      instagram: instagram ?? this.instagram,
      github: github ?? this.github,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      cvUrl: cvUrl ?? this.cvUrl,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      footerDescription: footerDescription ?? this.footerDescription,
      footerCopyright: footerCopyright ?? this.footerCopyright,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      completedProjects: completedProjects ?? this.completedProjects,
      typingWords: typingWords ?? this.typingWords,
    );
  }
}
