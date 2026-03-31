import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/database/daos/reminder_dao.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/services/notification_service.dart';

final remindersStreamProvider = StreamProvider<List<Reminder>>(
    (ref) => ref.watch(reminderDaoProvider).watchAllReminders());

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
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
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
                    title: const Text('Add reminder'),
                    subtitle: const Text('Get notified to log symptoms'),
                    onTap: () => _openEditor(context, ref, null),
                  );
                }
                return Column(
                  children: [
                    ...reminders
                        .map((r) => _ReminderTile(reminder: r)),
                    ListTile(
                      leading: const Icon(Icons.add_outlined),
                      title: const Text('Add reminder'),
                      onTap: () => _openEditor(context, ref, null),
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

  void _openEditor(BuildContext context, WidgetRef ref, Reminder? existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ReminderEditorSheet(
        existing: existing,
        dao: ref.read(reminderDaoProvider),
      ),
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

    final label = reminder.label.isNotEmpty ? reminder.label : _typeLabel(reminder);
    final subtitle = _buildSubtitle(timeDisplay, reminder);

    return SwitchListTile(
      title: Text(label),
      subtitle: Text(subtitle),
      value: reminder.enabled,
      onChanged: (value) async {
        await dao.setEnabled(reminder.id, value);
        if (value) {
          await _scheduleNotification(reminder);
        } else {
          await NotificationService.cancelReminderRange(reminder.id * 10, 7);
        }
      },
      secondary: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (action) async {
          if (action == 'edit') {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) =>
                  _ReminderEditorSheet(existing: reminder, dao: dao),
            );
          } else if (action == 'delete') {
            await NotificationService.cancelReminderRange(reminder.id * 10, 7);
            await dao.deleteReminder(reminder.id);
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }

  Future<void> _scheduleNotification(Reminder r) async {
    final parts = r.timeOfDay.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;
    final label = r.label.isNotEmpty ? r.label : 'Symptom Tracker';
    final baseId = r.id * 10;

    // Cancel any existing notifications for this reminder
    await NotificationService.cancelReminderRange(baseId, 7);

    if (r.days.isNotEmpty) {
      await NotificationService.scheduleWeeklyReminders(
        baseId: baseId,
        hour: hour,
        minute: minute,
        days: r.days,
        title: label,
        body: 'Time to log your symptoms',
      );
    } else if (r.intervalHours != null && r.intervalHours! > 0) {
      await NotificationService.scheduleIntervalReminder(
        id: baseId,
        hour: hour,
        minute: minute,
        intervalHours: r.intervalHours!,
        title: label,
        body: 'Time to log your symptoms',
      );
    } else {
      await NotificationService.scheduleDailyReminder(
        id: baseId,
        hour: hour,
        minute: minute,
        title: label,
        body: 'Time to log your symptoms',
      );
    }
  }

  String _typeLabel(Reminder r) {
    if (r.intervalHours != null && r.intervalHours! > 0) {
      return 'Every ${r.intervalHours}h';
    }
    if (r.days.isNotEmpty) {
      return _formatDays(r.days);
    }
    return 'Daily';
  }

  String _formatDays(String days) {
    final list = days.split(',').map((d) => d.trim()).toList();
    if (list.length == 7) return 'Every day';
    if (_sameSet(list, ['mon', 'tue', 'wed', 'thu', 'fri'])) return 'Weekdays';
    if (_sameSet(list, ['sat', 'sun'])) return 'Weekends';
    return list.map((d) => d[0].toUpperCase() + d.substring(1)).join(', ');
  }

  bool _sameSet(List<String> a, List<String> b) =>
      a.length == b.length && a.toSet().containsAll(b);

  String _buildSubtitle(String time, Reminder r) {
    final parts = <String>[time];
    if (r.intervalHours != null && r.intervalHours! > 0) {
      parts.add('repeats every ${r.intervalHours}h');
    }
    if (r.days.isNotEmpty && r.label.isNotEmpty) {
      parts.add(_formatDays(r.days));
    }
    return parts.join(' · ');
  }
}

// --- Editor Bottom Sheet ---

class _ReminderEditorSheet extends StatefulWidget {
  final Reminder? existing;
  final ReminderDao dao;

  const _ReminderEditorSheet({this.existing, required this.dao});

  @override
  State<_ReminderEditorSheet> createState() => _ReminderEditorSheetState();
}

class _ReminderEditorSheetState extends State<_ReminderEditorSheet> {
  late TextEditingController _labelController;
  late TimeOfDay _time;
  late Set<String> _selectedDays;
  late int? _intervalHours;

  static const _allDays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  static const _dayLabels = {
    'mon': 'M',
    'tue': 'T',
    'wed': 'W',
    'thu': 'T',
    'fri': 'F',
    'sat': 'S',
    'sun': 'S',
  };

  @override
  void initState() {
    super.initState();
    final r = widget.existing;
    _labelController = TextEditingController(text: r?.label ?? '');
    if (r != null) {
      final parts = r.timeOfDay.split(':');
      _time = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 9,
        minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
      );
      _selectedDays = r.days.isNotEmpty
          ? r.days.split(',').map((d) => d.trim()).toSet()
          : _allDays.toSet();
      _intervalHours = r.intervalHours;
    } else {
      _time = const TimeOfDay(hour: 9, minute: 0);
      _selectedDays = _allDays.toSet();
      _intervalHours = null;
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? 'Edit Reminder' : 'New Reminder',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 20),

          // Label
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
              labelText: 'Label (optional)',
              hintText: 'e.g. Morning check-in',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Time picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text('Time'),
            trailing: FilledButton.tonal(
              onPressed: _pickTime,
              child: Text(_time.format(context)),
            ),
          ),
          const SizedBox(height: 8),

          // Days of week
          Text('Days', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final day in _allDays)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FilterChip(
                      label: Text(_dayLabels[day]!),
                      selected: _selectedDays.contains(day),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDays.add(day);
                          } else if (_selectedDays.length > 1) {
                            _selectedDays.remove(day);
                          }
                        });
                      },
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _QuickDayButton(
                label: 'Every day',
                onTap: () => setState(() => _selectedDays = _allDays.toSet()),
              ),
              const SizedBox(width: 8),
              _QuickDayButton(
                label: 'Weekdays',
                onTap: () => setState(
                    () => _selectedDays = {'mon', 'tue', 'wed', 'thu', 'fri'}),
              ),
              const SizedBox(width: 8),
              _QuickDayButton(
                label: 'Weekends',
                onTap: () => setState(() => _selectedDays = {'sat', 'sun'}),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Repeat interval
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.repeat),
            title: const Text('Repeat every'),
            trailing: DropdownButton<int?>(
              value: _intervalHours,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: null, child: Text('Off')),
                DropdownMenuItem(value: 2, child: Text('2 hours')),
                DropdownMenuItem(value: 3, child: Text('3 hours')),
                DropdownMenuItem(value: 4, child: Text('4 hours')),
                DropdownMenuItem(value: 6, child: Text('6 hours')),
                DropdownMenuItem(value: 8, child: Text('8 hours')),
                DropdownMenuItem(value: 12, child: Text('12 hours')),
              ],
              onChanged: (v) => setState(() => _intervalHours = v),
            ),
          ),
          const SizedBox(height: 20),

          // Save button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _save,
              child: Text(isEditing ? 'Update' : 'Save'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _save() async {
    final timeStr =
        '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
    final daysStr = _selectedDays.length == 7
        ? ''
        : _allDays.where((d) => _selectedDays.contains(d)).join(',');
    final type = _intervalHours != null && _intervalHours! > 0
        ? 'interval'
        : daysStr.isEmpty
            ? 'daily'
            : 'weekly';

    if (widget.existing != null) {
      // Cancel old notifications
      await NotificationService.cancelReminderRange(widget.existing!.id * 10, 7);
      await widget.dao.deleteReminder(widget.existing!.id);
    }
    final id = await widget.dao.insertReminder(RemindersCompanion.insert(
      type: type,
      timeOfDay: timeStr,
      label: Value(_labelController.text.trim()),
      days: Value(daysStr),
      intervalHours: Value(_intervalHours),
    ));

    // Schedule the notification
    final label = _labelController.text.trim();
    final baseId = id * 10;
    if (daysStr.isNotEmpty) {
      await NotificationService.scheduleWeeklyReminders(
        baseId: baseId,
        hour: _time.hour,
        minute: _time.minute,
        days: daysStr,
        title: label.isNotEmpty ? label : 'Symptom Tracker',
        body: 'Time to log your symptoms',
      );
    } else if (_intervalHours != null && _intervalHours! > 0) {
      await NotificationService.scheduleIntervalReminder(
        id: baseId,
        hour: _time.hour,
        minute: _time.minute,
        intervalHours: _intervalHours!,
        title: label.isNotEmpty ? label : 'Symptom Tracker',
        body: 'Time to log your symptoms',
      );
    } else {
      await NotificationService.scheduleDailyReminder(
        id: baseId,
        hour: _time.hour,
        minute: _time.minute,
        title: label.isNotEmpty ? label : 'Symptom Tracker',
        body: 'Time to log your symptoms',
      );
    }

    if (mounted) Navigator.of(context).pop();
  }
}

class _QuickDayButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickDayButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
