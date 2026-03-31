import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';
import '../widgets/history_calendar_view.dart';
import '../widgets/history_filters.dart';
import '../widgets/history_list_view.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(historyViewModeProvider);
    final filters = ref.watch(historyFiltersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          Badge(
            isLabelVisible: filters.isActive,
            child: IconButton(
              tooltip: 'Filters',
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const HistoryFiltersSheet(),
                );
              },
            ),
          ),
        ],
      ),
      body: const HistoryCalendarView(),
    );
  }
}
