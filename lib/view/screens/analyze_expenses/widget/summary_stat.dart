import 'package:expenses_managment_app_provider/model/expense_model.dart';
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
    ExpenseModel ex = ExpenseModel();

    final avg = analyzeViewModel
        .averageExpenses(ex.allExpenses.values.toList())
        .toString();

    return Column(
      children: [
        CustomTable(
          title1: 'Total',
          title2: 'Average',
          data1: analyzeViewModel
              .totalExpenses(ex.allExpenses.values.toList())
              .toString(),
          data2: avg.length > 6 ? avg.substring(0, 6) : avg.toString(),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTable(
            title1: 'Min Amount',
            title2: 'Max Amount',
            data1: analyzeViewModel
                .minExpense(ex.allExpenses.values.toList())
                .toString(),
            data2: analyzeViewModel
                .maxExpense(ex.allExpenses.values.toList())
                .toString()),
      ],
    );
  }
}
