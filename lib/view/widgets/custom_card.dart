import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/entities/expense_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/add_edit_expense/add_edit_expense.dart';
import '../screens/expense_details/expense_details.dart';
import '../screens/manage_expenses/widget/dialogs/delete_dialog.dart';

class CustomCard extends StatelessWidget {
  final Expense data;
  final String? id;
  final onDeletePressed;
  final onEditPressed;
  final onCopyPressed;
  final onViewPressed;
  const CustomCard(
      {Key? key,
      required this.data,
      this.id,
      this.onDeletePressed,
      this.onEditPressed,
      this.onCopyPressed,
      this.onViewPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [color, Theme.of(context).primaryColor, color]),
            color: color,
            borderRadius: BorderRadius.circular(15)),
        width: 320,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        data.total.toString(),
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      SvgPicture.asset(
                        'assets/dolar.svg',
                        width: 32,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  onDeletePressed != null
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).hintColor,
                          ),
                          onPressed: () {
                            deleteDialog(
                                context, data.name, id, onDeletePressed);
                          },
                          label: Text(
                            "Delete",
                            style: GoogleFonts.poppins(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Container(),
                  onEditPressed != null
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).hintColor,
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEditExpensesScreen(
                                        processName: 'Edit',
                                        expenseId: id,
                                        data: data)));
                            if (result != null) {
                              await onEditPressed(result, id);
                            }
                          },
                          label: Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Container(),
                  onDeletePressed != null
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          icon: Icon(
                            Icons.copy,
                            color: Theme.of(context).hintColor,
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEditExpensesScreen(
                                        processName: 'Clone',
                                        expenseId: id,
                                        data: data)));
                            if (result != null) await onCopyPressed(result);
                          },
                          label: Text(
                            "Clone",
                            style: GoogleFonts.poppins(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ))
                      : Container(),
                  onViewPressed != null
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          icon: Icon(
                            Icons.view_carousel,
                            color: Theme.of(context).hintColor,
                          ),
                          onPressed: () {
                            onViewPressed!(
                                context,
                                (context) => ExpenseDetails(
                                      id: id!,
                                      data: data,
                                    ));
                          },
                          label: Text(
                            "View",
                            style: GoogleFonts.poppins(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ))
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}