import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/severity_utils.dart';

class TodayEntriesList extends StatelessWidget {
  final List<SymptomEntry> entries;

  const TodayEntriesList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                'No symptoms logged today',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Today's entries",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...entries.map((entry) => _EntryCard(entry: entry)),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  final SymptomEntry entry;

  const _EntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final severity = entry.severity;
    final severityColor = SeverityUtils.color(severity);
    final severityBg = SeverityUtils.backgroundColor(severity);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: severityBg,
          child: Text(
            severity.toString(),
            style: TextStyle(
              color: severityColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(entry.symptomName),
        subtitle: Text(AppDateUtils.formatTime(entry.startedAt)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/log/${entry.id}'),
      ),
    );
  }
}
