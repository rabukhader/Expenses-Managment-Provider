import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  String? address;

  Position? currentPosition;
  DateTime selectedDate = DateTime.now();

  @override
  loadData(data) {
    nameController.text = data['name'];
    totalController.text = (data['total']).toString();
    dateController.text = data['dueDate'];
    imageController.text = data['imageUrl'];
    address = data['address'];
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

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return null;
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getAddressFromPosition() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      address = "${place.street}, ${place.locality}, ${place.country}";
    }
    return null;
  }

  Future fetchLocation() async {
    await getCurrentPosition();
    await getAddressFromPosition();
    print(address);
  }
}
