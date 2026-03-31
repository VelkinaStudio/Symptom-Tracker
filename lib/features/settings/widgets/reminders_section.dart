import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';

final remindersStreamProvider = StreamProvider<List<Reminder>>((ref) =>
    ref.watch(reminderDaoProvider).watchAllReminders());

class RemindersSection extends ConsumerWidget {
  const RemindersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersStreamProvider);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Reminders',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            remindersAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error: $e'),
              ),
              data: (reminders) {
                if (reminders.isEmpty) {
                  return ListTile(
                    leading: const Icon(Icons.add_alarm_outlined),
                    title: const Text('Add daily reminder'),
                    onTap: () => _addReminder(context, ref),
                  );
                }
                return Column(
                  children: [
                    ...reminders.map((reminder) => _ReminderTile(reminder: reminder)),
                    ListTile(
                      leading: const Icon(Icons.add_outlined),
                      title: const Text('Add reminder'),
                      onTap: () => _addReminder(context, ref),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addReminder(BuildContext context, WidgetRef ref) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked == null) return;

    final timeStr =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    await ref.read(reminderDaoProvider).insertReminder(
          RemindersCompanion.insert(type: 'daily', timeOfDay: timeStr),
        );
  }
}

class _ReminderTile extends ConsumerWidget {
  final Reminder reminder;

  const _ReminderTile({required this.reminder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dao = ref.read(reminderDaoProvider);

    final parts = reminder.timeOfDay.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
    final time = TimeOfDay(hour: hour, minute: minute);
    final timeDisplay = time.format(context);

    return SwitchListTile(
      title: Text(reminder.type),
      subtitle: Text(timeDisplay),
      value: reminder.enabled,
      onChanged: (value) async {
        await dao.setEnabled(reminder.id, value);
      },
      secondary: IconButton(
        icon: const Icon(Icons.schedule_outlined),
        tooltip: 'Change time',
        onPressed: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: time,
          );
          if (picked == null) return;
          final newTime =
              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
          await dao.setTime(reminder.id, newTime);
        },
      ),
    );
  }
}
