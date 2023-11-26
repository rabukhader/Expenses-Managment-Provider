import 'dart:async';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/custom_card.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:go_router/go_router.dart';
// import 'package:rxdart/rxdart.dart';
import 'package:expenses_managment_app_provider/model/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/expense_view_model.dart';

class ListOfExpenses extends StatefulWidget {
  final StreamController<Map<String, Expense>> dataStream;
  final Function(String) onSearch;
  final result;
  const ListOfExpenses(
      {super.key,
      required this.dataStream,
      required this.onSearch,
      this.result});

  @override
  State<ListOfExpenses> createState() => _ListOfExpensesState();
}

class _ListOfExpensesState extends State<ListOfExpenses> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesViewModel>(
      builder: (context, ex, child) {
        return StreamBuilder(
          stream: widget.dataStream.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (widget.result.isEmpty) {
              return const Text('Not Found');
            } else {
              final displayedExpense = widget.result;
              return ListView.builder(
                itemCount: displayedExpense.length,
                itemBuilder: (context, index) {
                  final entry = displayedExpense.entries.toList()[index];
                  final id = entry.key;
                  final Expense expenseDetails = entry.value;
                  return InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/expenseDetails/$id',
                          extra: {'id': id, 'data': expenseDetails});
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
