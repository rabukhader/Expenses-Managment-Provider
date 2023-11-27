import 'package:expenses_managment_app_provider/model/data/expense_model.dart';
import 'package:expenses_managment_app_provider/view/screens/expense_details/expense_details.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/custom_card.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/expense_view_model.dart';

class ListOfExpenses extends StatefulWidget {
  const ListOfExpenses({
    super.key,
  });

  @override
  State<ListOfExpenses> createState() => _ListOfExpensesState();
}

class _ListOfExpensesState extends State<ListOfExpenses> {
  ExpenseModel exModel = ExpenseModel.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesViewModel>(
      builder: (context, ex, child) {
        return StreamBuilder(
          stream: ex.dataStream.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.isEmpty) {
              return const Text('Not Found');
            } else {
              final Map<String, Expense> displayedExpense =
                  exModel.searchResults;
              return ListView.builder(
                itemCount: displayedExpense.length,
                itemBuilder: (context, index) {
                  final entry = displayedExpense.entries.toList()[index];
                  final id = entry.key;
                  final Expense expenseDetails = entry.value;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpenseDetails(
                                  data: expenseDetails,
                                  id: id,
                                  exProvider: ex)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCard(
                        data: expenseDetails,
                        id: id,
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
