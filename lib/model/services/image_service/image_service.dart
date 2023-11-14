import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageService {
  TextEditingController imageController = TextEditingController();

  loadData(prevImage) {
    imageController.text = prevImage;
  }

  Future open(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        await Permission.camera.request();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          await pickImage(ImageSource.camera);
        } else {
          if (await Permission.camera.isPermanentlyDenied) {
            await openAppSettings();
          }
          print('Camera permission not granted');
        }
      } else if (source == ImageSource.gallery) {
        await Permission.photos.request();
        var status = await Permission.photos.status;
        if (status.isGranted) {
          await pickImage(ImageSource.gallery);
        } else {
          print('Photos permission not granted');
        }
      }
      // }
    } catch (e) {
      print(e);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final expenseImage = File(pickedFile.path);
      await uploadImageToStorage(expenseImage);
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

  Future<List<AssetEntity>> getGalleryPhotos() async {
    // Request permission if not granted
    var result = await PhotoManager.requestPermissionExtend();
    if (result != PermissionState.authorized) {
      // Handle permission denied
      return [];
    }

    // Fetch photos from the gallery
    List<AssetEntity> assets = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    ).then((pathList) async {
      if (pathList.isEmpty) return [];

      return (await pathList[0].getAssetListRange(
              start: 0, end: await pathList[0].assetCountAsync))
          .toList();
    });

    return assets;
  }
}
