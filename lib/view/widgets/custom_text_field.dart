import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const CustomTextField(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          labelText: label,
          hintStyle: GoogleFonts.poppins(
              fontSize: 12, color: Theme.of(context).hintColor),
          hintText: 'Your $label',
          floatingLabelStyle: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onBackground),
          labelStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w500)),
    );
  }
}
