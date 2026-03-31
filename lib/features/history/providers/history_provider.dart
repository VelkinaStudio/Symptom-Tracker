import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';

enum HistoryViewMode { list, calendar }

class HistoryFilters {
  final String? symptomName;
  final String? category;
  final int? minSeverity;
  final int? maxSeverity;
  final DateTime? startDate;
  final DateTime? endDate;

  const HistoryFilters({
    this.symptomName,
    this.category,
    this.minSeverity,
    this.maxSeverity,
    this.startDate,
    this.endDate,
  });

  bool get isActive =>
      symptomName != null ||
      category != null ||
      minSeverity != null ||
      maxSeverity != null ||
      startDate != null ||
      endDate != null;

  HistoryFilters copyWith({
    String? Function()? symptomName,
    String? Function()? category,
    int? Function()? minSeverity,
    int? Function()? maxSeverity,
    DateTime? Function()? startDate,
    DateTime? Function()? endDate,
  }) {
    return HistoryFilters(
      symptomName: symptomName != null ? symptomName() : this.symptomName,
      category: category != null ? category() : this.category,
      minSeverity: minSeverity != null ? minSeverity() : this.minSeverity,
      maxSeverity: maxSeverity != null ? maxSeverity() : this.maxSeverity,
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
    );
  }
}

final historyViewModeProvider =
    StateProvider<HistoryViewMode>((ref) => HistoryViewMode.list);

final historyFiltersProvider =
    StateProvider<HistoryFilters>((ref) => const HistoryFilters());

final filteredEntriesProvider = FutureProvider<List<SymptomEntry>>((ref) {
  final filters = ref.watch(historyFiltersProvider);
  return ref.watch(symptomEntryDaoProvider).getFilteredEntries(
        symptomName: filters.symptomName,
        category: filters.category,
        minSeverity: filters.minSeverity,
        maxSeverity: filters.maxSeverity,
        startDate: filters.startDate,
        endDate: filters.endDate,
      );
});

final selectedCalendarDayProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

final calendarDayEntriesProvider = StreamProvider<List<SymptomEntry>>((ref) {
  final day = ref.watch(selectedCalendarDayProvider);
  return ref.watch(symptomEntryDaoProvider).watchEntriesForDate(day);
});

final allEntriesStreamProvider = StreamProvider<List<SymptomEntry>>((ref) {
  return ref.watch(symptomEntryDaoProvider).watchAllEntries();
});
