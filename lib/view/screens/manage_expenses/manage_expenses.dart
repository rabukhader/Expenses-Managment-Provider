import 'dart:async';
import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/list_of_expenses.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/search_input.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../view_model/manage_expense_view_model.dart';
import '../../widgets/loader.dart';

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
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final exViewModel =
        Provider.of<ManageExpensesViewModel>(context, listen: false);
    exViewModel.fetchExpenses();
    textController.addListener(() {
      exViewModel.textStream.add(textController.text);
    });
  }

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
  Widget build(BuildContext context) {
    final exProvider =
        Provider.of<ManageExpensesViewModel>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const CustomHeading(title: 'Expenses List'),
          SearchInput(
            textStream: exProvider.textStream,
            onSearch: (query) {
              exProvider.onSearch(query);
            },
            textController: textController,
          ),
          Expanded(
              child: StreamBuilder(
                  stream: exProvider.dataStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data!.isEmpty) {
                      return const Text('Not Found');
                    } else {
                      return ListOfExpenses(
                        onDeletePressed: exProvider.deleteExpense,
                        onCopyPressed: exProvider.addExpense,
                        onEditPressed: exProvider.editExpense,
                        data: exProvider.expenseModel.searchResults,
                        onTap: (BuildContext context, WidgetBuilder builder) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: builder));
                        },
                      );
                    }
                  })),
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
          if (result != null) await exProvider.addExpense(result);
        },
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
