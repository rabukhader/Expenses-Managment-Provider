import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/expense_details/expense_details.dart';
import 'custom_button.dart';

class ViewButton extends CustomButton {
  ViewButton({required onPressed, required String id, required data})
      : super(
          data: data,
          id: id,
          onPressed: onPressed,
          label: "View",
          icon: Icons.view_carousel,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        icon: Icon(
          icon,
          color: Theme.of(context).hintColor,
        ),
        onPressed: () {
          onPressed(
              context,
              (context) => ExpenseDetails(
                    id: id,
                    data: data,
                  ));
        },
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
