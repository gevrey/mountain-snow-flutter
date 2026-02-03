import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../api/open_meteo_api.dart';

class ForecastCharts extends StatelessWidget {
  final List<DailySnow> days;

  const ForecastCharts({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (days.isEmpty) return const SizedBox.shrink();

    // Prepare data
    final snowfall = <double>[];
    final depth = <double>[];
    final tmin = <double>[];
    final tmax = <double>[];

    for (final d in days) {
      snowfall.add((d.snowfallCm ?? 0).toDouble());
      depth.add((d.snowDepthMaxM ?? 0).toDouble());
      tmin.add((d.tempMinC ?? 0).toDouble());
      tmax.add((d.tempMaxC ?? 0).toDouble());
    }

    final maxSnow = snowfall.fold<double>(0, (m, v) => v > m ? v : m);
    final maxDepth = depth.fold<double>(0, (m, v) => v > m ? v : m);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Snowfall (cm/day)', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(show: false),
              barGroups: List.generate(snowfall.length, (i) {
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: snowfall[i],
                      width: 12,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.lightBlue.shade400,
                    )
                  ],
                );
              }),
              maxY: (maxSnow <= 0 ? 5 : (maxSnow * 1.2)),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text('Snow depth max (m)', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(show: false),
              minY: 0,
              maxY: (maxDepth <= 0 ? 1 : (maxDepth * 1.2)),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(depth.length, (i) => FlSpot(i.toDouble(), depth[i])),
                  isCurved: true,
                  dotData: const FlDotData(show: false),
                  color: Colors.indigo.shade400,
                  barWidth: 3,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text('Temperature (°C)', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(tmin.length, (i) => FlSpot(i.toDouble(), tmin[i])),
                  isCurved: true,
                  dotData: const FlDotData(show: false),
                  color: Colors.cyan.shade600,
                  barWidth: 3,
                ),
                LineChartBarData(
                  spots: List.generate(tmax.length, (i) => FlSpot(i.toDouble(), tmax[i])),
                  isCurved: true,
                  dotData: const FlDotData(show: false),
                  color: Colors.orange.shade600,
                  barWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
