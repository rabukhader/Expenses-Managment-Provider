import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/analyze_view_model.dart';
import '../../../../view_model/expense_view_model.dart';
import 'custom_table.dart';

class SummaryStatistics extends StatelessWidget {
  const SummaryStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final analyzeViewModel =
        Provider.of<AnalyzeViewModel>(context, listen: false);
    final expenseViewModel =
        Provider.of<ExpensesViewModel>(context, listen: false);

    final avg = analyzeViewModel
        .averageExpenses(expenseViewModel.allExpenses.values.toList())
        .toString();

    return Column(
      children: [
        CustomTable(
          title1: 'Total',
          title2: 'Average',
          data1: analyzeViewModel
              .totalExpenses(expenseViewModel.allExpenses.values.toList())
              .toString(),
          data2: avg.length > 6 ? avg.substring(0,6) : avg.toString(),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTable(
            title1: 'Min Amount',
            title2: 'Max Amount',
            data1: analyzeViewModel
                .minExpense(expenseViewModel.allExpenses.values.toList())
                .toString(),
            data2: analyzeViewModel
                .maxExpense(expenseViewModel.allExpenses.values.toList())
                .toString()),
      ],
    );
  }
}
