import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../core/database/app_database.dart';
import '../providers/onboarding_provider.dart';

class SymptomPickerPage extends ConsumerWidget {
  const SymptomPickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<SymptomPreset>>(
      future: ref.read(symptomPresetDaoProvider).getAllPresets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading presets: ${snapshot.error}'));
        }

        final presets = snapshot.data ?? [];
        final physicalPresets =
            presets.where((p) => p.category == 'physical').toList();
        final mentalPresets =
            presets.where((p) => p.category == 'mental').toList();

        return Consumer(
          builder: (context, ref, _) {
            final selectedIds =
                ref.watch(onboardingProvider).selectedPresetIds;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you want to track?',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the symptoms you experience. You can always add more later.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (physicalPresets.isNotEmpty) ...[
                    Text(
                      'Physical',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: physicalPresets.map((preset) {
                        final selected = selectedIds.contains(preset.id);
                        return FilterChip(
                          label: Text(preset.name),
                          selected: selected,
                          onSelected: (_) => ref
                              .read(onboardingProvider.notifier)
                              .togglePreset(preset.id),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (mentalPresets.isNotEmpty) ...[
                    Text(
                      'Mental',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: mentalPresets.map((preset) {
                        final selected = selectedIds.contains(preset.id);
                        return FilterChip(
                          label: Text(preset.name),
                          selected: selected,
                          onSelected: (_) => ref
                              .read(onboardingProvider.notifier)
                              .togglePreset(preset.id),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
