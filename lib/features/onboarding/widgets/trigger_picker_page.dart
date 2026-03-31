import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../core/database/app_database.dart';
import '../providers/onboarding_provider.dart';

class TriggerPickerPage extends ConsumerWidget {
  const TriggerPickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<TriggerEntry>>(
      future: ref.read(triggerDaoProvider).getAllTriggers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text('Error loading triggers: ${snapshot.error}'));
        }

        final triggerList = snapshot.data ?? [];

        return Consumer(
          builder: (context, ref, _) {
            final selectedIds =
                ref.watch(onboardingProvider).selectedTriggerIds;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Common triggers',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select triggers that commonly affect you. This helps identify patterns in your symptoms.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: triggerList.map((trigger) {
                      final selected = selectedIds.contains(trigger.id);
                      return FilterChip(
                        label: Text(trigger.name),
                        selected: selected,
                        onSelected: (_) => ref
                            .read(onboardingProvider.notifier)
                            .toggleTrigger(trigger.id),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
