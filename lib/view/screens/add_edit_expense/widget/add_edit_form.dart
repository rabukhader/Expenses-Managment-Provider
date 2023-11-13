import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isUploaded = false;
  bool isLocated = false;
  Position? currentPosition;
  String? currentAddress;
  @override
  void initState() {
    super.initState();
    if (widget.expenseId != null) {
      widget.form.loadData(widget.data);
      isUploaded = true;
      isLocated = true;
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      elevation: 25,
                      shadowColor: Colors.blueGrey),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Choose an image source"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await widget.form.pickImage(ImageSource.camera);
                                setState(() {
                                  isUploaded = true;
                                });
                              },
                              child: const Text("Camera"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await widget.form
                                    .pickImage(ImageSource.gallery);
                                setState(() {
                                  isUploaded = true;
                                });
                              },
                              child: const Text("Gallery"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isUploaded ? 'Change' : 'Upload',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        elevation: 25,
                        shadowColor: Colors.blueGrey),
                    onPressed: () async {
                      await widget.form.fetchLocation();
                      setState(() {
                        isLocated = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        isLocated
                            ? 'Change Your Location'
                            : 'Get Current Location',
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isLocated
                        ? 'Address: ${widget.form.address}'
                        : 'Address : ',
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
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
                'dueDate': widget.form.dateController.text,
                'imageUrl': widget.form.imageController.text,
                'address': widget.form.address
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
