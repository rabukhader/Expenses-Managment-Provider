import 'package:expenses_managment_app_provider/model/entities/expense_entity.dart';
import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/list_of_expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthExpenses extends StatelessWidget {
  final Map<String, Expense> data;
  const MonthExpenses({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        title: Text('Expense Management App',
            style: GoogleFonts.openSans(
                color: Theme.of(context).colorScheme.background,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).hintColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ListOfExpenses(
          data: data,
        ),
      ),
    );
  }
}
