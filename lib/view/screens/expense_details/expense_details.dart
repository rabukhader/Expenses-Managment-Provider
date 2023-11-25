import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../view_model/expense_view_model.dart';
import '../add_edit_expense/add_edit_expense.dart';
import '../manage_expenses/widget/dialogs/delete_dialog.dart';

class ExpenseDetails extends StatelessWidget {
  final String id;
  final Expense data;
  const ExpenseDetails({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesViewModel>(context, listen: false);

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
                GoRouter.of(context).go('/home');
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
                  imageUrl: data.imageUrl,
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
                    data.name,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.address == ''
                          ? 'Your Location is not added'
                          : data.address,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: data.address == ''
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.onBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Total : ${data.total.toString()}\$',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'Due Date : ${data.dueDate}',
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
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).hintColor,
                      ),
                      onPressed: () {
                        deleteDialog(context, data.name, id);
                      },
                      label: Text(
                        "Delete",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton.icon(
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
                          await exProvider.editExpense(result, id);
                        }
                      },
                      label: Text(
                        "Edit",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        icon: Icon(
                          Icons.copy,
                          color: Theme.of(context).hintColor,
                        ),
                        onPressed: () async {
                          // final clonedData = {
                          //   'name': data['name'],
                          // 'total': data['total'],
                          // 'dueDate': data['dueDate'],
                          // 'imageUrl': data['imageUrl'],
                          // 'address': data['address']
                          // };
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEditExpensesScreen(
                                      processName: 'Clone',
                                      expenseId: id,
                                      data: data)));
                          if (result != null)
                            await exProvider.addExpense(result);
                        },
                        label: Text(
                          "Clone",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
