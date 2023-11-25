import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cell extends StatelessWidget {
  final String title;
  final String data;
  const Cell({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            '$data\$',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: Theme.of(context).colorScheme.onBackground),
          ),
          Text(
            title,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15, color:Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    ));
  }
}
