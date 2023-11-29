import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/custom_card.dart';
import 'package:flutter/material.dart';
import '../../../../model/entities/expense_entity.dart';

class ListOfExpenses extends StatelessWidget {
  final Map<String, Expense> data;
  final Function? onDeletePressed;
  final Function? onEditPressed;
  final Function? onCopyPressed;
  const ListOfExpenses(
      {super.key,
      required this.data,
      this.onDeletePressed,
      this.onEditPressed,
      this.onCopyPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final entry = data.entries.toList()[index];
        final id = entry.key;
        final Expense expenseDetails = entry.value;
        return InkWell(
          onTap: () {},
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
