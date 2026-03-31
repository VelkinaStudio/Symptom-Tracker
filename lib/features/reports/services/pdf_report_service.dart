import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/utils/date_utils.dart';
import '../providers/reports_provider.dart';

class PdfReportService {
  static Future<Uint8List> generate(ReportData data) async {
    final doc = pw.Document();

    final dateRange =
        '${AppDateUtils.formatDate(data.start)} – ${AppDateUtils.formatDate(data.end)}';

    // Sort symptom counts descending
    final sortedSymptoms = data.symptomCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Symptom Tracker Report',
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Date Range: $dateRange',
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
            ),
            pw.Text(
              'Generated: ${AppDateUtils.formatDateTime(DateTime.now())}',
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
            ),
            pw.Divider(thickness: 1.5),
            pw.SizedBox(height: 8),
          ],
        ),
        footer: (context) => pw.Column(
          children: [
            pw.Divider(),
            pw.Text(
              'DISCLAIMER: This report is for personal record-keeping only and does not constitute medical advice. '
              'Consult a qualified healthcare professional for medical guidance.',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 4),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style:
                    const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
            ),
          ],
        ),
        build: (context) => [
          // Summary boxes
          pw.Text(
            'Summary',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              _summaryBox('Total Entries', '${data.totalEntries}'),
              pw.SizedBox(width: 12),
              _summaryBox('Avg Severity',
                  '${data.avgSeverity.toStringAsFixed(1)} / 10'),
              pw.SizedBox(width: 12),
              _summaryBox(
                  'Unique Symptoms', '${data.symptomCounts.length}'),
            ],
          ),
          pw.SizedBox(height: 20),

          // Symptom summary table
          pw.Text(
            'Symptom Summary',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          if (sortedSymptoms.isEmpty)
            pw.Text('No symptom data for this period.',
                style: const pw.TextStyle(color: PdfColors.grey700))
          else
            pw.TableHelper.fromTextArray(
              headers: ['Symptom', 'Occurrences'],
              data: sortedSymptoms
                  .take(15)
                  .map((e) => [e.key, '${e.value}'])
                  .toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.blueGrey100),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.center,
              },
              border: pw.TableBorder.all(color: PdfColors.grey400),
              cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 4, horizontal: 8),
            ),
          pw.SizedBox(height: 20),

          // Top triggers table
          pw.Text(
            'Top Triggers',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          if (data.topTriggers.isEmpty)
            pw.Text('No trigger data for this period.',
                style: const pw.TextStyle(color: PdfColors.grey700))
          else
            pw.TableHelper.fromTextArray(
              headers: ['Trigger', 'Occurrences'],
              data: data.topTriggers
                  .take(15)
                  .map((e) => [e.key, '${e.value}'])
                  .toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.blueGrey100),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.center,
              },
              border: pw.TableBorder.all(color: PdfColors.grey400),
              cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 4, horizontal: 8),
            ),
          pw.SizedBox(height: 20),

          // Notable entries (those with notes)
          pw.Text(
            'Notable Entries',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          ..._buildNotableEntries(data),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _summaryBox(String label, String value) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: PdfColors.blueGrey50,
          border: pw.Border.all(color: PdfColors.blueGrey200),
          borderRadius: pw.BorderRadius.circular(4),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              value,
              style: pw.TextStyle(
                  fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              label,
              style: const pw.TextStyle(
                  fontSize: 10, color: PdfColors.grey700),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static List<pw.Widget> _buildNotableEntries(ReportData data) {
    final notable =
        data.entries.where((e) => e.notes != null && e.notes!.isNotEmpty).toList();
    if (notable.isEmpty) {
      return [
        pw.Text('No entries with notes in this period.',
            style: const pw.TextStyle(color: PdfColors.grey700)),
      ];
    }
    return notable.take(20).map((entry) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 8),
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: pw.BorderRadius.circular(4),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  entry.symptomName,
                  style:
                      pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
                ),
                pw.Text(
                  '${AppDateUtils.formatDateTime(entry.startedAt)}  |  Severity: ${entry.severity}/10',
                  style:
                      const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              ],
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              entry.notes!,
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    }).toList();
  }
}
