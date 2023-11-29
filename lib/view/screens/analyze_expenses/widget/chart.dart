import 'package:expenses_managment_app_provider/view_model/analyze_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../model/entities/expense_entity.dart';
import 'month_expense.dart';

class Chart extends StatelessWidget {
  final Map<String, double> list;
  const Chart({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    var barGroups = list.entries
        .map((item) => BarChartGroupData(
                x: list.keys.toList().indexOf(item.key),
                barRods: [
                  BarChartRodData(
                      color: item.value > 10000
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).hintColor,
                      toY: item.value > 10000 ? 10000 : item.value,
                      width: 16,
                      backDrawRodData: BackgroundBarChartRodData(show: true),
                      borderRadius: const BorderRadius.all(Radius.zero))
                ]))
        .toList();

    return BarChart(BarChartData(
        maxY: 10000,
        minY: 0,
        barGroups: barGroups,
        titlesData: FlTitlesData(
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 1000,
              showTitles: true,
              getTitlesWidget: (value, key) {
                if (value >= 0 && value < list.length) {
                  return Text(
                    list.keys.toList()[value.toInt()].substring(0, 3),
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  );
                }
                return const Text('Error');
              },
            ),
          ),
        ),
        barTouchData:
            BarTouchData(touchCallback: (touchEvent, barTouchResponse) {
          if (barTouchResponse?.spot != null) {
            int touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
            Map<String, Expense> data =
                Provider.of<AnalyzeViewModel>(context, listen: false)
                    .fetchExpenseByMonth(touchedIndex);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MonthExpenses(data: data)));
          }
        })));
  }
}
