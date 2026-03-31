// lib/core/database/tables/triggers.dart
import 'package:drift/drift.dart';

@DataClassName('TriggerEntry')
class Triggers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100).unique()();
  TextColumn get category => text().withLength(min: 1, max: 50)();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}
