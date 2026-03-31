// lib/core/database/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/symptom_entries.dart';
import 'tables/triggers.dart';
import 'tables/entry_triggers.dart';
import 'tables/symptom_presets.dart';
import 'tables/reminders.dart';
import 'tables/sync_meta.dart';
import 'daos/symptom_entry_dao.dart';
import 'daos/trigger_dao.dart';
import 'daos/symptom_preset_dao.dart';
import 'daos/reminder_dao.dart';
import 'daos/sync_meta_dao.dart';
import 'seed_data.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SymptomEntries,
    Triggers,
    EntryTriggers,
    SymptomPresets,
    Reminders,
    SyncMeta,
  ],
  daos: [
    SymptomEntryDao,
    TriggerDao,
    SymptomPresetDao,
    ReminderDao,
    SyncMetaDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaults();
        },
      );

  Future<void> _seedDefaults() async {
    for (final trigger in SeedData.defaultTriggers) {
      await into(triggers).insert(TriggersCompanion.insert(
        name: trigger['name']!,
        category: trigger['category']!,
        isDefault: const Value(true),
      ));
    }
    for (final preset in SeedData.defaultSymptomPresets) {
      await into(symptomPresets).insert(SymptomPresetsCompanion.insert(
        name: preset['name']!,
        category: preset['category']!,
        isDefault: const Value(true),
      ));
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'symptom_tracker.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
