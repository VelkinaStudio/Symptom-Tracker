// test/core/database/daos/trigger_dao_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('TriggerDao', () {
    test('default triggers are seeded on creation (12 triggers)', () async {
      final triggers = await db.triggerDao.getAllTriggers();
      expect(triggers.length, 12);
    });

    test('seeded triggers have isDefault set to true', () async {
      final triggers = await db.triggerDao.getAllTriggers();
      expect(triggers.every((t) => t.isDefault), true);
    });

    test('insert a custom trigger', () async {
      await db.triggerDao.insertTrigger(
        TriggersCompanion.insert(
          name: 'Travel',
          category: 'lifestyle',
        ),
      );

      final triggers = await db.triggerDao.getAllTriggers();
      expect(triggers.length, 13);

      final custom = triggers.firstWhere((t) => t.name == 'Travel');
      expect(custom.name, 'Travel');
      expect(custom.category, 'lifestyle');
      expect(custom.isDefault, false);
    });

    test('delete a trigger', () async {
      // Insert a custom trigger so we don't disturb the seeded ones
      final id = await db.triggerDao.insertTrigger(
        TriggersCompanion.insert(
          name: 'Humidity',
          category: 'lifestyle',
        ),
      );

      var triggers = await db.triggerDao.getAllTriggers();
      expect(triggers.length, 13);

      await db.triggerDao.deleteTrigger(id);

      triggers = await db.triggerDao.getAllTriggers();
      expect(triggers.length, 12);
      expect(triggers.any((t) => t.name == 'Humidity'), false);
    });

    test('rank top triggers in a date range', () async {
      final base = DateTime(2026, 3, 30, 10, 0);

      final allTriggers = await db.triggerDao.getAllTriggers();
      final stressTrigger =
          allTriggers.firstWhere((t) => t.name == 'Stress');
      final sleepTrigger =
          allTriggers.firstWhere((t) => t.name == 'Poor sleep');
      final caffeineTrigger =
          allTriggers.firstWhere((t) => t.name == 'Caffeine');

      // Insert 3 entries, link triggers so Stress appears most often
      final entry1 = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 5,
          startedAt: base,
        ),
      );
      final entry2 = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Anxiety',
          category: 'mental',
          severity: 6,
          startedAt: base.add(const Duration(hours: 1)),
        ),
      );
      final entry3 = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Fatigue',
          category: 'physical',
          severity: 4,
          startedAt: base.add(const Duration(hours: 2)),
        ),
      );

      // Stress linked to all 3, Poor sleep to 2, Caffeine to 1
      await db.symptomEntryDao.setTriggersForEntry(entry1,
          [stressTrigger.id, sleepTrigger.id, caffeineTrigger.id]);
      await db.symptomEntryDao
          .setTriggersForEntry(entry2, [stressTrigger.id, sleepTrigger.id]);
      await db.symptomEntryDao
          .setTriggersForEntry(entry3, [stressTrigger.id]);

      final rangeStart = DateTime(2026, 3, 30);
      final rangeEnd = DateTime(2026, 3, 31);
      final top = await db.triggerDao
          .getTopTriggersInRange(rangeStart, rangeEnd);

      expect(top.isNotEmpty, true);
      expect(top.first.key, 'Stress');
      expect(top.first.value, 3);
      expect(top[1].key, 'Poor sleep');
      expect(top[1].value, 2);
      expect(top[2].key, 'Caffeine');
      expect(top[2].value, 1);
    });

    test('getTopTriggersInRange ignores entries outside range', () async {
      final inRange = DateTime(2026, 3, 30, 10, 0);
      final outOfRange = DateTime(2026, 3, 28, 10, 0);

      final allTriggers = await db.triggerDao.getAllTriggers();
      final stressTrigger =
          allTriggers.firstWhere((t) => t.name == 'Stress');

      final entry1 = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 5,
          startedAt: inRange,
        ),
      );
      final entry2 = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Nausea',
          category: 'physical',
          severity: 3,
          startedAt: outOfRange,
        ),
      );

      await db.symptomEntryDao
          .setTriggersForEntry(entry1, [stressTrigger.id]);
      await db.symptomEntryDao
          .setTriggersForEntry(entry2, [stressTrigger.id]);

      final rangeStart = DateTime(2026, 3, 30);
      final rangeEnd = DateTime(2026, 3, 31);
      final top = await db.triggerDao
          .getTopTriggersInRange(rangeStart, rangeEnd);

      expect(top.length, 1);
      expect(top.first.key, 'Stress');
      expect(top.first.value, 1);
    });
  });
}
