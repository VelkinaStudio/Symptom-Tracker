import 'package:home_widget/home_widget.dart';
import '../../core/database/app_database.dart';
import '../../core/database/daos/symptom_entry_dao.dart';

class WidgetService {
  static const _androidWidgetName = 'SymptomWidgetReceiver';

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId('com.symptomtracker.symptom_tracker');
    await HomeWidget.registerInteractivityCallback(interactivityCallback);
  }

  static Future<void> updateWidgetData({
    required int todayCount,
    required int streak,
    List<String> topSymptoms = const [],
  }) async {
    await HomeWidget.saveWidgetData('today_count', todayCount.toString());
    await HomeWidget.saveWidgetData('streak', streak.toString());

    for (int i = 1; i <= 5; i++) {
      final name = (i <= topSymptoms.length) ? topSymptoms[i - 1] : '';
      await HomeWidget.saveWidgetData('symptom_$i', name.isEmpty ? null : name);
    }

    await HomeWidget.updateWidget(androidName: _androidWidgetName);
  }

  /// Process any pending symptom log from the widget.
  static Future<bool> processPendingLog(SymptomEntryDao dao) async {
    final hasPending = await HomeWidget.getWidgetData<bool>('has_pending');
    if (hasPending != true) return false;

    final symptomName = await HomeWidget.getWidgetData<String>('pending_symptom');
    final category = await HomeWidget.getWidgetData<String>('pending_category');
    final severity = await HomeWidget.getWidgetData<int>('pending_severity');
    final timestamp = await HomeWidget.getWidgetData<String>('pending_timestamp');

    if (symptomName == null || category == null || severity == null) return false;

    final startedAt = timestamp != null
        ? DateTime.tryParse(timestamp) ?? DateTime.now()
        : DateTime.now();

    await dao.insertEntry(
      SymptomEntriesCompanion.insert(
        symptomName: symptomName,
        category: category,
        severity: severity,
        startedAt: startedAt,
      ),
    );

    // Clear the pending flag
    await HomeWidget.saveWidgetData('has_pending', false);
    await HomeWidget.saveWidgetData('pending_symptom', null);
    await HomeWidget.saveWidgetData('pending_category', null);
    await HomeWidget.saveWidgetData('pending_severity', null);
    await HomeWidget.saveWidgetData('pending_timestamp', null);

    return true;
  }

  static Future<List<String>> computeTopSymptoms(
    SymptomEntryDao dao, {
    int limit = 5,
  }) async {
    final entries = await dao.getAllEntries();
    final counts = <String, int>{};
    for (final entry in entries) {
      counts[entry.symptomName] = (counts[entry.symptomName] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(limit).map((e) => e.key).toList();
  }

  @pragma('vm:entry-point')
  static Future<void> interactivityCallback(Uri? uri) async {
    // Widget interactions handled via ActionCallback on native side
  }
}
