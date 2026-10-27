import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data/portfolio_data.dart';
import '../models/experience.dart';
import '../models/profile_info.dart';
import '../models/project.dart';
import '../models/tech_category.dart';
import 'cv_download/cv_download.dart';
import 'firestore_service.dart';

/// Everything the CV shows, taken from the same data as the live portfolio.
class CvContent {
  final ProfileInfo profile;
  final List<TechCategory> skills;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<String> education;

  const CvContent({
    required this.profile,
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.education,
  });

  factory CvContent.fromPortfolio() {
    final fs = FirestoreService.to;
    return CvContent(
      profile: fs.profileInfo.value,
      skills: fs.techCategories.toList(),
      experiences: fs.experiences.toList(),
      projects: fs.projects.toList(),
      education: PortfolioData.cvEducationAndCerts,
    );
  }
}

class CvService {
  // ─── ATS-friendly CV, generated from the live portfolio data ───

  static const int maxProjects = 4;

  static Future<void> generateAndDownloadCv() async {
    final content = CvContent.fromPortfolio();
    try {
      final bytes = await buildCvPdf(content);
      await savePdf(bytes, fileNameFor(content.profile));
    } catch (e) {
      debugPrint('Error generating CV: $e');
    }
  }

  static String fileNameFor(ProfileInfo profile) {
    final name =
        profile.name.trim().isEmpty ? PortfolioData.name : profile.name;
    return '${name.trim().replaceAll(RegExp(r'\s+'), '_')}_CV.pdf';
  }

