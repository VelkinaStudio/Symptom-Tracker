import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/auth_warning_banner.dart';
import '../widgets/stats_strip.dart';
import '../widgets/today_entries_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final todayEntriesAsync = ref.watch(todayEntriesProvider);
    final homeStatsAsync = ref.watch(homeStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Symptom Tracker'),
            Text(
              AppDateUtils.formatDate(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(todayEntriesProvider);
          ref.invalidate(homeStatsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // TEMP: Hidden for screenshots
            // if (!isLoggedIn) ...[
            //   const AuthWarningBanner(),
            //   const SizedBox(height: 12),
            // ],
            FilledButton.icon(
              onPressed: () => context.push('/log'),
              icon: const Icon(Icons.add),
              label: const Text('Log Symptom'),
            ),
            const SizedBox(height: 16),
            homeStatsAsync.when(
              data: (stats) => StatsStrip(stats: stats),
              loading: () => const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            todayEntriesAsync.when(
              data: (entries) => TodayEntriesList(entries: entries),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
