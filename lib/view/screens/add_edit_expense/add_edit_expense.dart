import 'package:expenses_managment_app_provider/model/services/image_service/image_service.dart';
import 'package:expenses_managment_app_provider/model/services/location/location_service.dart';
import 'package:expenses_managment_app_provider/view/screens/add_edit_expense/widget/add_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../model/data/expense_model.dart';
import '../../../model/services/expense_form/expense_form.dart';
import '../../../model/services/expense_form/expense_validator.dart';
import '../../widgets/custom_heading.dart';

class AddEditExpensesScreen extends StatefulWidget {
  final String processName;
  final String? expenseId;
  final Expense? data;
  const AddEditExpensesScreen(
      {super.key, this.expenseId, this.data, required this.processName});

  @override
  State<AddEditExpensesScreen> createState() => _AddEditExpensesScreenState();
}

class _AddEditExpensesScreenState extends State<AddEditExpensesScreen> {
  AddEditExpenseValidator validator = AddEditExpenseValidator();
  LocationService locationService = LocationService();
  ImageService imageService = ImageService();
  ExpenseForm form = ExpenseForm();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expense Management App',
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background)),
          backgroundColor: Theme.of(context).hintColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeading(title: '${widget.processName} Expense'),
              widget.expenseId == null
                  ? AddEditForm(
                      imageService: imageService,
                      locationService: locationService,
                      form: form,
                      validator: validator,
                      processName: widget.processName)
                  : AddEditForm(
                      imageService: imageService,
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
      ),
    );
  }
}
