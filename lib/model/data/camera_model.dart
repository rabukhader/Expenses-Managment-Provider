import 'dart:async';

import 'package:camera/camera.dart';

class CameraModel {
  late List<CameraDescription> cameras;
  late Completer<void> initializationCompleter;

  Future<void> init() async {
    try {
      cameras = await availableCameras();
      initializationCompleter.complete();
    } catch (e) {
      initializationCompleter.completeError(e);
    }
  }

  Future<void> getInitialization() {
    return initializationCompleter.future;
  }
}
