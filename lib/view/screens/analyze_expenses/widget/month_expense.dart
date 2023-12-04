import 'package:expenses_managment_app_provider/model/entities/expense_entity.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_card.dart';
import 'package:expenses_managment_app_provider/view/widgets/view_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthExpenses extends StatelessWidget {
  final Map<String, Expense> data;
  final String monthName;
  const MonthExpenses({super.key, required this.data, required this.monthName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        title: Text(monthName,
            style: GoogleFonts.openSans(
                color: Theme.of(context).colorScheme.background,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).hintColor,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final entry = data.entries.toList()[index];
              final id = entry.key;
              final Expense expenseDetails = entry.value;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomCard(
                  buttons: [
                    ViewButton(
                        onPressed:
                            (BuildContext context, WidgetBuilder builder) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: builder));
                        },
                        id: id,
                        data: expenseDetails)
                  ],
                  data: expenseDetails,
                  id: id,
                ),
              );
            },
          )),
    );
  }
}
