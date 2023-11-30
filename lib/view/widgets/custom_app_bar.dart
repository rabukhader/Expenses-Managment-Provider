import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.onBackground),
      title: Text('Expense Management App',
          style: GoogleFonts.openSans(
              color: Theme.of(context).colorScheme.background,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
      backgroundColor: Theme.of(context).hintColor,
    );
  }
}
