import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/transaction_provider.dart';
import '../utils/category_helper.dart';

class ChartWidgets extends StatelessWidget {
  const ChartWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            ExpensePieChart(provider: provider),
            const SizedBox(height: 20),
            TransactionLineChart(provider: provider),
          ],
        );
      },
    );
  }
}

class ExpensePieChart extends StatelessWidget {
  final TransactionProvider provider;

  const ExpensePieChart({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryTotals = provider.getCategoryTotals(isIncome: false);
    final totalExpense = provider.getTotalExpense();

    if (categoryTotals.isEmpty) {
      return const SizedBox.shrink();
    }

    final Map<String, double> localizedTotals = {};
    categoryTotals.forEach((category, amount) {
      final localizedCategory = CategoryHelper.getLocalizedCategory(
        context,
        category,
      );
      localizedTotals[localizedCategory] = amount;
    });

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: localizedTotals.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,
              title:
                  '${(entry.value / totalExpense * 100).toStringAsFixed(1)}%\n${entry.key}',
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              radius: 100,
            );
          }).toList(),
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}

class TransactionLineChart extends StatelessWidget {
  final TransactionProvider provider;

  const TransactionLineChart({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    // Create dummy data for now - implement actual data aggregation later
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 3.1),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.5), Colors.blue],
              ),
              barWidth: 5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.3),
                    Colors.blue.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