  static Future<Uint8List> buildCvPdf(CvContent content) async {
    final pdf = pw.Document();
    final profile = content.profile;

    // Load OpenSans fonts — ATS-safe, clean sans-serif
    final fontData = await rootBundle.load('assets/fonts/OpenSans-Regular.ttf');
    final fontBoldData =
        await rootBundle.load('assets/fonts/OpenSans-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final fontBold = pw.Font.ttf(fontBoldData);

    final summary = [profile.subtitle, profile.description]
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .join(' ');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
        ),
        build: (pw.Context context) {
          return [
            // ── 1. HEADER WITH CONTACT DETAILS
            _buildHeader(profile, fontBold, font),
            pw.SizedBox(height: 4),
            pw.Divider(thickness: 0.8, color: PdfColors.black),
            pw.SizedBox(height: 6),

            // ── 2. PROFESSIONAL SUMMARY
            if (summary.isNotEmpty) ...[
              _sectionTitle('Professional Summary', fontBold),
              pw.Text(
                summary,
                style: pw.TextStyle(font: font, fontSize: 9, lineSpacing: 1.4),
              ),
              pw.SizedBox(height: 8),
            ],

            // ── 3. TECHNICAL SKILLS
            if (content.skills.isNotEmpty) ...[
              _sectionTitle('Technical Skills', fontBold),
              _buildSkillsCompact(content.skills, font, fontBold),
              pw.SizedBox(height: 8),
            ],

            // ── 4. WORK EXPERIENCE
            if (content.experiences.isNotEmpty) ...[
              _sectionTitle('Professional Experience', fontBold),
              ...content.experiences
                  .map((e) => _buildExperienceWidget(e, fontBold, font)),
            ],

            // ── 5. KEY PROJECTS
            if (content.projects.isNotEmpty) ...[
              _sectionTitle('Key Projects', fontBold),
              ...content.projects
                  .take(maxProjects)
                  .map((p) => _buildProject(p, fontBold, font)),
              pw.SizedBox(height: 6),
            ],

            // ── 6. EDUCATION & CERTIFICATIONS
            if (content.education.isNotEmpty) ...[
              _sectionTitle('Education & Certifications', fontBold),
              ...content.education.map((item) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 2, left: 6),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('- ',
                            style: pw.TextStyle(font: font, fontSize: 9)),
                        pw.Expanded(
                          child: pw.Text(item,
                              style: pw.TextStyle(font: font, fontSize: 9)),
                        ),
                      ],
                    ),
                  )),
            ],
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 6),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: pw.TextStyle(
                font: font,
                fontSize: 7,
                color: PdfColors.grey500,
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Splits an experience description into bullet lines ("- ..." per line).
  static List<String> bulletsFrom(String description) {
    final lines = description
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    final bullets = lines
        .where((l) => l.startsWith('-') || l.startsWith('•'))
        .map((l) => l.substring(1).trim())
        .where((l) => l.isNotEmpty)
        .toList();
    return bullets.isNotEmpty ? bullets : lines;
  }

  /// "https://www.linkedin.com/in/x/" -> "linkedin.com/in/x"
  static String displayUrl(String url) => url
      .trim()
      .replaceFirst(RegExp(r'^https?://'), '')
      .replaceFirst(RegExp(r'^www\.'), '')
      .replaceFirst(RegExp(r'/#/.*$'), '')
      .replaceFirst(RegExp(r'/$'), '');

  // ─────────────────────────────────────────────
  // HEADER: Name, Title, Contact Details
  // ─────────────────────────────────────────────
  static pw.Widget _buildHeader(
      ProfileInfo profile, pw.Font fontBold, pw.Font font) {
    final contacts = <String>[
      if (profile.email.isNotEmpty) 'Email: ${profile.email}',
      if (profile.phone.isNotEmpty) 'Phone: ${profile.phone}',
      if (profile.linkedin.isNotEmpty)
        'LinkedIn: ${displayUrl(profile.linkedin)}',
      if (profile.github.isNotEmpty) 'GitHub: ${displayUrl(profile.github)}',
      if (profile.location.isNotEmpty) 'Location: ${profile.location}',
      if (profile.portfolioUrl.isNotEmpty)
        'Portfolio: ${displayUrl(profile.portfolioUrl)}',
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          profile.name.toUpperCase(),
          style: pw.TextStyle(
            font: fontBold,
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
        if (profile.title.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Text(
            profile.title,
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 10,
              color: PdfColors.grey800,
            ),
          ),
        ],
        pw.SizedBox(height: 6),
        // Contact Details Row
        pw.Wrap(
          spacing: 16,
          runSpacing: 4,
          children: contacts.map((c) => _contactChip(c, font)).toList(),
        ),
        pw.SizedBox(height: 4),
      ],
    );
  }

  static pw.Widget _contactChip(String text, pw.Font font) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: font,
        fontSize: 8,
        color: PdfColors.grey700,
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SECTION TITLE
  // ─────────────────────────────────────────────
  static pw.Widget _sectionTitle(String title, pw.Font fontBold) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title.toUpperCase(),
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 9.5,
              fontWeight: pw.FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          pw.Divider(thickness: 0.5, color: PdfColors.grey500),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TECHNICAL SKILLS — FDE-focused
  // ─────────────────────────────────────────────
  static pw.Widget _buildSkillsCompact(
      List<TechCategory> categories, pw.Font font, pw.Font fontBold) {
    final skills = categories
        .where((c) => c.skills.isNotEmpty)
        .map((c) => '${c.title}: ${c.skills.join(', ')}')
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: skills.map((skill) {
        final colonIdx = skill.indexOf(':');
        final category = skill.substring(0, colonIdx + 1);
        final values = skill.substring(colonIdx + 1);
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 2),
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: category,
                  style: pw.TextStyle(
                      font: fontBold,
                      fontSize: 8.5,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.TextSpan(
                  text: values,
                  style: pw.TextStyle(font: font, fontSize: 8.5),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─────────────────────────────────────────────
  // EXPERIENCE — bullets parsed from each role's description
  // ─────────────────────────────────────────────
  static pw.Widget _buildExperienceWidget(
      Experience entry, pw.Font fontBold, pw.Font font) {
    final bullets = bulletsFrom(entry.description);
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                entry.company,
                style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 9.5,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                entry.duration,
                style: pw.TextStyle(font: font, fontSize: 8.5),
              ),
            ],
          ),
          pw.Text(
            entry.position,
            style: pw.TextStyle(
                font: font,
                fontSize: 9,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey800),
          ),
          pw.SizedBox(height: 2),
          ...bullets.map((line) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 1.5, left: 6),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '-  ',
                      style: pw.TextStyle(font: font, fontSize: 8.5),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        line,
                        style: pw.TextStyle(
                            font: font, fontSize: 8.5, lineSpacing: 1.2),
                      ),
                    ),
                  ],
                ),
              )),
          if (entry.technologies.isNotEmpty) ...[
            pw.SizedBox(height: 1),
            pw.Text(
              'Technologies: ${entry.technologies.join(', ')}',
              style: pw.TextStyle(
                  font: font, fontSize: 7.5, color: PdfColors.grey600),
            ),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // PROJECT: title + one-line desc + tech (compact)
  // ─────────────────────────────────────────────
  static pw.Widget _buildProject(
      Project project, pw.Font fontBold, pw.Font font) {
    final shortDesc = '${project.description.split('.').first}.';
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4, left: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('-  ', style: pw.TextStyle(font: fontBold, fontSize: 8.5)),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text: '${project.title}: ',
                        style: pw.TextStyle(
                            font: fontBold,
                            fontSize: 8.5,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.TextSpan(
                        text: shortDesc,
                        style: pw.TextStyle(font: font, fontSize: 8.5),
                      ),
                    ],
                  ),
                ),
                pw.Text(
                  'Tech: ${project.technologies.take(5).join(', ')}',
                  style: pw.TextStyle(
                      font: font, fontSize: 7.5, color: PdfColors.grey600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
