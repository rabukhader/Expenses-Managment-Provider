import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/custom_card.dart';
import 'package:flutter/material.dart';
import '../../../../model/entities/expense_entity.dart';
import '../../expense_details/expense_details.dart';

class ListOfExpenses extends StatelessWidget {
  final Map<String, Expense> data;
  final Function? onDeletePressed;
  final Function? onEditPressed;
  final Function? onCopyPressed;
  final Function? onTap;
  const ListOfExpenses(
      {super.key,
      required this.data,
      this.onDeletePressed,
      this.onEditPressed,
      this.onTap,
      this.onCopyPressed});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text('No Expenses Here'),
      );
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final entry = data.entries.toList()[index];
          final id = entry.key;
          final Expense expenseDetails = entry.value;
          return InkWell(
            onTap: () {
              if (onTap != null) {
                onTap!(
                    context,
                    (context) => ExpenseDetails(
                          id: id,
                          data: expenseDetails,
                          onDeletePressed: onDeletePressed,
                          onEditPressed: onEditPressed,
                          onCopyPressed: onCopyPressed,
                        ));
              } else {}
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                onDeletePressed: onDeletePressed,
                onEditPressed: onEditPressed,
                onCopyPressed: onCopyPressed,
                data: expenseDetails,
                id: id,
              ),
            ),
          );
        },
      );
    }
  }
}
