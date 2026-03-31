import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';

class PresetsSection extends ConsumerWidget {
  const PresetsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                'Manage Presets',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('Symptom presets'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showSymptomPresetsSheet(context, ref),
            ),
            ListTile(
              leading: const Icon(Icons.warning_amber_outlined),
              title: const Text('Trigger presets'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showTriggerPresetsSheet(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _showSymptomPresetsSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) =>
            _SymptomPresetsSheetContent(scrollController: scrollController, ref: ref),
      ),
    );
  }

  void _showTriggerPresetsSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) =>
            _TriggerPresetsSheetContent(scrollController: scrollController, ref: ref),
      ),
    );
  }
}

// ─── Symptom presets sheet ────────────────────────────────────────────────────

class _SymptomPresetsSheetContent extends ConsumerWidget {
  final ScrollController scrollController;
  final WidgetRef ref;

  const _SymptomPresetsSheetContent({
    required this.scrollController,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef consumerRef) {
    final dao = consumerRef.watch(symptomPresetDaoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<SymptomPreset>>(
      future: dao.getAllPresets(),
      builder: (context, snapshot) {
        final presets = snapshot.data ?? [];
        return Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('Symptom Presets',
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Add preset',
                    onPressed: () => _showAddSymptomDialog(context, consumerRef),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: presets.length,
                      itemBuilder: (context, index) {
                        final preset = presets[index];
                        return ListTile(
                          title: Text(preset.name),
                          subtitle: Text(preset.category),
                          trailing: preset.isDefault
                              ? null
                              : IconButton(
                                  icon: Icon(Icons.delete_outline,
                                      color: colorScheme.error),
                                  tooltip: 'Delete',
                                  onPressed: () async {
                                    await dao.deletePreset(preset.id);
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      // ignore: use_build_context_synchronously
                                      (context as Element).markNeedsBuild();
                                    }
                                  },
                                ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddSymptomDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Symptom Preset'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final category = categoryController.text.trim();
              if (name.isNotEmpty && category.isNotEmpty) {
                await ref.read(symptomPresetDaoProvider).insertPreset(
                      SymptomPresetsCompanion.insert(name: name, category: category),
                    );
                if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    nameController.dispose();
    categoryController.dispose();
  }
}

// ─── Trigger presets sheet ────────────────────────────────────────────────────

class _TriggerPresetsSheetContent extends ConsumerWidget {
  final ScrollController scrollController;
  final WidgetRef ref;

  const _TriggerPresetsSheetContent({
    required this.scrollController,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef consumerRef) {
    final dao = consumerRef.watch(triggerDaoProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<TriggerEntry>>(
      future: dao.getAllTriggers(),
      builder: (context, snapshot) {
        final triggers = snapshot.data ?? [];
        return Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('Trigger Presets',
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Add trigger',
                    onPressed: () => _showAddTriggerDialog(context, consumerRef),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: triggers.length,
                      itemBuilder: (context, index) {
                        final trigger = triggers[index];
                        return ListTile(
                          title: Text(trigger.name),
                          subtitle: Text(trigger.category),
                          trailing: trigger.isDefault
                              ? null
                              : IconButton(
                                  icon: Icon(Icons.delete_outline,
                                      color: colorScheme.error),
                                  tooltip: 'Delete',
                                  onPressed: () async {
                                    await dao.deleteTrigger(trigger.id);
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddTriggerDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Trigger Preset'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final category = categoryController.text.trim();
              if (name.isNotEmpty && category.isNotEmpty) {
                await ref.read(triggerDaoProvider).insertTrigger(
                      TriggersCompanion.insert(name: name, category: category),
                    );
                if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    nameController.dispose();
    categoryController.dispose();
  }
}
