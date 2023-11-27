import 'package:expenses_managment_app_provider/view_model/analyze_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final analyzeViewModel =
        Provider.of<AnalyzeViewModel>(context, listen: false);
    var list = analyzeViewModel.classifyExpensesByMonth();

    var barGroups = list.entries
        .map((item) => BarChartGroupData(
                x: list.keys.toList().indexOf(item.key),
                barRods: [
                  BarChartRodData(
                      color: item.value > 5000
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).hintColor,
                      toY: item.value > 5000 ? 5000 : item.value,
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
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  );
                }
                return const Text('Error');
              },
            )))));
  }
}
