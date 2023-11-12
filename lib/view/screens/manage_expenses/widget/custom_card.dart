import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/expense_view_model.dart';
import 'dialogs/delete_dialog.dart';

class CustomCard extends StatelessWidget {
  final Expense data;
  final String? id;
  const CustomCard({super.key, required this.data, required this.id});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesViewModel>(context, listen: false);
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(0.03),
      child: Card(
        shadowColor: Colors.teal,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            data.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Total: \$${data.total}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  deleteDialog(context, data.name, id);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                ),
                onPressed: () async {
                  final editData = {
                    'name': data.name,
                    'total': data.total,
                    'dueDate': data.dueDate,
                  };
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditExpensesScreen(
                            processName: 'Edit',
                              expenseId: id, data: editData)));
                  if (result != null) await exProvider.editExpense(result, id);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.copy,
                  color: Colors.greenAccent,
                ),
                onPressed: () async {
                  final clonedData = {
                    'name': data.name,
                    'total': data.total,
                    'dueDate': data.dueDate,
                  };
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditExpensesScreen(
                            processName: 'Clone',
                              expenseId: id, data: clonedData)));
                  if (result != null) await exProvider.addExpense(result);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
