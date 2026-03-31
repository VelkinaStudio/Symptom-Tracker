// lib/core/database/tables/reminders.dart
import 'package:drift/drift.dart';

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text().withLength(min: 1, max: 50)();
  TextColumn get timeOfDay => text().withLength(min: 5, max: 5)();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get label => text().withDefault(const Constant(''))();
  // Comma-separated days: "mon,tue,wed,thu,fri,sat,sun" — empty means every day
  TextColumn get days => text().withDefault(const Constant(''))();
  // Repeat interval in hours — null or 0 means no repeat (single daily)
  IntColumn get intervalHours => integer().nullable()();
}
