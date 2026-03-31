// lib/core/database/tables/entry_triggers.dart
import 'package:drift/drift.dart';
import 'symptom_entries.dart';
import 'triggers.dart';

class EntryTriggers extends Table {
  IntColumn get entryId => integer().references(SymptomEntries, #id)();
  IntColumn get triggerId => integer().references(Triggers, #id)();

  @override
  Set<Column> get primaryKey => {entryId, triggerId};
}
