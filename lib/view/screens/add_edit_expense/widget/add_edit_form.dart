import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../model/services/form/expense_form.dart';
import '../../../../model/services/form/expense_validator.dart';

class AddEditForm extends StatefulWidget {
  final Map? data;
  final String? expenseId;
  final AddEditExpenseValidator validator;
  final ExpenseForm form;
  final String processName;
  const AddEditForm(
      {super.key,
      this.data,
      this.expenseId,
      required this.validator,
      required this.form,
      required this.processName});

  @override
  State<AddEditForm> createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  int? amount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.expenseId != null) {
      widget.form.loadData(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form.formKey,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: TextFormField(
              validator: (value) => widget.validator.validateName(value),
              controller: widget.form.nameController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelStyle: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: TextFormField(
              validator: (value) => widget.validator.validateTotal(value),
              controller: widget.form.totalController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: 'Amount',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelStyle: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: TextFormField(
              readOnly: true,
              validator: (value) => widget.validator.validate(value),
              controller: widget.form.dateController,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  labelText: 'Date (YYYY-MM-DD)',
                  labelStyle: const TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        widget.form.selectDate(context);
                      })),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                elevation: 25,
                shadowColor: Colors.blueGrey),
            icon: const Icon(Icons.add),
            onPressed: () {
              var data = {
                'name': widget.form.nameController.text,
                'total': int.tryParse(widget.form.totalController.text),
                'dueDate': widget.form.dateController.text
              };

              if (widget.form.formKey.currentState!.validate()) {
                Navigator.pop(context, data);
              } else {
                return;
              }
            },
            label: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.processName,
                style: GoogleFonts.openSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
