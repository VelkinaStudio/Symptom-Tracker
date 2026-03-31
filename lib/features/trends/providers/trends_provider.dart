import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/providers/database_provider.dart';

enum TrendRange { week, month, quarter }

final trendRangeProvider = StateProvider<TrendRange>((ref) => TrendRange.week);

DateTime _rangeStart(TrendRange range) {
  final now = DateTime.now();
  switch (range) {
    case TrendRange.week:
      return now.subtract(const Duration(days: 7));
    case TrendRange.month:
      return now.subtract(const Duration(days: 30));
    case TrendRange.quarter:
      return now.subtract(const Duration(days: 90));
  }
}

class TrendData {
  final Map<DateTime, int> frequencyByDay;
  final Map<DateTime, double> avgSeverityByDay;
  final List<MapEntry<String, int>> topTriggers;
  final List<SymptomRank> topSymptoms;
  const TrendData({
    this.frequencyByDay = const {},
    this.avgSeverityByDay = const {},
    this.topTriggers = const [],
    this.topSymptoms = const [],
  });
}

class SymptomRank {
  final String name;
  final int count;
  final double avgSeverity;
  const SymptomRank({
    required this.name,
    required this.count,
    required this.avgSeverity,
  });
}

final trendDataProvider = FutureProvider<TrendData>((ref) async {
  final range = ref.watch(trendRangeProvider);
  final start = _rangeStart(range);
  final end = DateTime.now();
  final entryDao = ref.watch(symptomEntryDaoProvider);
  final triggerDao = ref.watch(triggerDaoProvider);
  final entries = await entryDao.getEntriesInRange(start, end);

  // Frequency by day
  final frequencyByDay = <DateTime, int>{};
  for (final entry in entries) {
    final day = AppDateUtils.startOfDay(entry.startedAt);
    frequencyByDay[day] = (frequencyByDay[day] ?? 0) + 1;
  }

  // Average severity by day
  final severityByDay = <DateTime, List<int>>{};
  for (final entry in entries) {
    final day = AppDateUtils.startOfDay(entry.startedAt);
    severityByDay.putIfAbsent(day, () => []).add(entry.severity);
  }
  final avgSeverityByDay = severityByDay.map(
    (day, severities) => MapEntry(
      day,
      severities.reduce((a, b) => a + b) / severities.length,
    ),
  );

  final topTriggers = await triggerDao.getTopTriggersInRange(start, end);

  // Top symptoms
  final symptomCounts = <String, List<int>>{};
  for (final entry in entries) {
    symptomCounts.putIfAbsent(entry.symptomName, () => []).add(entry.severity);
  }
  final topSymptoms = symptomCounts.entries
      .map(
        (e) => SymptomRank(
          name: e.key,
          count: e.value.length,
          avgSeverity:
              e.value.reduce((a, b) => a + b) / e.value.length,
        ),
      )
      .toList()
    ..sort((a, b) => b.count.compareTo(a.count));

  return TrendData(
    frequencyByDay: frequencyByDay,
    avgSeverityByDay: avgSeverityByDay,
    topTriggers: topTriggers,
    topSymptoms: topSymptoms,
  );
});
