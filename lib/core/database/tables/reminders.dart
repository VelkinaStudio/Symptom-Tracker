// lib/core/database/tables/reminders.dart
import 'package:drift/drift.dart';

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().withLength(min: 1, max: 50)();
  TextColumn get timeOfDay => text().withLength(min: 5, max: 5)();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
}
