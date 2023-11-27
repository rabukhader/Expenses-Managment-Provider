import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/analyze_view_model.dart';
import 'custom_table.dart';

class SummaryStatistics extends StatelessWidget {
  const SummaryStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final analyzeViewModel =
        Provider.of<AnalyzeViewModel>(context, listen: false);

    return Column(
      children: [
        CustomTable(
          title1: 'Total',
          title2: 'Average',
          data1: analyzeViewModel.totalExpenses().toString(),
          data2: analyzeViewModel.averageExpenses(),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTable(
            title1: 'Min Amount',
            title2: 'Max Amount',
            data1: analyzeViewModel.minExpense().toString(),
            data2: analyzeViewModel.maxExpense().toString()),
      ],
    );
  }
}
