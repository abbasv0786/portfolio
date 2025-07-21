class Experience {
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> technologies;
  final String companyUrl;
  final String? location;
  final String? type;

  const Experience({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.companyUrl,
    this.location,
    this.type,
  });
}
