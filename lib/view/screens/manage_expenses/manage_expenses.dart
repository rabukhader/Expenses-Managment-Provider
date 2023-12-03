import 'dart:async';
import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:expenses_managment_app_provider/view/widgets/list_of_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/search_input.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../view_model/manage_expense_view_model.dart';

class ManageExpenses extends StatelessWidget {
  const ManageExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageExpensesViewModel(),
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
  late StreamSubscription<String> subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subscription = Provider.of<ManageExpensesViewModel>(context, listen: false)
        .textStream
        .stream
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .listen((searchQuery) {
      Provider.of<ManageExpensesViewModel>(context, listen: false)
          .searchExpense(searchQuery);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageExpensesViewModel>(
      builder: (context, exViewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const CustomHeading(title: 'Expenses List'),
            SearchInput(
              textStream: exViewModel.textStream,
              onSearch: (query) {
                exViewModel.onSearch(query);
              },
              textController: exViewModel.textController,
            ),
            Expanded(
                child: Selector<ManageExpensesViewModel, dynamic>(
              selector: (_, ex) => ex.expenseModel.searchResults,
              builder: (context, ex, child) => ListOfExpenses(
                onDeletePressed: exViewModel.deleteExpense,
                onCopyPressed: exViewModel.addExpense,
                onEditPressed: exViewModel.editExpense,
                data: ex,
                onTap: (BuildContext context, WidgetBuilder builder) {
                  Navigator.push(context, MaterialPageRoute(builder: builder));
                },
              ),
            ))
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
            if (result != null) await exViewModel.addExpense(result);
          },
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
    );
  }
}
