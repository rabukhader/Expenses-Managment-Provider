import 'package:expenses_managment_app_provider/view_model/analyze_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_heading.dart';
import 'widget/chart.dart';
import 'widget/summary_stat.dart';

class AnalyzeExpenses extends StatelessWidget {
  const AnalyzeExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnalyzeViewModel(),
      child: const AnalyzeExpensesView(),
    );
  }
}

class AnalyzeExpensesView extends StatelessWidget {
  const AnalyzeExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const CustomHeading(title: 'Monthly Expenses'),
      Container(
          padding: const EdgeInsets.only(top: 12.0, right: 6.0, left: 6.0),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Consumer<AnalyzeViewModel>(
              builder: (context, analyzeViewModel, child) {
            final list = analyzeViewModel.classifyExpensesByMonth();
            return Chart(
              list: list,
            );
          })),
      const CustomHeading(title: 'Summary Statistics'),
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AnalyzeViewModel>(
                builder: (context, analyzeViewModel, child) {
              return SummaryStatistics(
                title1: 'Total',
                title2: 'Average',
                title3: 'Min Amount',
                title4: 'Max Amount',
                data1: analyzeViewModel.totalExpenses().toString(),
                data2: analyzeViewModel.averageExpenses(),
                data3: analyzeViewModel.minExpense().toString(),
                data4: analyzeViewModel.maxExpense().toString(),
              );
            }),
          )),
    ]);
  }
}
