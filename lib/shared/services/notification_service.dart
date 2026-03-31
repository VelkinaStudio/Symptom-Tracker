import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _dayMap = {
    'mon': DateTime.monday,
    'tue': DateTime.tuesday,
    'wed': DateTime.wednesday,
    'thu': DateTime.thursday,
    'fri': DateTime.friday,
    'sat': DateTime.saturday,
    'sun': DateTime.sunday,
  };

  static Future<void> initialize() async {
    tz_data.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _plugin.initialize(settings);
  }

  static Future<void> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  static Future<void> scheduleDailyReminder({required int id, required int hour, required int minute, required String title, required String body}) async {
    await _plugin.zonedSchedule(id, title, body, _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails('daily_reminder', 'Daily Reminders', channelDescription: 'Daily symptom logging reminders', importance: Importance.defaultImportance, priority: Priority.defaultPriority),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule reminders only on specific days of the week.
  /// [days] is a comma-separated string like "mon,tue,wed".
  static Future<void> scheduleWeeklyReminders({
    required int baseId,
    required int hour,
    required int minute,
    required String days,
    required String title,
    required String body,
  }) async {
    final dayList = days.split(',').map((d) => d.trim().toLowerCase()).where((d) => _dayMap.containsKey(d));
    var offset = 0;
    for (final day in dayList) {
      final weekday = _dayMap[day]!;
      await _plugin.zonedSchedule(
        baseId + offset,
        title,
        body,
        _nextInstanceOfDayAndTime(weekday, hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly_reminder', 'Weekly Reminders', channelDescription: 'Weekly symptom logging reminders', importance: Importance.defaultImportance, priority: Priority.defaultPriority),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      offset++;
    }
  }

  /// Schedule repeating reminders every [intervalHours] hours starting at [hour]:[minute].
  static Future<void> scheduleIntervalReminder({
    required int id,
    required int hour,
    required int minute,
    required int intervalHours,
    required String title,
    required String body,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails('interval_reminder', 'Interval Reminders', channelDescription: 'Recurring symptom logging reminders', importance: Importance.defaultImportance, priority: Priority.defaultPriority),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelReminder(int id) async => await _plugin.cancel(id);

  /// Cancel a range of IDs (used for weekly reminders which use baseId + 0..6).
  static Future<void> cancelReminderRange(int baseId, int count) async {
    for (var i = 0; i < count; i++) {
      await _plugin.cancel(baseId + i);
    }
  }

  static Future<void> cancelAll() async => await _plugin.cancelAll();

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) scheduled = scheduled.add(const Duration(days: 1));
    return scheduled;
  }

  static tz.TZDateTime _nextInstanceOfDayAndTime(int weekday, int hour, int minute) {
    var scheduled = _nextInstanceOfTime(hour, minute);
    while (scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
