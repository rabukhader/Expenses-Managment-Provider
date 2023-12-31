import 'package:expenses_managment_app_provider/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

deleteDialog(context, id, onDeletePressed) {
  showDialog(
      barrierColor: Theme.of(context).dialogBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            backgroundColor: Theme.of(context).hintColor,
            title: Text(
              'Are you sure you want to delete expense ?',
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
                  await onDeletePressed(id);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        );
      });
}
