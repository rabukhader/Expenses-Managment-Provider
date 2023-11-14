import 'package:expenses_managment_app_provider/model/services/image_picker/image_picker.dart';
import 'package:expenses_managment_app_provider/model/services/location/location_service.dart';
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
  LocationService locationService = LocationService();
  CustomImagePicker imagePicker = CustomImagePicker();
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
                    imagePicker: imagePicker,
                    locationService: locationService,
                    form: form,
                    validator: validator,
                    processName: widget.processName)
                : AddEditForm(
                    imagePicker: imagePicker,
                    locationService: locationService,
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
