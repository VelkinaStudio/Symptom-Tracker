import 'package:flutter/material.dart';

class ReliefActionField extends StatelessWidget {
  final String value;
  final int? improvedAfterAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<int?> onImprovedChanged;

  const ReliefActionField({
    super.key,
    required this.value,
    required this.improvedAfterAction,
    required this.onChanged,
    required this.onImprovedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Relief action (optional)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            ),
          ),
          decoration: const InputDecoration(
            labelText: 'What did you do?',
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
        if (value.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Did it help?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment<int>(value: 1, label: Text('Yes')),
              ButtonSegment<int>(value: 0, label: Text('No')),
              ButtonSegment<int>(value: 2, label: Text('Not sure')),
            ],
            selected: {if (improvedAfterAction != null) improvedAfterAction!},
            emptySelectionAllowed: true,
            onSelectionChanged: (selection) {
              onImprovedChanged(selection.isEmpty ? null : selection.first);
            },
          ),
        ],
      ],
    );
  }
}
