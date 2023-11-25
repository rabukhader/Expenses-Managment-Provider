import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

errorDialog(context, content) {
  showDialog(
      context: context,
      builder: (context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          child: AlertDialog(
            backgroundColor: Theme.of(context).hintColor,
            title: Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.background),
            ),
          ),
        );
      });
}
