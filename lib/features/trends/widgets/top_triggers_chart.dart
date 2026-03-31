import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TopTriggersChart extends StatelessWidget {
  final List<MapEntry<String, int>> data;

  const TopTriggersChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (data.isEmpty) {
      return const Center(child: Text('No trigger data yet'));
    }

    final top = data.take(6).toList();
    final maxCount = top.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    final groups = top.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.value.toDouble(),
            color: colorScheme.tertiary,
            width: 16,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(4),
            ),
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        maxY: (maxCount + 1).toDouble(),
        barGroups: groups,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: false,
          verticalInterval: 1,
          getDrawingVerticalLine: (value) => FlLine(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 100,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= top.length) {
                  return const SizedBox.shrink();
                }
                final name = top[index].key;
                final displayName =
                    name.length > 12 ? '${name.substring(0, 12)}…' : name;
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    displayName,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value != value.roundToDouble()) {
                  return const SizedBox.shrink();
                }
                return Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${top[group.x].key}: ${rod.toY.toInt()}',
                TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
