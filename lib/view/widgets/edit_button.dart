import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/add_edit_expense.dart';
import 'package:expenses_managment_app_provider/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditButton extends CustomButton {
  EditButton({required onPressed, required String id, required data})
      : super(
          id: id,
          data: data,
          onPressed: onPressed,
          label: "Edit",
          icon: Icons.edit,
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
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditExpensesScreen(
                      processName: 'Edit', expenseId: id, data: data)));
          if (result != null) {
            await onPressed(result, id);
          }
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
