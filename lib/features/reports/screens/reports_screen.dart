import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../core/utils/date_utils.dart';
import '../providers/reports_provider.dart';
import '../services/pdf_report_service.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(reportRangeProvider);
    final reportAsync = ref.watch(reportDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Range selector
          Center(
            child: SegmentedButton<ReportRange>(
              segments: const [
                ButtonSegment(
                    value: ReportRange.week,
                    label: Text('7 Days'),
                    icon: Icon(Icons.calendar_view_week)),
                ButtonSegment(
                    value: ReportRange.month,
                    label: Text('30 Days'),
                    icon: Icon(Icons.calendar_month)),
                ButtonSegment(
                    value: ReportRange.custom,
                    label: Text('Custom'),
                    icon: Icon(Icons.date_range)),
              ],
              selected: {range},
              onSelectionChanged: (set) {
                ref.read(reportRangeProvider.notifier).state = set.first;
              },
            ),
          ),
          if (range == ReportRange.custom) ...[
            const SizedBox(height: 12),
            _CustomDateRow(),
          ],
          const SizedBox(height: 20),

          // Content
          reportAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (err, _) => _ErrorCard(error: err.toString()),
            data: (data) => _ReportContent(data: data),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom date row
// ---------------------------------------------------------------------------

class _CustomDateRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = ref.watch(reportCustomStartProvider);
    final end = ref.watch(reportCustomEndProvider);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text('From: ${AppDateUtils.formatDate(start)}'),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: start,
                firstDate: DateTime(2000),
                lastDate: end,
              );
              if (picked != null) {
                ref.read(reportCustomStartProvider.notifier).state = picked;
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text('To: ${AppDateUtils.formatDate(end)}'),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: end,
                firstDate: start,
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                ref.read(reportCustomEndProvider.notifier).state = picked;
              }
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Error card
// ---------------------------------------------------------------------------

class _ErrorCard extends StatelessWidget {
  final String error;
  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Error loading report: $error',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Report content
// ---------------------------------------------------------------------------

class _ReportContent extends ConsumerWidget {
  final ReportData data;
  const _ReportContent({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ----- Summary card -----
        _SectionHeader(title: 'Summary'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                    label: 'Total\nEntries',
                    value: '${data.totalEntries}'),
                _StatItem(
                    label: 'Avg\nSeverity',
                    value: data.avgSeverity.toStringAsFixed(1)),
                _StatItem(
                    label: 'Unique\nSymptoms',
                    value: '${data.symptomCounts.length}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ----- Top Symptoms card -----
        _SectionHeader(title: 'Top Symptoms'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: data.symptomCounts.isEmpty
                ? const Text('No symptom data for this period.',
                    style: TextStyle(color: Colors.grey))
                : Column(
                    children: _buildTopItems(
                      data.symptomCounts.entries
                          .toList()
                        ..sort((a, b) => b.value.compareTo(a.value)),
                      limit: 5,
                      context: context,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),

        // ----- Top Triggers card -----
        _SectionHeader(title: 'Top Triggers'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: data.topTriggers.isEmpty
                ? const Text('No trigger data for this period.',
                    style: TextStyle(color: Colors.grey))
                : Column(
                    children: _buildTopItems(
                      data.topTriggers,
                      limit: 5,
                      context: context,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 24),

        // ----- Export buttons -----
        _SectionHeader(title: 'Export'),
        const SizedBox(height: 8),
        FilledButton.icon(
          icon: const Icon(Icons.download),
          label: const Text('Download PDF'),
          onPressed: () => _downloadPdf(context, ref),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.share),
          label: const Text('Share PDF'),
          onPressed: () => _sharePdf(context, ref),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  List<Widget> _buildTopItems(
      List<MapEntry<String, int>> items, {
      required int limit,
      required BuildContext context,
  }) {
    final topItems = items.take(limit).toList();
    if (topItems.isEmpty) return [];
    final maxCount = topItems.first.value;

    return topItems.map((entry) {
      final fraction = maxCount > 0 ? entry.value / maxCount : 0.0;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(entry.key,
                        overflow: TextOverflow.ellipsis)),
                Text(
                  '${entry.value}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      );
    }).toList();
  }

  Future<void> _downloadPdf(BuildContext context, WidgetRef ref) async {
    try {
      final reportData = ref.read(reportDataProvider).value;
      if (reportData == null) return;
      final pdfBytes = await PdfReportService.generate(reportData);
      await Printing.layoutPdf(
        onLayout: (_) => pdfBytes,
        name: 'symptom_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download PDF: $e')),
        );
      }
    }
  }

  Future<void> _sharePdf(BuildContext context, WidgetRef ref) async {
    try {
      final reportData = ref.read(reportDataProvider).value;
      if (reportData == null) return;
      final pdfBytes = await PdfReportService.generate(reportData);
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename:
            'symptom_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share PDF: $e')),
        );
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Small helper widgets
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
