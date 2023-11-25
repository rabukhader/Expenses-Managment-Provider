import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../expense.dart';


class ExpenseForm {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();


  loadData(Expense data) {
    nameController.text = data.name;
    totalController.text = (data.total).toString();
    dateController.text = data.dueDate;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).primaryColor,
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context).hintColor), // Header text color
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary), // Button text color
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }
}
