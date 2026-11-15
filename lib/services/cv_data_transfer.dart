import 'dart:convert';

import '../models/experience.dart';
import '../models/profile_info.dart';
import '../models/project.dart';
import '../models/tech_category.dart';

/// Export / import of the CV-relevant data (profile headline & summary,
/// experience, projects and skill categories) as
/// JSON, so it can be tailored to a job description outside the app and
/// loaded back.
///
/// Import rules:
/// - An item is matched to an existing one by `id`, then by title
///   (experience: company), case-insensitive. Unmatched items are added as new.
/// - Only the fields present in the file are changed; missing fields keep
///   their current value (e.g. images, which are never exported).
/// - Nothing is ever deleted. Switch a project off with `"isActive": false`.
class CvDataTransfer {
  CvDataTransfer._();

  static const String format = 'portfolio-cv-data';
  static const int version = 1;

  static const String _notes =
      'Edit and import back via Admin > Projects > Import. Items match by id '
      '(then title). Missing fields keep their current value; images are not '
      'exported. Nothing is deleted on import: set "isActive": false to hide '
      'a project from the site and CV. Lower "order" shows first. Experience '
      'descriptions are "- " bullet lines; every bullet prints on the CV. '
      'The CV summary is profile.subtitle + profile.description.';

  // ───────────────────────── Export ─────────────────────────

