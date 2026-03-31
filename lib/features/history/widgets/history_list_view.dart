import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/date_utils.dart';
import '../providers/history_provider.dart';
import 'entry_card.dart';

class HistoryListView extends ConsumerWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(filteredEntriesProvider);

    return entriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(
            child: Text('No entries found.'),
          );
        }

        // Group entries by day
        final Map<DateTime, List<dynamic>> grouped = {};
        for (final entry in entries) {
          final day = AppDateUtils.startOfDay(entry.startedAt);
          grouped.putIfAbsent(day, () => []).add(entry);
        }

        // Sort days descending
        final sortedDays = grouped.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        // Build a flat list of items: day headers and entry cards
        final items = <dynamic>[];
        for (final day in sortedDays) {
          items.add(day); // header
          items.addAll(grouped[day]!);
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            if (item is DateTime) {
              return Padding(
                padding:
                    const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  AppDateUtils.formatDayGroup(item),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              );
            }
            return EntryCard(entry: item);
          },
        );
      },
    );
  }
}
