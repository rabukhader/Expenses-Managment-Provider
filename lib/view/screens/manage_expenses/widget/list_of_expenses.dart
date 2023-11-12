import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/expense_view_model.dart';
import 'custom_card.dart';



class ListOfExpenses extends StatefulWidget {
  const ListOfExpenses({super.key});

  @override
  State<ListOfExpenses> createState() => _ListOfExpensesState();
}
  
class _ListOfExpensesState extends State<ListOfExpenses> {

  
  @override
  Widget build(BuildContext context) {
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final entry = snapshot.data.entries.toList()[index];
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

