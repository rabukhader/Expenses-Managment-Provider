import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController imageController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  loadData(data) {
    nameController.text = data['name'];
    totalController.text = (data['total']).toString();
    dateController.text = data['dueDate'];
    imageController.text = data['imageUrl'];
  }

  @override
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final expenseImage = File(pickedFile.path);
      uploadImageToStorage(expenseImage);
    } else {
      print('not used correctly');
      print(imageController.text);
    }
  }

  Future<void> uploadImageToStorage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('expenses_images/${DateTime.now()}.png');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      final imageUrl = await storageRef.getDownloadURL();
      imageController.text = imageUrl;
    } catch (e) {
      print(e);
    }
  }

}
