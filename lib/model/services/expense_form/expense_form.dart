import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class EForm {
  Future<void> selectDate(BuildContext context);
  loadData(data);
}

class ExpenseForm implements EForm {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  loadData(data) {
    nameController.text = data['name'];
    totalController.text = (data['total']).toString();
    dateController.text = data['dueDate'];
  }

  @override
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.teal,
              colorScheme: const ColorScheme.light(
                  primary: Colors.teal), // Header text color
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
