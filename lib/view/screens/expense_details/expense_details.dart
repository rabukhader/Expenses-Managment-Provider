import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/entities/expense_entity.dart';
import '../../../view_model/manage_expense_view_model.dart';
import '../add_edit_expense/add_edit_expense.dart';
import '../manage_expenses/widget/dialogs/delete_dialog.dart';

class ExpenseDetails extends StatelessWidget {
  final String id;
  final Expense? data;
  final ManageExpensesViewModel? exProvider;
  final onDeletePressed;
  final onEditPressed;
  final onCopyPressed;
  const ExpenseDetails(
      {super.key,
      required this.id,
      this.data,
      this.exProvider,
      this.onDeletePressed,
      this.onEditPressed,
      this.onCopyPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).hintColor,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.background),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data!.imageUrl,
                  placeholder: (context, url) => const Loader(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 29,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data!.name,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data!.address == ''
                          ? 'Your Location is not added'
                          : data!.address,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: data!.address == ''
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.onBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Total : ${data!.total.toString()}\$',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'Due Date : ${data!.dueDate}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    onDeletePressed != null
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).hintColor,
                            ),
                            onPressed: () {
                              deleteDialog(context, id, onDeletePressed);
                            },
                            label: Text(
                              "Delete",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : Container(),
                    onEditPressed != null
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).hintColor,
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddEditExpensesScreen(
                                              processName: 'Edit',
                                              expenseId: id,
                                              data: data)));
                              if (result != null) {
                                await onEditPressed(result, id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            },
                            label: Text(
                              "Edit",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : Container(),
                    onCopyPressed != null
                        ? ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            icon: Icon(
                              Icons.copy,
                              color: Theme.of(context).hintColor,
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddEditExpensesScreen(
                                              processName: 'Clone',
                                              expenseId: id,
                                              data: data)));
                              if (result != null) await onCopyPressed(result);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            label: Text(
                              "Clone",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ))
                        : Container(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
