import 'dart:async';

import 'package:camera/camera.dart';

class CameraModel {
  late List<CameraDescription> cameras;
  Future init() async {
    cameras = await availableCameras();
  }
}
