import 'package:expenses_managment_app_provider/model/expense_model.dart';
import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/list_of_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/search_input.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/expense_view_model.dart';

class ManageExpenses extends StatelessWidget {
  const ManageExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpensesViewModel(),
      child: const ManageExpensesView(),
    );
  }
}

class ManageExpensesView extends StatefulWidget {
  const ManageExpensesView({super.key});

  @override
  State<ManageExpensesView> createState() => _ManageExpensesViewState();
}

class _ManageExpensesViewState extends State<ManageExpensesView> {
  @override
  void dispose() {
    Provider.of<ExpensesViewModel>(context, listen: false).disposeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of(context, listen: false);
    ExpenseModel ex = ExpenseModel();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const CustomHeading(title: 'Expenses List'),
          SearchInput(
              textStream: exProvider.textStream,
              onSearch: (query) {
                Provider.of<ExpensesViewModel>(context, listen: false)
                    .textStream
                    .add(query);
              }),
          Expanded(
              child: ListOfExpenses(
            dataStream: exProvider.dataStream,
            onSearch: (text) =>
                Provider.of<ExpensesViewModel>(context, listen: false)
                    .dataStream
                    .add(ex.searchResults),
            result: ex.searchResults,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).hintColor,
        splashColor: Theme.of(context).hintColor,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditExpensesScreen(
                        processName: 'Add',
                      )));
          await exProvider.addExpense(result);
        },
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
