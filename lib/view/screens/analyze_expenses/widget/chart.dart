import 'package:expenses_managment_app_provider/view_model/analyze_view_model.dart';
import 'package:expenses_managment_app_provider/view_model/expense_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/data/months.dart';


class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final analyzeViewModel = Provider.of<AnalyzeViewModel>(context, listen: false);
    final expenseViewModel = Provider.of<ExpensesViewModel>(context, listen: false);

    var list = analyzeViewModel.classifyExpensesByMonth(
        expenseViewModel.allExpenses.values.toList(), months);

    var barGroups = list.entries
        .map((item) => BarChartGroupData(
                x: list.keys.toList().indexOf(item.key),
                barRods: [
                  BarChartRodData(
                      color: Colors.teal,
                      toY: item.value,
                      width: 16,
                      backDrawRodData: BackgroundBarChartRodData(show: true),
                      borderRadius: const BorderRadius.all(Radius.zero))
                ]))
        .toList();

    return BarChart(BarChartData(
        maxY: 5000,
        minY: 0,
        barGroups: barGroups,
        titlesData: FlTitlesData(
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              interval: 500,
              showTitles: true,
              getTitlesWidget: (value, key) {
                if (value >= 0 && value < list.length) {
                  return Text(
                    list.keys.toList()[value.toInt()].substring(0, 3),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  );
                }
                return const Text('Error');
              },
            )))));
  }
}
