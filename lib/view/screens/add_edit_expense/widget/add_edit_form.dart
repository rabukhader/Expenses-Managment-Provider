import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenses_managment_app_provider/model/entities/expense.dart';
import 'package:expenses_managment_app_provider/model/services/image_service/image_service.dart';
import 'package:expenses_managment_app_provider/model/services/location/location_service.dart';
import 'package:expenses_managment_app_provider/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../model/services/expense_form/expense_form.dart';
import '../../../../model/services/expense_form/expense_validator.dart';
import '../../../widgets/dialog.dart';
import 'camera_section.dart';

class AddEditForm extends StatefulWidget {
  final ImageService? imageService;
  final LocationService locationService;
  final Expense? data;
  final String? expenseId;
  final AddEditExpenseValidator validator;
  final ExpenseForm form;
  final String processName;
  const AddEditForm(
      {super.key,
      this.imageService,
      required this.locationService,
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
  @override
  void initState() {
    super.initState();
    if (widget.expenseId != null) {
      widget.form.loadData(widget.data!);
      widget.locationService.loadData(widget.data!.address);
      widget.imageService!.loadData(widget.data!.imageUrl);
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
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  labelText: 'Title',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 12, color: Theme.of(context).hintColor),
                  hintText: 'Title',
                  floatingLabelStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onBackground),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w500)),
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
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  labelText: 'Total',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 12, color: Theme.of(context).hintColor),
                  hintText: 'Total',
                  floatingLabelStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onBackground),
                  labelStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            child: TextFormField(
              readOnly: true,
              validator: (value) => widget.validator.validate(value),
              controller: widget.form.dateController,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground)),
                  labelText: 'Date (YYYY-MM-DD)',
                  labelStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onBackground),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        widget.form.selectDate(context);
                      })),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          foregroundColor:
                              Theme.of(context).colorScheme.background,
                          elevation: 25,
                          shadowColor: Colors.blueGrey),
                      onPressed: () {
                        showDialog(
                          barrierColor: Theme.of(context).dialogBackgroundColor,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).hintColor,
                              title: Text(
                                "Choose an image source",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CameraSection(
                                                imageService:
                                                    widget.imageService!)));
                                    print(result);

                                    if (widget.imageService!.imageController
                                            .text !=
                                        '') {
                                      setState(() {
                                        isUploaded = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Camera",
                                    style: GoogleFonts.poppins(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await widget.imageService!
                                        .open(ImageSource.gallery);
                                    if (widget.imageService!.imageController
                                            .text !=
                                        '') {
                                      setState(() {
                                        isUploaded = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: GoogleFonts.poppins(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                  ),
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
                              isUploaded ? 'Change' : 'Add Photo',
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
              isUploaded
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.all(12.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageService!.imageController.text,
                        placeholder: (context, url) => const Loader(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 29,
                        ),
                      ),
                    )
                  : const Text('Choose Your Image')
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        foregroundColor:
                            Theme.of(context).colorScheme.background,
                        elevation: 25,
                        shadowColor: Colors.blueGrey),
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const AlertDialog(
                          content:
                              SizedBox(width: 30, height: 150, child: Loader()),
                        ),
                      );
                      final result =
                          await widget.locationService.fetchLocation();
                          Navigator.pop(context);
                      if (result != null) {
                        errorDialog(context, 'No Internet For Location');
                      } else {
                        setState(() {
                          isLocated = true;
                        });
                      }
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
                        ? 'Address: ${widget.locationService.address}'
                        : 'Address : ',
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 25,
                shadowColor: Colors.blueGrey),
            icon: const Icon(Icons.add),
            onPressed: () {
              Expense data = Expense(
                  name: widget.form.nameController.text,
                  total: int.tryParse(widget.form.totalController.text),
                  dueDate: widget.form.dateController.text,
                  imageUrl: widget.imageService!.imageController.text,
                  address: widget.locationService.address ?? '');
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
