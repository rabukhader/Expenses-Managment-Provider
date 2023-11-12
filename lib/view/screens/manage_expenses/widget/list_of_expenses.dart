import 'dart:async';

import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../view_model/expense_view_model.dart';
import 'custom_card.dart';

class ListOfExpenses extends StatefulWidget {
  const ListOfExpenses({super.key});

  @override
  State<ListOfExpenses> createState() => _ListOfExpensesState();
}

class _ListOfExpensesState extends State<ListOfExpenses> {
  late StreamSubscription<String> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Provider.of<ExpensesViewModel>(context, listen: false)
        .textStream
        .stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 900))
        .listen((searchQuery) {
      Provider.of<ExpensesViewModel>(context, listen: false)
          .searchExpense(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ex = Provider.of<ExpensesViewModel>(context, listen: false);
    return Consumer<ExpensesViewModel>(
      builder: (context, exProvider, child) {
        return FutureBuilder(
          future: exProvider.fetchExpenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final displayedExpense = ex.searchResults.isNotEmpty
                  ? ex.searchResults
                  : ex.allExpenses;
              return ListView.builder(
                itemCount: displayedExpense.length,
                itemBuilder: (context, index) {
                  final entry = displayedExpense.entries.toList()[index];
                  final id = entry.key;
                  final Expense expenseDetails = entry.value;
                  return CustomCard(data: expenseDetails, id: id);
                },
              );
            }
          },
        );
      },
    );
  }
}
