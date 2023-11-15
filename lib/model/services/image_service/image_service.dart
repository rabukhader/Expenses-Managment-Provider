import 'dart:io';
import 'dart:typed_data';
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
        await Permission.storage.request();
        var status = await Permission.storage.status;
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

  Future<List<AssetEntity>> getGalleryThumbnails() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result != PermissionState.authorized) {
      return [];
    }

    List<AssetEntity> assets = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    ).then((pathList) async {
      if (pathList.isEmpty) return [];

      List<AssetEntity> thumbnails = [];

      List<AssetEntity> partialAssets =
          await pathList[0].getAssetListRange(start: 0, end: 100);

      for (var asset in partialAssets) {
        Uint8List? thumbData = await asset.thumbnailData;
        if (thumbData != null) {
          thumbnails.add(asset);
        }
      }

      return thumbnails;
    });

    return assets;
  }
}
