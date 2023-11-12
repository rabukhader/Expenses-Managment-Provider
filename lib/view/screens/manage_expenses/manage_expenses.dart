import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/list_of_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/search_input.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/expense_view_model.dart';

class ManageExpenses extends StatefulWidget {
  const ManageExpenses({super.key});

  @override
  State<ManageExpenses> createState() => _ManageExpensesState();
}

class _ManageExpensesState extends State<ManageExpenses> {
  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesViewModel>(context, listen: false);
    return Scaffold(
      body: const Column(
        children: [
          CustomHeading(title: 'Expenses List'),
          SearchInput(),
          Expanded(child: ListOfExpenses()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditExpensesScreen(processName: 'Add',)));
                  if(result != null) await exProvider.addExpense(result);
        },
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
