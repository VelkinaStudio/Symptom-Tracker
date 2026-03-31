import 'package:flutter/material.dart';
import '../../../core/utils/severity_utils.dart';
import '../providers/trends_provider.dart';

class TopSymptomsList extends StatelessWidget {
  final List<SymptomRank> symptoms;

  const TopSymptomsList({
    super.key,
    required this.symptoms,
  });

  @override
  Widget build(BuildContext context) {
    if (symptoms.isEmpty) {
      return const Center(child: Text('No symptom data yet'));
    }

    final top = symptoms.take(8).toList();

    return Column(
      children: top.map((symptom) {
        final avgSeverityInt = symptom.avgSeverity.round();
        final severityColor = SeverityUtils.color(avgSeverityInt);
        final severityLabel = SeverityUtils.label(avgSeverityInt);

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: severityColor.withValues(alpha: 0.15),
            child: Text(
              '${symptom.count}',
              style: TextStyle(
                color: severityColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          title: Text(symptom.name),
          subtitle: Text(
            'Avg severity: ${symptom.avgSeverity.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          trailing: Chip(
            label: Text(
              severityLabel,
              style: TextStyle(
                color: severityColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: severityColor.withValues(alpha: 0.12),
            padding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            side: BorderSide.none,
          ),
        );
      }).toList(),
    );
  }
}
