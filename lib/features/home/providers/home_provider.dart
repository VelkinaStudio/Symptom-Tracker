import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/services/widget_service.dart';

class HomeStats {
  final int daysTracked;
  final int todayCount;
  final int currentStreak;
  const HomeStats({
    this.daysTracked = 0,
    this.todayCount = 0,
    this.currentStreak = 0,
  });
}

final todayEntriesProvider = StreamProvider<List<SymptomEntry>>((ref) {
  return ref.watch(symptomEntryDaoProvider).watchEntriesForDate(DateTime.now());
});

final homeStatsProvider = FutureProvider<HomeStats>((ref) async {
  final dao = ref.watch(symptomEntryDaoProvider);

  // Process any pending widget log entry
  await WidgetService.processPendingLog(dao);

  final daysTracked = await dao.countTotalDaysWithEntries();
  final todayCount = await dao.countEntriesForDate(DateTime.now());
  // Calculate streak
  int streak = 0;
  var checkDate = DateTime.now();
  while (true) {
    final count = await dao.countEntriesForDate(checkDate);
    if (count > 0) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }

  // Compute top symptoms for the widget
  final topSymptoms = await WidgetService.computeTopSymptoms(dao);

  // Update home screen widget
  WidgetService.updateWidgetData(
    todayCount: todayCount,
    streak: streak,
    topSymptoms: topSymptoms,
  );

  return HomeStats(
    daysTracked: daysTracked,
    todayCount: todayCount,
    currentStreak: streak,
  );
});
