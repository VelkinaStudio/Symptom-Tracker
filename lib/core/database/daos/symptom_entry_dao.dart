// lib/core/database/daos/symptom_entry_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/symptom_entries.dart';
import '../tables/entry_triggers.dart';

part 'symptom_entry_dao.g.dart';

@DriftAccessor(tables: [SymptomEntries, EntryTriggers])
class SymptomEntryDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomEntryDaoMixin {
  SymptomEntryDao(super.db);

  Future<List<SymptomEntry>> getAllEntries() =>
      (select(symptomEntries)
            ..where((e) => e.deleted.equals(false))
            ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
          .get();

  Stream<List<SymptomEntry>> watchAllEntries() =>
      (select(symptomEntries)
            ..where((e) => e.deleted.equals(false))
            ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
          .watch();

  Stream<List<SymptomEntry>> watchEntriesForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(symptomEntries)
          ..where((e) =>
              e.deleted.equals(false) &
              e.startedAt.isBiggerOrEqualValue(start) &
              e.startedAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
        .watch();
  }

  Stream<List<SymptomEntry>> watchEntriesInRange(
      DateTime start, DateTime end) {
    return (select(symptomEntries)
          ..where((e) =>
              e.deleted.equals(false) &
              e.startedAt.isBiggerOrEqualValue(start) &
              e.startedAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
        .watch();
  }

  Future<List<SymptomEntry>> getEntriesInRange(
      DateTime start, DateTime end) {
    return (select(symptomEntries)
          ..where((e) =>
              e.deleted.equals(false) &
              e.startedAt.isBiggerOrEqualValue(start) &
              e.startedAt.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
        .get();
  }

  Future<List<SymptomEntry>> getFilteredEntries({
    String? symptomName,
    String? category,
    int? minSeverity,
    int? maxSeverity,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return (select(symptomEntries)
          ..where((e) {
            Expression<bool> condition = e.deleted.equals(false);
            if (symptomName != null) {
              condition = condition & e.symptomName.equals(symptomName);
            }
            if (category != null) {
              condition = condition & e.category.equals(category);
            }
            if (minSeverity != null) {
              condition =
                  condition & e.severity.isBiggerOrEqualValue(minSeverity);
            }
            if (maxSeverity != null) {
              condition =
                  condition & e.severity.isSmallerOrEqualValue(maxSeverity);
            }
            if (startDate != null) {
              condition =
                  condition & e.startedAt.isBiggerOrEqualValue(startDate);
            }
            if (endDate != null) {
              condition =
                  condition & e.startedAt.isSmallerThanValue(endDate);
            }
            return condition;
          })
          ..orderBy([(e) => OrderingTerm.desc(e.startedAt)]))
        .get();
  }

  Future<int> insertEntry(SymptomEntriesCompanion entry) =>
      into(symptomEntries).insert(entry);

  Future<bool> updateEntry(SymptomEntriesCompanion entry) =>
      update(symptomEntries).replace(entry.copyWith(
        updatedAt: Value(DateTime.now()),
      ));

  Future<void> softDeleteEntry(int id) =>
      (update(symptomEntries)..where((e) => e.id.equals(id))).write(
        SymptomEntriesCompanion(
          deleted: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> setTriggersForEntry(
      int entryId, List<int> triggerIds) async {
    await (delete(entryTriggers)
          ..where((et) => et.entryId.equals(entryId)))
        .go();
    for (final triggerId in triggerIds) {
      await into(entryTriggers).insert(
        EntryTriggersCompanion.insert(
          entryId: entryId,
          triggerId: triggerId,
        ),
      );
    }
  }

  Future<List<int>> getTriggerIdsForEntry(int entryId) async {
    final rows = await (select(entryTriggers)
          ..where((et) => et.entryId.equals(entryId)))
        .get();
    return rows.map((r) => r.triggerId).toList();
  }

  Future<int> countEntriesForDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final count = countAll();
    final query = selectOnly(symptomEntries)
      ..addColumns([count])
      ..where(symptomEntries.deleted.equals(false) &
          symptomEntries.startedAt.isBiggerOrEqualValue(start) &
          symptomEntries.startedAt.isSmallerThanValue(end));
    final result = await query.getSingle();
    return result.read(count)!;
  }

  Future<int> countTotalDaysWithEntries() async {
    final query = customSelect(
      'SELECT COUNT(DISTINCT DATE(started_at)) as count FROM symptom_entries WHERE deleted = 0',
      readsFrom: {symptomEntries},
    );
    final result = await query.getSingle();
    return result.data['count'] as int;
  }

  Future<void> deleteAllEntries() async {
    await delete(entryTriggers).go();
    await delete(symptomEntries).go();
  }
}
