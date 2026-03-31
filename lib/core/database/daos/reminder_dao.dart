// lib/core/database/daos/reminder_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/reminders.dart';

part 'reminder_dao.g.dart';

@DriftAccessor(tables: [Reminders])
class ReminderDao extends DatabaseAccessor<AppDatabase>
    with _$ReminderDaoMixin {
  ReminderDao(super.db);

  Future<List<Reminder>> getAllReminders() => select(reminders).get();

  Stream<List<Reminder>> watchAllReminders() => select(reminders).watch();

  Future<Reminder?> getReminderByType(String type) =>
      (select(reminders)..where((r) => r.type.equals(type)))
          .getSingleOrNull();

  Future<int> insertReminder(RemindersCompanion reminder) =>
      into(reminders).insert(reminder);

  Future<void> updateReminder(RemindersCompanion reminder) =>
      update(reminders).replace(reminder as Insertable<Reminder>);

  Future<void> setEnabled(int id, bool enabled) =>
      (update(reminders)..where((r) => r.id.equals(id)))
          .write(RemindersCompanion(enabled: Value(enabled)));

  Future<void> setTime(int id, String timeOfDay) =>
      (update(reminders)..where((r) => r.id.equals(id)))
          .write(RemindersCompanion(timeOfDay: Value(timeOfDay)));
}
