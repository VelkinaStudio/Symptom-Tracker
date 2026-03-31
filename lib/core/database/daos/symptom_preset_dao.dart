// lib/core/database/daos/symptom_preset_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/symptom_presets.dart';

part 'symptom_preset_dao.g.dart';

@DriftAccessor(tables: [SymptomPresets])
class SymptomPresetDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomPresetDaoMixin {
  SymptomPresetDao(super.db);

  Future<List<SymptomPreset>> getAllPresets() =>
      (select(symptomPresets)..orderBy([(p) => OrderingTerm.asc(p.name)]))
          .get();

  Stream<List<SymptomPreset>> watchAllPresets() =>
      (select(symptomPresets)..orderBy([(p) => OrderingTerm.asc(p.name)]))
          .watch();

  Future<List<SymptomPreset>> getPresetsByCategory(String category) =>
      (select(symptomPresets)
            ..where((p) => p.category.equals(category))
            ..orderBy([(p) => OrderingTerm.asc(p.name)]))
          .get();

  Future<int> insertPreset(SymptomPresetsCompanion preset) =>
      into(symptomPresets).insert(preset);

  Future<void> deletePreset(int id) =>
      (delete(symptomPresets)..where((p) => p.id.equals(id))).go();
}
