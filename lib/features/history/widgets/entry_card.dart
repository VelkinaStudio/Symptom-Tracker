import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/severity_utils.dart';
import '../../../shared/providers/database_provider.dart';
import '../providers/history_provider.dart';

class EntryCard extends ConsumerWidget {
  final SymptomEntry entry;

  const EntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final severity = entry.severity;
    final severityColor = SeverityUtils.color(severity);
    final severityBg = SeverityUtils.backgroundColor(severity);

    final subtitleParts = <String>[
      AppDateUtils.formatTime(entry.startedAt),
      if (entry.durationMinutes != null)
        AppDateUtils.formatDuration(entry.durationMinutes!),
      if (entry.notes != null && entry.notes!.isNotEmpty)
        entry.notes!.length > 40
            ? '${entry.notes!.substring(0, 40)}…'
            : entry.notes!,
    ];

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete entry?'),
            content: const Text('This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async {
        await ref
            .read(symptomEntryDaoProvider)
            .softDeleteEntry(entry.id);
        ref.invalidate(filteredEntriesProvider);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
          subtitle: Text(subtitleParts.join(' · ')),
          trailing: Chip(label: Text(entry.category)),
          onTap: () => context.push('/log/${entry.id}'),
        ),
      ),
    );
  }
}
