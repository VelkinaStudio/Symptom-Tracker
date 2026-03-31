import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/trends_provider.dart';
import '../widgets/frequency_chart.dart';
import '../widgets/severity_chart.dart';
import '../widgets/top_triggers_chart.dart';
import '../widgets/top_symptoms_list.dart';

class TrendsScreen extends ConsumerWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(trendRangeProvider);
    final trendAsync = ref.watch(trendDataProvider);

    final daysBack = switch (range) {
      TrendRange.week => 7,
      TrendRange.month => 30,
      TrendRange.quarter => 90,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Trends')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: SegmentedButton<TrendRange>(
              segments: const [
                ButtonSegment(value: TrendRange.week, label: Text('7d')),
                ButtonSegment(value: TrendRange.month, label: Text('30d')),
                ButtonSegment(value: TrendRange.quarter, label: Text('90d')),
              ],
              selected: {range},
              onSelectionChanged: (selection) {
                ref.read(trendRangeProvider.notifier).state = selection.first;
              },
            ),
          ),
          Expanded(
            child: trendAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (data) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _SectionHeader(title: 'Frequency'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: FrequencyChart(
                      data: data.frequencyByDay,
                      daysBack: daysBack,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Average Severity'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: SeverityChart(
                      data: data.avgSeverityByDay,
                      daysBack: daysBack,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Top Triggers'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: data.topTriggers.isEmpty
                        ? 60
                        : (data.topTriggers.take(6).length * 40.0)
                            .clamp(60, 280),
                    child: TopTriggersChart(data: data.topTriggers),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Top Symptoms'),
                  const SizedBox(height: 4),
                  TopSymptomsList(symptoms: data.topSymptoms),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
