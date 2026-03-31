// lib/core/database/daos/trigger_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/triggers.dart';
import '../tables/entry_triggers.dart';
import '../tables/symptom_entries.dart';

part 'trigger_dao.g.dart';

@DriftAccessor(tables: [Triggers, EntryTriggers, SymptomEntries])
class TriggerDao extends DatabaseAccessor<AppDatabase>
    with _$TriggerDaoMixin {
  TriggerDao(super.db);

  Future<List<TriggerEntry>> getAllTriggers() =>
      (select(triggers)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();

  Stream<List<TriggerEntry>> watchAllTriggers() =>
      (select(triggers)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<int> insertTrigger(TriggersCompanion trigger) =>
      into(triggers).insert(trigger);

  Future<void> deleteTrigger(int id) =>
      (delete(triggers)..where((t) => t.id.equals(id))).go();

  /// Returns trigger names ranked by frequency within a date range.
  Future<List<MapEntry<String, int>>> getTopTriggersInRange(
      DateTime start, DateTime end) async {
    final query = customSelect(
      '''
      SELECT t.name, COUNT(et.entry_id) as count
      FROM triggers t
      INNER JOIN entry_triggers et ON t.id = et.trigger_id
      INNER JOIN symptom_entries se ON et.entry_id = se.id
      WHERE se.deleted = 0
        AND se.started_at >= ?
        AND se.started_at < ?
      GROUP BY t.name
      ORDER BY count DESC
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
      readsFrom: {triggers, entryTriggers, symptomEntries},
    );
    final rows = await query.get();
    return rows
        .map((r) => MapEntry(r.data['name'] as String, r.data['count'] as int))
        .toList();
  }
}
