import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/profile_info.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/models/tech_category.dart';
import 'package:portfolio/services/cv_data_transfer.dart';

void main() {
  const app = Project(
    id: 'p1',
    title: 'Shop App',
    description: 'An e-commerce app',
    imageUrl: 'data:image/png;base64,AAAA',
    technologies: ['Flutter', 'Firebase'],
    category: 'Flutter',
    order: 1,
    liveUrl: 'https://shop.example',
  );
  const mobile = TechCategory(
    id: 's1',
    title: 'Mobile',
    skills: ['Flutter', 'Swift'],
    color: 0xFF64FFDA,
    order: 0,
  );

  CvImportPlan plan(Map<String, dynamic> data) => CvDataTransfer.plan(
        jsonEncode(data),
        currentProjects: const [app],
        currentSkills: const [mobile],
      );

  group('export', () {
    test('round-trips with no changes and leaves out images', () {
      final json =
          CvDataTransfer.export(projects: const [app], skills: const [mobile]);
      expect(json, isNot(contains('base64')));

      final result = CvDataTransfer.plan(json,
          currentProjects: const [app], currentSkills: const [mobile]);
      expect(result.hasChanges, isFalse);
      expect(result.projects.single.kind, ChangeKind.unchanged);
      expect(result.skills.single.kind, ChangeKind.unchanged);
    });

    test('writes colors as hex', () {
      final data = jsonDecode(
          CvDataTransfer.export(projects: const [], skills: const [mobile]));
      expect(data['skills'][0]['color'], '#FF64FFDA');
    });
  });

  group('import', () {
    test('updates only fields that are present and keeps the image', () {
      final result = plan({
        'projects': [
          {'id': 'p1', 'description': 'Tailored text', 'isActive': false},
        ],
      });
      final change = result.projects.single;
      expect(change.kind, ChangeKind.updated);
      expect(change.changedFields, ['switched off', 'description']);
      expect(change.merged.description, 'Tailored text');
      expect(change.merged.isActive, isFalse);
      expect(change.merged.imageUrl, app.imageUrl);
      expect(change.merged.technologies, app.technologies);
      expect(change.merged.liveUrl, app.liveUrl);
    });

    test('matches by title when the id is missing', () {
      final result = plan({
        'projects': [
          {'title': 'shop app', 'order': 5},
        ],
      });
      expect(result.projects.single.kind, ChangeKind.updated);
      expect(result.projects.single.merged.id, 'p1');
      expect(result.projects.single.merged.order, 5);
    });

    test('adds unmatched items as new', () {
      final result = plan({
        'projects': [
          {
            'title': 'New One',
            'description': 'd',
            'technologies': ['Go']
          },
        ],
        'skills': [
          {
            'title': 'Cloud',
            'skills': ['AWS'],
            'color': '#112233'
          },
        ],
      });
      expect(result.projects.single.kind, ChangeKind.added);
      expect(result.projects.single.merged.isActive, isTrue);
      expect(result.skills.single.kind, ChangeKind.added);
      expect(result.skills.single.merged.color, 0xFF112233);
      expect(result.changeCount, 2);
    });

    test('an empty string clears an optional link', () {
      final result = plan({
        'projects': [
          {'id': 'p1', 'liveUrl': ''},
        ],
      });
      expect(result.projects.single.merged.liveUrl, isNull);
      expect(result.projects.single.changedFields, ['links']);
    });

    test('reorders skills inside a category', () {
      final result = plan({
        'skills': [
          {
            'id': 's1',
            'skills': ['Swift', 'Flutter']
          },
        ],
      });
      expect(result.skills.single.changedFields, ['skills']);
    });

    test('rejects bad input with a readable message', () {
      expect(
        () => CvDataTransfer.plan('not json',
            currentProjects: const [], currentSkills: const []),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => plan({'format': 'something-else', 'projects': []}),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => plan({
          'projects': [
            {'id': 'p1', 'technologies': 'Flutter'},
          ],
        }),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message ==
                'projects[0].technologies must be a list of strings.')),
      );
      expect(
        () => plan({
          'projects': [
            {'description': 'no title'},
          ],
        }),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('profile and experience', () {
    const job = Experience(
      id: 'e1',
      company: 'Mercor',
      position: 'Generalist',
      duration: 'Oct 2026 - Present',
      description: '- Write evaluation tasks',
      technologies: ['LLM Evaluation'],
      companyUrl: 'https://mercor.com',
      location: 'Remote',
      order: 0,
    );
    const profile = ProfileInfo(
      name: 'A',
      title: 'Engineer',
      subtitle: 'Sub',
      tagline: 'Tag',
      description: 'Summary',
      location: 'Remote',
      availability: '',
      email: 'a@b.c',
      phone: '',
      whatsapp: '',
      discord: '',
      telegram: '',
      linkedin: '',
      twitter: '',
      instagram: '',
      github: '',
      portfolioUrl: '',
      cvUrl: '',
      footerDescription: '',
      footerCopyright: '',
      yearsOfExperience: '8+',
      completedProjects: '20+',
      typingWords: ['One'],
    );

    CvImportPlan planAll(String json) => CvDataTransfer.plan(json,
        currentProjects: const [],
        currentSkills: const [],
        currentExperiences: const [job],
        currentProfile: profile);

    test('round-trips with no changes', () {
      final json = CvDataTransfer.export(
          projects: const [],
          skills: const [],
          experiences: const [job],
          profile: profile);
      expect(json, isNot(contains('a@b.c')));
      expect(planAll(json).hasChanges, isFalse);
    });

    test('updates summary and experience bullets only', () {
      final result = planAll(jsonEncode({
        'profile': {'description': 'Detail-oriented evaluator'},
        'experiences': [
          {'company': 'mercor', 'description': '- New bullet'},
        ],
      }));
      expect(result.profile!.changedFields, ['summary']);
      expect(result.profile!.merged.email, 'a@b.c');
      expect(result.profile!.merged.title, 'Engineer');
      final e = result.experiences.single;
      expect(e.kind, ChangeKind.updated);
      expect(e.merged.id, 'e1');
      expect(e.merged.description, '- New bullet');
      expect(e.merged.duration, job.duration);
      expect(result.changeCount, 2);
    });

    test('a new experience needs company and position', () {
      expect(
          () => planAll(jsonEncode({
                'experiences': [
                  {'company': 'NewCo'},
                ],
              })),
          throwsA(isA<FormatException>()));
    });
  });

  test('Project.isActive defaults to true for old Firestore docs', () {
    final p = Project.fromMap({'title': 'Old', 'order': 2.0}, 'x');
    expect(p.isActive, isTrue);
    expect(p.order, 2);
    expect(p.toMap()['isActive'], isTrue);
  });
}
