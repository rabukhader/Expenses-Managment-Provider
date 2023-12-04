import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/camera_model.dart';
// import 'package:photo_manager/photo_manager.dart';

class ImageService {
  final supabase = Supabase.instance.client;
  TextEditingController imageController = TextEditingController();
  CameraModel cam = CameraModel();

  ImageService() {
    cam.init();
  }

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
      String filename = 'expensesImage/${DateTime.now()}.txt';
      await supabase.storage
          .from('expensesImages')
          .upload(filename, imageFile);
      imageController.text = 'https://ikvjrjghrjauwiywzjxc.supabase.co/storage/v1/object/public/expensesImages/$filename';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<List<AssetEntity>> getGalleryThumbnails() async {
  //   var result = await PhotoManager.requestPermissionExtend();
  //   if (result != PermissionState.authorized) {
  //     return [];
  //   }

  //   List<AssetEntity> assets = await PhotoManager.getAssetPathList(
  //     type: RequestType.image,
  //   ).then((pathList) async {
  //     if (pathList.isEmpty) return [];

  //     List<AssetEntity> thumbnails = [];

  //     List<AssetEntity> partialAssets =
  //         await pathList[0].getAssetListRange(start: 0, end: 100);

  //     for (var asset in partialAssets) {
  //       Uint8List? thumbData = await asset.thumbnailData;
  //       if (thumbData != null) {
  //         thumbnails.add(asset);
  //       }
  //     }

  //     return thumbnails;
  //   });

  //   return assets;
  // }
}
