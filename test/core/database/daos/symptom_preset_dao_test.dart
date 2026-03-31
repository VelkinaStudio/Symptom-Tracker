// test/core/database/daos/symptom_preset_dao_test.dart
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

  group('SymptomPresetDao', () {
    test('default presets are seeded on creation (20 presets)', () async {
      final presets = await db.symptomPresetDao.getAllPresets();
      expect(presets.length, 20);
    });

    test('seeded presets have isDefault set to true', () async {
      final presets = await db.symptomPresetDao.getAllPresets();
      expect(presets.every((p) => p.isDefault), true);
    });

    test('filter presets by physical category returns 10 presets', () async {
      final physical =
          await db.symptomPresetDao.getPresetsByCategory('physical');
      expect(physical.length, 10);
      expect(physical.every((p) => p.category == 'physical'), true);
    });

    test('filter presets by mental category returns 10 presets', () async {
      final mental =
          await db.symptomPresetDao.getPresetsByCategory('mental');
      expect(mental.length, 10);
      expect(mental.every((p) => p.category == 'mental'), true);
    });

    test('insert a custom preset', () async {
      await db.symptomPresetDao.insertPreset(
        SymptomPresetsCompanion.insert(
          name: 'Tinnitus',
          category: 'physical',
        ),
      );

      final presets = await db.symptomPresetDao.getAllPresets();
      expect(presets.length, 21);

      final custom = presets.firstWhere((p) => p.name == 'Tinnitus');
      expect(custom.name, 'Tinnitus');
      expect(custom.category, 'physical');
      expect(custom.isDefault, false);
    });

    test('custom preset appears in category filter', () async {
      await db.symptomPresetDao.insertPreset(
        SymptomPresetsCompanion.insert(
          name: 'Custom Mental',
          category: 'mental',
        ),
      );

      final mental =
          await db.symptomPresetDao.getPresetsByCategory('mental');
      expect(mental.length, 11);
      expect(mental.any((p) => p.name == 'Custom Mental'), true);
    });

    test('delete a preset', () async {
      final id = await db.symptomPresetDao.insertPreset(
        SymptomPresetsCompanion.insert(
          name: 'Temporary Preset',
          category: 'physical',
        ),
      );

      var presets = await db.symptomPresetDao.getAllPresets();
      expect(presets.length, 21);

      await db.symptomPresetDao.deletePreset(id);

      presets = await db.symptomPresetDao.getAllPresets();
      expect(presets.length, 20);
      expect(presets.any((p) => p.name == 'Temporary Preset'), false);
    });
  });
}
