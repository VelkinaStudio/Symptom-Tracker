import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/history_provider.dart';
import 'entry_card.dart';

class HistoryCalendarView extends ConsumerWidget {
  const HistoryCalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedCalendarDayProvider);
    final allEntriesAsync = ref.watch(allEntriesStreamProvider);
    final dayEntriesAsync = ref.watch(calendarDayEntriesProvider);

    // Build a set of days that have events
    final eventDays = <DateTime>{};
    allEntriesAsync.whenData((entries) {
      for (final entry in entries) {
        eventDays.add(
          DateTime(
              entry.startedAt.year, entry.startedAt.month, entry.startedAt.day),
        );
      }
    });

    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime.now(),
          focusedDay: selectedDay,
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          sixWeekMonthsEnforced: true,
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          eventLoader: (day) {
            final normalized =
                DateTime(day.year, day.month, day.day);
            return eventDays.contains(normalized) ? [true] : [];
          },
          onDaySelected: (selected, focused) {
            ref.read(selectedCalendarDayProvider.notifier).state = selected;
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: dayEntriesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (entries) {
              if (entries.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('No entries for this day.'),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => context.push(
                          '/log?date=${selectedDay.toIso8601String()}',
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Symptom'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) =>
                    EntryCard(entry: entries[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
