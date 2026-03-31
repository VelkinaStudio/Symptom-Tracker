// lib/core/database/tables/symptom_entries.dart
import 'package:drift/drift.dart';

class SymptomEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get remoteId => text().nullable()();
  TextColumn get symptomName => text().withLength(min: 1, max: 200)();
  TextColumn get category => text().withLength(min: 1, max: 50)();
  IntColumn get severity =>
      integer().customConstraint('NOT NULL CHECK (severity BETWEEN 1 AND 10)')();
  DateTimeColumn get startedAt => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get reliefAction => text().nullable()();
  IntColumn get improvedAfterAction => integer().nullable()();
  TextColumn get bodyLocation => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
}
