import 'package:flutter/material.dart';
import '../providers/home_provider.dart';

class StatsStrip extends StatelessWidget {
  final HomeStats stats;

  const StatsStrip({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: Icons.calendar_month,
          value: stats.daysTracked.toString(),
          label: 'Days tracked',
        ),
        const SizedBox(width: 8),
        _StatCard(
          icon: Icons.today,
          value: stats.todayCount.toString(),
          label: 'Today',
        ),
        const SizedBox(width: 8),
        _StatCard(
          icon: Icons.local_fire_department,
          value: stats.currentStreak.toString(),
          label: 'Day streak',
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: colorScheme.primary, size: 24),
              const SizedBox(height: 4),
              Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
