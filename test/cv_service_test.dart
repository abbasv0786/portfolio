import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/models/profile_info.dart';
import 'package:portfolio/models/tech_category.dart';
import 'package:portfolio/services/cv_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bulletsFrom splits "- " lines and falls back to plain lines', () {
    expect(
      CvService.bulletsFrom('\n- First thing.\n-  Second thing.\n'),
      ['First thing.', 'Second thing.'],
    );
    expect(CvService.bulletsFrom('Just a paragraph.'), ['Just a paragraph.']);
  });

  test('displayUrl strips scheme, www, hash route and trailing slash', () {
    expect(
      CvService.displayUrl('https://www.linkedin.com/in/someone/'),
      'linkedin.com/in/someone',
    );
    expect(
      CvService.displayUrl(
          'https://abbasv0786.github.io/portfolio/#/ahemadabbas-vagh'),
      'abbasv0786.github.io/portfolio',
    );
  });

  test('file name follows the profile name', () {
    final profile = ProfileInfo.fromMap({'name': 'Jane  Doe'});
    expect(CvService.fileNameFor(profile), 'Jane_Doe_CV.pdf');
  });

  test('builds a PDF from portfolio data', () async {
    final content = CvContent(
      profile: ProfileInfo.fromMap({
        'title': PortfolioData.title,
        'subtitle': PortfolioData.subtitle,
        'description': PortfolioData.description,
      }),
      skills: const [
        TechCategory(title: 'Languages', skills: ['Python', 'Dart'], color: 0),
      ],
      experiences: PortfolioData.experiences,
      projects: PortfolioData.projects,
      education: PortfolioData.cvEducationAndCerts,
    );
    final bytes = await CvService.buildCvPdf(content);
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');

    // Set CV_OUT to inspect the generated file manually.
    final out = Platform.environment['CV_OUT'];
    if (out != null) File(out).writeAsBytesSync(bytes);
  });
}
