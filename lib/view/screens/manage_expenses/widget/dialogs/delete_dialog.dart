import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../view_model/manage_expense_view_model.dart';

deleteDialog(context, name, id, ManageExpensesViewModel exProvider) {
  showDialog(
      barrierColor: Theme.of(context).dialogBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            backgroundColor: Theme.of(context).hintColor,
            title: Text(
              'Are you sure you want to delete $name expense ?',
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.background),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error),
                child: Text('Delete',
                    style: GoogleFonts.poppins(color: Colors.white)),
                onPressed: () async {
                  await exProvider
                      .deleteExpense(id);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        );
      });
}
