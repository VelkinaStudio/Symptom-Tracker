import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';

class ReportData {
  final DateTime start;
  final DateTime end;
  final int totalEntries;
  final List<SymptomEntry> entries;
  final Map<String, int> symptomCounts;
  final double avgSeverity;
  final List<MapEntry<String, int>> topTriggers;

  const ReportData({
    required this.start,
    required this.end,
    this.totalEntries = 0,
    this.entries = const [],
    this.symptomCounts = const {},
    this.avgSeverity = 0,
    this.topTriggers = const [],
  });
}

enum ReportRange { week, month, custom }

final reportRangeProvider =
    StateProvider<ReportRange>((ref) => ReportRange.week);

final reportCustomStartProvider = StateProvider<DateTime>(
    (ref) => DateTime.now().subtract(const Duration(days: 7)));

final reportCustomEndProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

final reportDataProvider = FutureProvider<ReportData>((ref) async {
  final range = ref.watch(reportRangeProvider);
  final now = DateTime.now();
  late DateTime start, end;
  switch (range) {
    case ReportRange.week:
      start = now.subtract(const Duration(days: 7));
      end = now;
    case ReportRange.month:
      start = now.subtract(const Duration(days: 30));
      end = now;
    case ReportRange.custom:
      start = ref.watch(reportCustomStartProvider);
      end = ref.watch(reportCustomEndProvider);
  }
  final entryDao = ref.watch(symptomEntryDaoProvider);
  final triggerDao = ref.watch(triggerDaoProvider);
  final entries = await entryDao.getEntriesInRange(start, end);
  final topTriggers = await triggerDao.getTopTriggersInRange(start, end);
  final symptomCounts = <String, int>{};
  var totalSeverity = 0;
  for (final entry in entries) {
    symptomCounts[entry.symptomName] =
        (symptomCounts[entry.symptomName] ?? 0) + 1;
    totalSeverity += entry.severity;
  }
  return ReportData(
    start: start,
    end: end,
    totalEntries: entries.length,
    entries: entries,
    symptomCounts: symptomCounts,
    avgSeverity:
        entries.isEmpty ? 0 : totalSeverity / entries.length,
    topTriggers: topTriggers,
  );
});
