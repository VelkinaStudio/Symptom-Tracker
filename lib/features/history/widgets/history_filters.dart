import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';

class HistoryFiltersSheet extends ConsumerStatefulWidget {
  const HistoryFiltersSheet({super.key});

  @override
  ConsumerState<HistoryFiltersSheet> createState() =>
      _HistoryFiltersSheetState();
}

class _HistoryFiltersSheetState extends ConsumerState<HistoryFiltersSheet> {
  String? _selectedCategory;
  double _minSeverity = 1;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(historyFiltersProvider);
    _selectedCategory = filters.category;
    _minSeverity = (filters.minSeverity ?? 1).toDouble();
  }

  void _apply() {
    ref.read(historyFiltersProvider.notifier).state = HistoryFilters(
      category: _selectedCategory,
      minSeverity: _minSeverity > 1 ? _minSeverity.round() : null,
    );
    Navigator.of(context).pop();
  }

  void _clearAll() {
    setState(() {
      _selectedCategory = null;
      _minSeverity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    const categories = ['Physical', 'Mental'];

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: _clearAll,
                    child: const Text('Clear all'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) =>
                        setState(() => _selectedCategory = null),
                  ),
                  ...categories.map(
                    (cat) => ChoiceChip(
                      label: Text(cat),
                      selected: _selectedCategory == cat,
                      onSelected: (selected) => setState(
                        () => _selectedCategory = selected ? cat : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum severity',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    _minSeverity.round().toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Slider(
                value: _minSeverity,
                min: 1,
                max: 10,
                divisions: 9,
                label: _minSeverity.round().toString(),
                onChanged: (value) => setState(() => _minSeverity = value),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _apply,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
