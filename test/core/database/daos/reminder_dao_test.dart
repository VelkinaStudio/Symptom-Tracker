// test/core/database/daos/reminder_dao_test.dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:symptom_tracker/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('ReminderDao', () {
    test('insert and retrieve a reminder', () async {
      await db.reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'morning',
          timeOfDay: '08:00',
        ),
      );

      final reminders = await db.reminderDao.getAllReminders();
      expect(reminders.length, 1);
      expect(reminders.first.type, 'morning');
      expect(reminders.first.timeOfDay, '08:00');
      expect(reminders.first.enabled, true);
    });

    test('retrieve reminder by type', () async {
      await db.reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'evening',
          timeOfDay: '20:30',
        ),
      );

      final reminder = await db.reminderDao.getReminderByType('evening');
      expect(reminder, isA<Reminder>());
      expect(reminder!.type, 'evening');
      expect(reminder.timeOfDay, '20:30');
    });

    test('getReminderByType returns null for missing type', () async {
      final reminder =
          await db.reminderDao.getReminderByType('nonexistent');
      expect(reminder, equals(null));
    });

    test('toggle reminder disabled', () async {
      final id = await db.reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'morning',
          timeOfDay: '07:00',
        ),
      );

      var reminders = await db.reminderDao.getAllReminders();
      expect(reminders.first.enabled, true);

      await db.reminderDao.setEnabled(id, false);

      reminders = await db.reminderDao.getAllReminders();
      expect(reminders.first.enabled, false);
    });

    test('toggle reminder back to enabled', () async {
      final id = await db.reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'morning',
          timeOfDay: '07:00',
          enabled: const Value(false),
        ),
      );

      var reminders = await db.reminderDao.getAllReminders();
      expect(reminders.first.enabled, false);

      await db.reminderDao.setEnabled(id, true);

      reminders = await db.reminderDao.getAllReminders();
      expect(reminders.first.enabled, true);
    });

    test('update reminder time', () async {
      final id = await db.reminderDao.insertReminder(
        RemindersCompanion.insert(
          type: 'morning',
          timeOfDay: '07:00',
        ),
      );

      await db.reminderDao.setTime(id, '09:15');

      final reminders = await db.reminderDao.getAllReminders();
      expect(reminders.first.timeOfDay, '09:15');
    });

    test('insert multiple reminders and retrieve all', () async {
      await db.reminderDao.insertReminder(
        RemindersCompanion.insert(type: 'morning', timeOfDay: '08:00'),
      );
      await db.reminderDao.insertReminder(
        RemindersCompanion.insert(type: 'evening', timeOfDay: '20:00'),
      );
      await db.reminderDao.insertReminder(
        RemindersCompanion.insert(type: 'noon', timeOfDay: '12:00'),
      );

      final reminders = await db.reminderDao.getAllReminders();
      expect(reminders.length, 3);
      final types = reminders.map((r) => r.type).toList();
      expect(types, containsAll(['morning', 'evening', 'noon']));
    });
  });
}
