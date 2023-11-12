import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeading extends StatelessWidget {
  final String title;
  const CustomHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(title, style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),));
  }
}