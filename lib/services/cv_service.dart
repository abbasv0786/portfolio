import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../data/portfolio_data.dart';
import '../models/experience.dart';
import '../models/project.dart';

class CvService {
  static Future<void> generateAndDownloadCv() async {
    final pdf = pw.Document();

    // Load bundled Open Sans fonts
    final fontData = await rootBundle.load('assets/fonts/OpenSans-Regular.ttf');
    final fontBoldData =
        await rootBundle.load('assets/fonts/OpenSans-Bold.ttf');

    final font = pw.Font.ttf(fontData);
    final fontBold = pw.Font.ttf(fontBoldData);
    // Using a serif font for body can sometimes be better for ATS, but OpenSans is generally safe.
    // Let's stick to OpenSans as established, but ensure sizing is legible.

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
            _buildHeader(fontBold),
            pw.SizedBox(height: 10),
            _buildContactInfo(),
            pw.SizedBox(height: 10),
            pw.Divider(thickness: 1, color: PdfColors.black),
            pw.SizedBox(height: 10),
            _buildSectionTitle('Professional Summary', fontBold),
            pw.Text(
              PortfolioData.cvProfessionalSummary,
              textAlign: pw.TextAlign.left,
              style: const pw.TextStyle(fontSize: 10, lineSpacing: 1.4),
            ),
            pw.SizedBox(height: 12),
            _buildSectionTitle('Technical Skills', fontBold),
            _buildSkills(),
            pw.SizedBox(height: 12),
            _buildSectionTitle('Work Experience', fontBold),
            ...PortfolioData.experiences
                .map((e) => _buildExperienceItem(e, fontBold)),
            pw.NewPage(),
            _buildSectionTitle('Key Projects', fontBold),
            ...PortfolioData.projects
                .take(7)
                .map((p) => _buildProjectItem(p, fontBold)),
            pw.SizedBox(height: 12),
            _buildSectionTitle('Education & Certifications', fontBold),
            _buildBulletList(PortfolioData.cvEducationAndCerts),
            pw.SizedBox(height: 12),
            _buildSectionTitle('Accomplishments', fontBold),
            _buildBulletList(PortfolioData.cvAccomplishments),
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey600,
              ),
            ),
          );
        },
      ),
    );

    // Generate the PDF bytes
    final bytes = await pdf.save();

    try {
      // Direct download using sharePdf
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'AhemadAbbas_Vagh_CV.pdf',
      );
    } catch (e) {
      debugPrint('Error generating CV: $e');
    }
  }

  static pw.Widget _buildHeader(pw.Font fontBold) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      PortfolioData.name.toUpperCase(),
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      PortfolioData.title,
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                  ]),
              pw.Text(
                "Total Experience: 8+ Years",
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 12,
                  color: PdfColors.black,
                ),
              ),
            ]),
      ],
    );
  }

  static pw.Widget _buildContactInfo() {
    return pw.Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        _buildIconText(PortfolioData.email, 'Email'),
        pw.Text("|",
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        _buildIconText(PortfolioData.phone, 'Phone'),
        pw.Text("|",
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        _buildLink(PortfolioData.linkedin, 'LinkedIn'),
        pw.Text("|",
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        _buildLink(PortfolioData.portfolioUrl, 'Portfolio'),
      ],
    );
  }

  static pw.Widget _buildIconText(String text, String label) {
    return pw.Text(
      text,
      style: const pw.TextStyle(fontSize: 9, color: PdfColors.black),
    );
  }

  static pw.Widget _buildLink(String url, String label) {
    return pw.UrlLink(
      destination: url,
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        child: pw.Text(
          label,
          style: const pw.TextStyle(
            fontSize: 9,
            color: PdfColors.blue700,
            decoration: pw.TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  static pw.Widget _buildSectionTitle(String title, pw.Font fontBold) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title.toUpperCase(),
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Divider(thickness: 0.5, color: PdfColors.grey500),
        ],
      ),
    );
  }

  static pw.Widget _buildSkills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: PortfolioData.cvSkills
          .map((skill) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 3,
                      height: 3,
                      margin: const pw.EdgeInsets.only(top: 5, right: 5),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.black,
                        shape: pw.BoxShape.circle,
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        skill,
                        style:
                            const pw.TextStyle(fontSize: 10, lineSpacing: 1.2),
                      ),
                    ),
                  ])))
          .toList(),
    );
  }

  static pw.Widget _buildExperienceItem(
      Experience experience, pw.Font fontBold) {
    // Use the optimized summary if available, else fallback nicely
    final summary = PortfolioData.cvExperienceSummaries[experience.company] ??
        experience.description;

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                experience.company,
                style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                experience.duration,
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Text(
            experience.position,
            style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            summary,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 1.3),
            textAlign: pw.TextAlign.justify,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProjectItem(Project project, pw.Font fontBold) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(
                project.title,
                style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold),
              ),
              if (project.liveUrl != null ||
                  project.iOSUrl != null ||
                  project.androidUrl != null) ...[
                pw.SizedBox(width: 4),
                pw.Text("-", style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(width: 4),
                pw.UrlLink(
                  destination: project.liveUrl ??
                      project.iOSUrl ??
                      project.androidUrl ??
                      '',
                  child: pw.Text('View Project',
                      style: const pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.blue800,
                          decoration: pw.TextDecoration.underline)),
                ),
              ]
            ],
          ),
          pw.Text(
            // Optimize project description: take first sentence usually sufficient for CV list
            '${project.description.split('.').first}.',
            style: const pw.TextStyle(fontSize: 9, lineSpacing: 1.2),
          ),
          pw.Text(
            "Tech: ${project.technologies.take(6).join(', ')}",
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildBulletList(List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: items
          .map((item) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 3,
                      height: 3,
                      margin: const pw.EdgeInsets.only(top: 5, right: 5),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.black,
                        shape: pw.BoxShape.circle,
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        item,
                        style:
                            const pw.TextStyle(fontSize: 10, lineSpacing: 1.2),
                      ),
                    ),
                  ])))
          .toList(),
    );
  }
}
