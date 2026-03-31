import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationPicker extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const DurationPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static const _quickOptions = [
    (label: '15m', minutes: 15),
    (label: '30m', minutes: 30),
    (label: '1h', minutes: 60),
    (label: '2h', minutes: 120),
    (label: '4h+', minutes: 240),
  ];

  Future<void> _showCustomDialog(BuildContext context) async {
    final controller = TextEditingController(
      text: value != null && !_isQuickOption(value!) ? '$value' : '',
    );

    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Custom Duration'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Minutes',
            suffix: Text('min'),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = int.tryParse(controller.text);
              Navigator.of(ctx).pop(val);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );

    if (result != null && result > 0) {
      onChanged(result);
    }
  }

  bool _isQuickOption(int minutes) {
    return _quickOptions.any((o) => o.minutes == minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duration (optional)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            ..._quickOptions.map((option) {
              return ChoiceChip(
                label: Text(option.label),
                selected: value == option.minutes,
                onSelected: (selected) {
                  onChanged(selected ? option.minutes : null);
                },
              );
            }),
            TextButton(
              onPressed: () => _showCustomDialog(context),
              child: const Text('Custom'),
            ),
          ],
        ),
      ],
    );
  }
}
