import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/services/widget_service.dart';

class HomeStats {
  final int daysTracked;
  final int todayCount;
  const HomeStats({
    this.daysTracked = 0,
    this.todayCount = 0,
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
  // Compute top symptoms for the widget
  final topSymptoms = await WidgetService.computeTopSymptoms(dao);

  // Update home screen widget
  WidgetService.updateWidgetData(
    todayCount: todayCount,
    topSymptoms: topSymptoms,
  );

  return HomeStats(
    daysTracked: daysTracked,
    todayCount: todayCount,
  );
});
