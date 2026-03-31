import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/providers/database_provider.dart';

class DataSection extends ConsumerWidget {
  const DataSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Data',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.download_outlined),
              title: const Text('Export all data as JSON'),
              onTap: () => _exportData(context, ref),
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_outlined, color: colorScheme.error),
              title: Text(
                'Delete all data',
                style: TextStyle(color: colorScheme.error),
              ),
              onTap: () => _confirmDeleteAll(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      final dao = ref.read(symptomEntryDaoProvider);
      final entries = await dao.getAllEntries();

      final jsonList = entries
          .map((e) => {
                'id': e.id,
                'symptomName': e.symptomName,
                'category': e.category,
                'severity': e.severity,
                'startedAt': e.startedAt.toIso8601String(),
                'durationMinutes': e.durationMinutes,
                'notes': e.notes,
                'reliefAction': e.reliefAction,
                'improvedAfterAction': e.improvedAfterAction,
                'bodyLocation': e.bodyLocation,
                'createdAt': e.createdAt.toIso8601String(),
                'updatedAt': e.updatedAt.toIso8601String(),
              })
          .toList();

      final jsonString = const JsonEncoder.withIndent('  ').convert({
        'exportedAt': DateTime.now().toIso8601String(),
        'entries': jsonList,
      });

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/symptom_tracker_export.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Symptom Tracker data export',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _confirmDeleteAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete all data?'),
        content: const Text(
          'This will permanently delete all symptom entries. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete all'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(symptomEntryDaoProvider).deleteAllEntries();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data deleted')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Delete failed: $e')),
          );
        }
      }
    }
  }
}
