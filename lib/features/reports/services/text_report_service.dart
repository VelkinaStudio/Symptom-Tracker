import '../../../core/utils/date_utils.dart';
import '../providers/reports_provider.dart';

class TextReportService {
  static String generate(ReportData data) {
    final buf = StringBuffer();
    final sep = '=' * 50;
    final thinSep = '-' * 50;

    // Header
    buf.writeln(sep);
    buf.writeln('          SYMPTOM TRACKER REPORT');
    buf.writeln(sep);
    buf.writeln(
        'Date Range: ${AppDateUtils.formatDate(data.start)} – ${AppDateUtils.formatDate(data.end)}');
    buf.writeln('Generated:  ${AppDateUtils.formatDateTime(DateTime.now())}');
    buf.writeln();

    // Summary
    buf.writeln('SUMMARY');
    buf.writeln(thinSep);
    buf.writeln('Total Entries   : ${data.totalEntries}');
    buf.writeln(
        'Avg Severity    : ${data.avgSeverity.toStringAsFixed(1)} / 10');
    buf.writeln('Unique Symptoms : ${data.symptomCounts.length}');
    buf.writeln();

    // Top Symptoms
    buf.writeln('TOP SYMPTOMS');
    buf.writeln(thinSep);
    if (data.symptomCounts.isEmpty) {
      buf.writeln('  No data in this period.');
    } else {
      final sorted = data.symptomCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      for (final e in sorted.take(10)) {
        buf.writeln('  ${e.key.padRight(30)} ${e.value} occurrence(s)');
      }
    }
    buf.writeln();

    // Top Triggers
    buf.writeln('TOP TRIGGERS');
    buf.writeln(thinSep);
    if (data.topTriggers.isEmpty) {
      buf.writeln('  No trigger data in this period.');
    } else {
      for (final e in data.topTriggers.take(10)) {
        buf.writeln('  ${e.key.padRight(30)} ${e.value} occurrence(s)');
      }
    }
    buf.writeln();

    // Entries
    buf.writeln('ENTRIES');
    buf.writeln(thinSep);
    if (data.entries.isEmpty) {
      buf.writeln('  No entries in this period.');
    } else {
      for (final entry in data.entries) {
        final date = AppDateUtils.formatDateTime(entry.startedAt);
        buf.writeln('  $date | ${entry.symptomName} | Severity: ${entry.severity}/10');
        if (entry.notes != null && entry.notes!.isNotEmpty) {
          buf.writeln('    Notes: ${entry.notes}');
        }
      }
    }
    buf.writeln();

    // Disclaimer
    buf.writeln(sep);
    buf.writeln('DISCLAIMER');
    buf.writeln(thinSep);
    buf.writeln('This report is for personal record-keeping purposes only.');
    buf.writeln('It does not constitute medical advice. Please consult a');
    buf.writeln('qualified healthcare professional for medical guidance.');
    buf.writeln(sep);

    return buf.toString();
  }
}
