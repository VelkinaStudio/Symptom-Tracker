// lib/core/database/tables/symptom_presets.dart
import 'package:drift/drift.dart';

class SymptomPresets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get category => text().withLength(min: 1, max: 50)();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}
