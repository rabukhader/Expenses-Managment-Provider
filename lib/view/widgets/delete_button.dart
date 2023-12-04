import 'package:expenses_managment_app_provider/view/screens/manage_expenses/widget/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_button.dart';
class DeleteButton extends CustomButton {
  DeleteButton({
    required onPressed,
    required String id,
    required data,
  }) : super(
    data: data,
    id: id,
          onPressed: onPressed,
          label: "Delete",
          icon: Icons.delete,
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
          deleteDialog(context, id, onPressed);
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