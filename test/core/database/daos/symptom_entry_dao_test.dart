// test/core/database/daos/symptom_entry_dao_test.dart
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

  group('SymptomEntryDao', () {
    test('insert and retrieve an entry', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 5,
          startedAt: now,
        ),
      );

      final entries = await db.symptomEntryDao.getAllEntries();

      expect(entries.length, 1);
      expect(entries.first.symptomName, 'Headache');
      expect(entries.first.category, 'physical');
      expect(entries.first.severity, 5);
    });

    test('soft delete makes entry disappear from getAllEntries', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      final id = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Nausea',
          category: 'physical',
          severity: 3,
          startedAt: now,
        ),
      );

      var entries = await db.symptomEntryDao.getAllEntries();
      expect(entries.length, 1);

      await db.symptomEntryDao.softDeleteEntry(id);

      entries = await db.symptomEntryDao.getAllEntries();
      expect(entries.length, 0);
    });

    test('filter entries by date range', () async {
      final day1 = DateTime(2026, 3, 28, 9, 0);
      final day2 = DateTime(2026, 3, 29, 9, 0);
      final day3 = DateTime(2026, 3, 30, 9, 0);

      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Fatigue',
          category: 'physical',
          severity: 4,
          startedAt: day1,
        ),
      );
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Anxiety',
          category: 'mental',
          severity: 6,
          startedAt: day2,
        ),
      );
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 5,
          startedAt: day3,
        ),
      );

      // rangeEnd is exclusive in getEntriesInRange (isSmallerThanValue),
      // so ending at the start of day3 excludes it.
      final rangeStart = DateTime(2026, 3, 29);
      final rangeEnd = DateTime(2026, 3, 30);
      final entries =
          await db.symptomEntryDao.getEntriesInRange(rangeStart, rangeEnd);

      expect(entries.length, 1);
      expect(entries.first.symptomName, 'Anxiety');
    });

    test('filter entries by symptom name', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 5,
          startedAt: now,
        ),
      );
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Nausea',
          category: 'physical',
          severity: 3,
          startedAt: now.add(const Duration(hours: 1)),
        ),
      );

      final filtered = await db.symptomEntryDao.getFilteredEntries(
        symptomName: 'Headache',
      );

      expect(filtered.length, 1);
      expect(filtered.first.symptomName, 'Headache');
    });

    test('filter entries by severity range', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Mild pain',
          category: 'physical',
          severity: 2,
          startedAt: now,
        ),
      );
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Moderate pain',
          category: 'physical',
          severity: 5,
          startedAt: now.add(const Duration(hours: 1)),
        ),
      );
      await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Severe pain',
          category: 'physical',
          severity: 9,
          startedAt: now.add(const Duration(hours: 2)),
        ),
      );

      final filtered = await db.symptomEntryDao.getFilteredEntries(
        minSeverity: 4,
        maxSeverity: 7,
      );

      expect(filtered.length, 1);
      expect(filtered.first.symptomName, 'Moderate pain');
    });

    test('set and retrieve triggers for an entry', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      final entryId = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Headache',
          category: 'physical',
          severity: 7,
          startedAt: now,
        ),
      );

      // Get seeded triggers to use real IDs
      final allTriggers = await db.triggerDao.getAllTriggers();
      expect(allTriggers.isNotEmpty, true);

      final trigger1Id = allTriggers[0].id;
      final trigger2Id = allTriggers[1].id;

      await db.symptomEntryDao
          .setTriggersForEntry(entryId, [trigger1Id, trigger2Id]);
      final triggerIds =
          await db.symptomEntryDao.getTriggerIdsForEntry(entryId);

      expect(triggerIds.length, 2);
      expect(triggerIds, containsAll([trigger1Id, trigger2Id]));
    });

    test('setTriggersForEntry replaces existing triggers', () async {
      final now = DateTime(2026, 3, 30, 10, 0);
      final entryId = await db.symptomEntryDao.insertEntry(
        SymptomEntriesCompanion.insert(
          symptomName: 'Migraine',
          category: 'physical',
          severity: 8,
          startedAt: now,
        ),
      );

      final allTriggers = await db.triggerDao.getAllTriggers();
      final trigger1Id = allTriggers[0].id;
      final trigger2Id = allTriggers[1].id;
      final trigger3Id = allTriggers[2].id;

      await db.symptomEntryDao.setTriggersForEntry(entryId, [trigger1Id]);
      await db.symptomEntryDao
          .setTriggersForEntry(entryId, [trigger2Id, trigger3Id]);

      final triggerIds =
          await db.symptomEntryDao.getTriggerIdsForEntry(entryId);

      expect(triggerIds.length, 2);
      expect(triggerIds, containsAll([trigger2Id, trigger3Id]));
      expect(triggerIds.contains(trigger1Id), false);
    });
  });
}
