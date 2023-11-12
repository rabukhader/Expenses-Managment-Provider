import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/widget/add_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/services/form/expense_form.dart';
import '../../../model/services/form/expense_validator.dart';
import '../../widgets/custom_heading.dart';

class AddEditExpensesScreen extends StatefulWidget {
  final String processName;
  final String? expenseId;
  final Map? data;
  const AddEditExpensesScreen(
      {super.key, this.expenseId, this.data, required this.processName});

  @override
  State<AddEditExpensesScreen> createState() => _AddEditExpensesScreenState();
}

class _AddEditExpensesScreenState extends State<AddEditExpensesScreen> {
  AddEditExpenseValidator validator = AddEditExpenseValidator();
  ExpenseForm form = ExpenseForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Management App',
            style: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeading(title: '${widget.processName} Expense'),
            widget.expenseId == null
                ? AddEditForm(
                    form: form,
                    validator: validator,
                    processName: widget.processName)
                : AddEditForm(
                    form: form,
                    validator: validator,
                    processName: widget.processName,
                    expenseId: widget.expenseId,
                    data: widget.data,
                  ),
          ],
        ),
      ),
    );
  }
}
