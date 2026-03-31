import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_provider.dart';
import '../providers/log_symptom_provider.dart';

class SymptomSearchField extends ConsumerStatefulWidget {
  const SymptomSearchField({super.key});

  @override
  ConsumerState<SymptomSearchField> createState() =>
      _SymptomSearchFieldState();
}

class _SymptomSearchFieldState extends ConsumerState<SymptomSearchField> {
  late final TextEditingController _controller;
  List<SymptomPreset> _presets = [];
  String _filterCategory = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadPresets();
  }

  Future<void> _loadPresets() async {
    final dao = ref.read(symptomPresetDaoProvider);
    final presets = await dao.getAllPresets();
    if (mounted) {
      setState(() => _presets = presets);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<SymptomPreset> get _filteredPresets {
    final query = _controller.text.toLowerCase();
    return _presets.where((p) {
      final matchesCategory =
          _filterCategory.isEmpty || p.category == _filterCategory;
      final matchesQuery =
          query.isEmpty || p.name.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(logSymptomProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Symptom name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            notifier.setSymptomName(value);
            setState(() {});
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ChoiceChip(
              label: const Text('Physical'),
              selected: _filterCategory == 'physical',
              onSelected: (selected) {
                setState(() {
                  _filterCategory = selected ? 'physical' : '';
                });
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Mental'),
              selected: _filterCategory == 'mental',
              onSelected: (selected) {
                setState(() {
                  _filterCategory = selected ? 'mental' : '';
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_filteredPresets.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: _filteredPresets.map((preset) {
              return ActionChip(
                label: Text(preset.name),
                onPressed: () {
                  _controller.text = preset.name;
                  notifier.setSymptomName(preset.name);
                  notifier.setCategory(preset.category);
                  setState(() {});
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
