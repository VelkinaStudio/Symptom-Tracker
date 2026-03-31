import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';

class TriggerSelector extends ConsumerStatefulWidget {
  final Set<int> selectedIds;
  final ValueChanged<int> onToggle;

  const TriggerSelector({
    super.key,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  ConsumerState<TriggerSelector> createState() => _TriggerSelectorState();
}

class _TriggerSelectorState extends ConsumerState<TriggerSelector> {
  List<TriggerEntry> _triggers = [];

  @override
  void initState() {
    super.initState();
    _loadTriggers();
  }

  Future<void> _loadTriggers() async {
    final dao = ref.read(triggerDaoProvider);
    final triggers = await dao.getAllTriggers();
    if (mounted) {
      setState(() => _triggers = triggers);
    }
  }

  Future<void> _showAddTriggerDialog() async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Custom Trigger'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Trigger name',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                Navigator.of(ctx).pop(text);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      final dao = ref.read(triggerDaoProvider);
      final id = await dao.insertTrigger(
        TriggersCompanion.insert(
          name: result,
          category: 'custom',
        ),
      );
      await _loadTriggers();
      widget.onToggle(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Triggers (optional)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            ..._triggers.map((trigger) {
              return FilterChip(
                label: Text(trigger.name),
                selected: widget.selectedIds.contains(trigger.id),
                onSelected: (_) => widget.onToggle(trigger.id),
              );
            }),
            ActionChip(
              avatar: const Icon(Icons.add, size: 16),
              label: const Text('Custom'),
              onPressed: _showAddTriggerDialog,
            ),
          ],
        ),
      ],
    );
  }
}