  static String export({
    required List<Project> projects,
    required List<TechCategory> skills,
    List<Experience> experiences = const [],
    ProfileInfo? profile,
    DateTime? now,
  }) {
    final data = {
      'format': format,
      'version': version,
      'exportedAt': (now ?? DateTime.now()).toUtc().toIso8601String(),
      'notes': _notes,
      if (profile != null) 'profile': _profileToJson(profile),
      'experiences': experiences.map(_experienceToJson).toList(),
      'projects': projects.map(_projectToJson).toList(),
      'skills': skills.map(_skillToJson).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  static String fileName(DateTime now) {
    String two(int n) => n.toString().padLeft(2, '0');
    return 'cv-data-${now.year}-${two(now.month)}-${two(now.day)}.json';
  }

  static Map<String, dynamic> _projectToJson(Project p) => {
        if (p.id != null) 'id': p.id,
        'title': p.title,
        'isActive': p.isActive,
        'order': p.order,
        'category': p.category,
        'description': p.description,
        'technologies': p.technologies,
        'liveUrl': p.liveUrl,
        'androidUrl': p.androidUrl,
        'iOSUrl': p.iOSUrl,
      };

  static Map<String, dynamic> _profileToJson(ProfileInfo p) => {
        'title': p.title,
        'subtitle': p.subtitle,
        'tagline': p.tagline,
        'description': p.description,
        'typingWords': p.typingWords,
      };

  static Map<String, dynamic> _experienceToJson(Experience e) => {
        if (e.id != null) 'id': e.id,
        'company': e.company,
        'position': e.position,
        'duration': e.duration,
        'order': e.order,
        'location': e.location,
        'type': e.type,
        'companyUrl': e.companyUrl,
        'description': e.description,
        'technologies': e.technologies,
      };

  static Map<String, dynamic> _skillToJson(TechCategory c) => {
        if (c.id != null) 'id': c.id,
        'title': c.title,
        'order': c.order,
        'color': colorToHex(c.color),
        'skills': c.skills,
      };

  static String colorToHex(int color) =>
      '#${color.toRadixString(16).padLeft(8, '0').toUpperCase()}';

  // ───────────────────────── Import ─────────────────────────

  /// Parses [json] and works out what would change. Throws [FormatException]
  /// with a readable message when the file is not valid.
  static CvImportPlan plan(
    String json, {
    required List<Project> currentProjects,
    required List<TechCategory> currentSkills,
    List<Experience> currentExperiences = const [],
    ProfileInfo? currentProfile,
  }) {
    final Object? decoded;
    try {
      decoded = jsonDecode(json);
    } on FormatException catch (e) {
      throw FormatException('Not valid JSON: ${e.message}');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected a JSON object at the top level.');
    }
    final fmt = decoded['format'];
    if (fmt != null && fmt != format) {
      throw FormatException('Unknown file format "$fmt".');
    }
    const sections = ['profile', 'experiences', 'projects', 'skills'];
    if (!sections.any(decoded.containsKey)) {
      throw const FormatException('The file has no "profile", "experiences", '
          '"projects" or "skills" section.');
    }

    final projectItems = _list(decoded, 'projects');
    final skillItems = _list(decoded, 'skills');
    final experienceItems = _list(decoded, 'experiences');

    final rawProfile = decoded['profile'];
    if (rawProfile != null && rawProfile is! Map<String, dynamic>) {
      throw const FormatException('"profile" must be an object.');
    }
    if (rawProfile != null && currentProfile == null) {
      throw const FormatException('Profile is not loaded yet; try again.');
    }

    return CvImportPlan(
      profile: rawProfile == null
          ? null
          : _planProfile(rawProfile as Map<String, dynamic>, currentProfile!),
      experiences: [
        for (var i = 0; i < experienceItems.length; i++)
          _planExperience(experienceItems[i], i, currentExperiences),
      ],
      projects: [
        for (var i = 0; i < projectItems.length; i++)
          _planProject(projectItems[i], i, currentProjects),
      ],
      skills: [
        for (var i = 0; i < skillItems.length; i++)
          _planSkill(skillItems[i], i, currentSkills),
      ],
    );
  }

  static List<Map<String, dynamic>> _list(
      Map<String, dynamic> root, String key) {
    final raw = root[key];
    if (raw == null) return const [];
    if (raw is! List) throw FormatException('"$key" must be a list.');
    return [
      for (var i = 0; i < raw.length; i++)
        if (raw[i] is Map<String, dynamic>)
          raw[i] as Map<String, dynamic>
        else
          throw FormatException('$key[$i] must be an object.'),
    ];
  }

  static T? _match<T>(
    Map<String, dynamic> item,
    List<T> current,
    String? Function(T) idOf,
    String Function(T) titleOf, {
    String titleKey = 'title',
  }) {
    final id = item['id'];
    if (id is String && id.isNotEmpty) {
      for (final c in current) {
        if (idOf(c) == id) return c;
      }
    }
    final title = item[titleKey];
    if (title is String) {
      final t = title.trim().toLowerCase();
      for (final c in current) {
        if (titleOf(c).trim().toLowerCase() == t) return c;
      }
    }
    return null;
  }

  static ItemChange<Project> _planProject(
      Map<String, dynamic> item, int index, List<Project> current) {
    final where = 'projects[$index]';
    final r = _Reader(item, where);
    final existing =
        _match<Project>(item, current, (p) => p.id, (p) => p.title);

    if (existing == null) {
      final title = r.string('title');
      if (title == null || title.trim().isEmpty) {
        throw FormatException('$where: a new project needs a "title".');
      }
      final project = Project(
        title: title.trim(),
        description: r.string('description') ?? '',
        imageUrl: r.string('imageUrl') ?? '',
        technologies: r.stringList('technologies') ?? const [],
        category: r.nullableString('category'),
        order: r.integer('order') ?? 0,
        isActive: r.boolean('isActive') ?? true,
        liveUrl: r.nullableString('liveUrl'),
        androidUrl: r.nullableString('androidUrl'),
        iOSUrl: r.nullableString('iOSUrl'),
      );
      return ItemChange(ChangeKind.added, project, project.title, const []);
    }

    final merged = Project(
      id: existing.id,
      title: r.string('title')?.trim() ?? existing.title,
      description: r.string('description') ?? existing.description,
      imageUrl: r.string('imageUrl') ?? existing.imageUrl,
      technologies: r.stringList('technologies') ?? existing.technologies,
      category:
          r.has('category') ? r.nullableString('category') : existing.category,
      order: r.integer('order') ?? existing.order,
      isActive: r.boolean('isActive') ?? existing.isActive,
      liveUrl:
          r.has('liveUrl') ? r.nullableString('liveUrl') : existing.liveUrl,
      androidUrl: r.has('androidUrl')
          ? r.nullableString('androidUrl')
          : existing.androidUrl,
      iOSUrl: r.has('iOSUrl') ? r.nullableString('iOSUrl') : existing.iOSUrl,
    );

    final changed = <String>[
      if (merged.title != existing.title) 'title',
      if (merged.isActive != existing.isActive)
        merged.isActive ? 'switched on' : 'switched off',
      if (merged.order != existing.order) 'order',
      if (merged.category != existing.category) 'category',
      if (merged.description != existing.description) 'description',
      if (!_sameList(merged.technologies, existing.technologies))
        'technologies',
      if (merged.imageUrl != existing.imageUrl) 'image',
      if (merged.liveUrl != existing.liveUrl ||
          merged.androidUrl != existing.androidUrl ||
          merged.iOSUrl != existing.iOSUrl)
        'links',
    ];
    return ItemChange(
      changed.isEmpty ? ChangeKind.unchanged : ChangeKind.updated,
      merged,
      merged.title,
      changed,
    );
  }

  static ItemChange<TechCategory> _planSkill(
      Map<String, dynamic> item, int index, List<TechCategory> current) {
    final where = 'skills[$index]';
    final r = _Reader(item, where);
    final existing =
        _match<TechCategory>(item, current, (c) => c.id, (c) => c.title);

    if (existing == null) {
      final title = r.string('title');
      if (title == null || title.trim().isEmpty) {
        throw FormatException('$where: a new skill category needs a "title".');
      }
      final category = TechCategory(
        title: title.trim(),
        skills: r.stringList('skills') ?? const [],
        color: r.color('color') ?? 0xFF64FFDA,
        order: r.integer('order') ?? 0,
      );
      return ItemChange(ChangeKind.added, category, category.title, const []);
    }

    final merged = TechCategory(
      id: existing.id,
      title: r.string('title')?.trim() ?? existing.title,
      skills: r.stringList('skills') ?? existing.skills,
      color: r.color('color') ?? existing.color,
      order: r.integer('order') ?? existing.order,
    );
    final changed = <String>[
      if (merged.title != existing.title) 'title',
      if (merged.order != existing.order) 'order',
      if (!_sameList(merged.skills, existing.skills)) 'skills',
      if (merged.color != existing.color) 'color',
    ];
    return ItemChange(
      changed.isEmpty ? ChangeKind.unchanged : ChangeKind.updated,
      merged,
      merged.title,
      changed,
    );
  }

  static ItemChange<ProfileInfo> _planProfile(
      Map<String, dynamic> item, ProfileInfo existing) {
    final r = _Reader(item, 'profile');
    final merged = existing.copyWith(
      title: r.string('title')?.trim(),
      subtitle: r.string('subtitle')?.trim(),
      tagline: r.string('tagline')?.trim(),
      description: r.string('description')?.trim(),
      typingWords: r.stringList('typingWords'),
    );
    final changed = <String>[
      if (merged.title != existing.title) 'title',
      if (merged.subtitle != existing.subtitle) 'subtitle',
      if (merged.tagline != existing.tagline) 'tagline',
      if (merged.description != existing.description) 'summary',
      if (!_sameList(merged.typingWords, existing.typingWords)) 'typing words',
    ];
    return ItemChange(
      changed.isEmpty ? ChangeKind.unchanged : ChangeKind.updated,
      merged,
      'Profile headline & summary',
      changed,
    );
  }

  static ItemChange<Experience> _planExperience(
      Map<String, dynamic> item, int index, List<Experience> current) {
    final where = 'experiences[$index]';
    final r = _Reader(item, where);
    final existing = _match<Experience>(
        item, current, (e) => e.id, (e) => e.company,
        titleKey: 'company');

    String labelOf(Experience e) => '${e.position} · ${e.company}';

    if (existing == null) {
      final company = r.string('company')?.trim();
      final position = r.string('position')?.trim();
      if (company == null ||
          company.isEmpty ||
          position == null ||
          position.isEmpty) {
        throw FormatException(
            '$where: a new experience needs a "company" and a "position".');
      }
      final e = Experience(
        company: company,
        position: position,
        duration: r.string('duration') ?? '',
        description: r.string('description') ?? '',
        technologies: r.stringList('technologies') ?? const [],
        companyUrl: r.string('companyUrl') ?? '',
        location: r.nullableString('location'),
        type: r.nullableString('type'),
        order: r.integer('order') ?? 0,
      );
      return ItemChange(ChangeKind.added, e, labelOf(e), const []);
    }

    final merged = Experience(
      id: existing.id,
      company: r.string('company')?.trim() ?? existing.company,
      position: r.string('position')?.trim() ?? existing.position,
      duration: r.string('duration') ?? existing.duration,
      description: r.string('description') ?? existing.description,
      technologies: r.stringList('technologies') ?? existing.technologies,
      companyUrl: r.string('companyUrl') ?? existing.companyUrl,
      location:
          r.has('location') ? r.nullableString('location') : existing.location,
      type: r.has('type') ? r.nullableString('type') : existing.type,
      order: r.integer('order') ?? existing.order,
    );
    final changed = <String>[
      if (merged.company != existing.company) 'company',
      if (merged.position != existing.position) 'position',
      if (merged.duration != existing.duration) 'duration',
      if (merged.order != existing.order) 'order',
      if (merged.description != existing.description) 'description',
      if (!_sameList(merged.technologies, existing.technologies))
        'technologies',
      if (merged.location != existing.location ||
          merged.type != existing.type ||
          merged.companyUrl != existing.companyUrl)
        'details',
    ];
    return ItemChange(
      changed.isEmpty ? ChangeKind.unchanged : ChangeKind.updated,
      merged,
      labelOf(merged),
      changed,
    );
  }

  static bool _sameList(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

enum ChangeKind { added, updated, unchanged }

class ItemChange<T> {
  final ChangeKind kind;

  /// The item as it will be saved.
  final T merged;
  final String label;

  /// Human-readable names of what changed (empty for added/unchanged).
  final List<String> changedFields;

  const ItemChange(this.kind, this.merged, this.label, this.changedFields);
}

class CvImportPlan {
  final ItemChange<ProfileInfo>? profile;
  final List<ItemChange<Experience>> experiences;
  final List<ItemChange<Project>> projects;
  final List<ItemChange<TechCategory>> skills;

  const CvImportPlan({
    this.profile,
    this.experiences = const [],
    required this.projects,
    required this.skills,
  });

  int get changeCount => [
        if (profile != null) profile!,
        ...experiences,
        ...projects,
        ...skills,
      ].where((c) => c.kind != ChangeKind.unchanged).length;

  bool get hasChanges => changeCount > 0;
}

/// Typed, error-reporting access to one JSON object.
class _Reader {
  final Map<String, dynamic> map;
  final String where;

  _Reader(this.map, this.where);

  bool has(String key) => map.containsKey(key);

  Never _bad(String key, String expected) =>
      throw FormatException('$where.$key must be $expected.');

  String? string(String key) {
    final v = map[key];
    if (v == null) return null;
    if (v is String) return v;
    _bad(key, 'a string');
  }

  /// Like [string], but an empty string also means "no value".
  String? nullableString(String key) {
    final v = string(key)?.trim();
    return (v == null || v.isEmpty) ? null : v;
  }

  int? integer(String key) {
    final v = map[key];
    if (v == null) return null;
    if (v is num && v == v.roundToDouble()) return v.toInt();
    _bad(key, 'a whole number');
  }

  bool? boolean(String key) {
    final v = map[key];
    if (v == null) return null;
    if (v is bool) return v;
    _bad(key, 'true or false');
  }

  List<String>? stringList(String key) {
    final v = map[key];
    if (v == null) return null;
    if (v is List && v.every((e) => e is String)) {
      return v
          .cast<String>()
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    _bad(key, 'a list of strings');
  }

  /// Accepts an int, or "#RRGGBB" / "#AARRGGBB" / "0xAARRGGBB".
  int? color(String key) {
    final v = map[key];
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) {
      var hex = v.trim().replaceFirst('#', '').replaceFirst(RegExp('^0x'), '');
      if (hex.length == 6) hex = 'FF$hex';
      final parsed = hex.length == 8 ? int.tryParse(hex, radix: 16) : null;
      if (parsed != null) return parsed;
    }
    _bad(key, 'a color like "#FF64FFDA"');
  }
}
