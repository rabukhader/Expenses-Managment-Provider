import 'dart:io';
import 'package:camera/camera.dart';
import 'package:expenses_managment_app_provider/model/services/image_service/image_service.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../main.dart';
import 'camera_view_photo.dart';

class CameraSection extends StatefulWidget {
  final ImageService imageService;
  const CameraSection({super.key, required this.imageService});

  @override
  State<CameraSection> createState() => _CameraSectionState();
}

class _CameraSectionState extends State<CameraSection> {
  late CameraController camController;
  late Future<void> cameraValue;
  List<AssetEntity> galleryPhotos = [];
  bool isCaptureInProgress = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    camController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    cameraValue = camController.initialize();
    fetchGalleryPhotos();
  }

  Future<void> fetchGalleryPhotos() async {
    List<AssetEntity> photos = await widget.imageService.getGalleryThumbnails();
    setState(() {
      galleryPhotos = photos;
    });
    print("test" + galleryPhotos.toString());
  }

  @override
  void dispose() {
    super.dispose();
    camController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              FutureBuilder(
                  future: cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(camController);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )),
              Positioned(
                  bottom: 100.0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: galleryPhotos.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              final file = await galleryPhotos[index].file;
                              await widget.imageService
                                  .uploadImageToStorage(file!);
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CameraViewPhoto(
                                    url:
                                        widget.imageService.imageController.text,
                                  ),
                                ),
                              );
                              if (result == false) {
                                widget.imageService.imageController.clear();
                              }
                            },
                            child: Container(
                              color: const Color.fromRGBO(255, 255, 255, 0.4),
                              margin: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetEntityImageProvider(
                                    galleryPhotos[index]),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0.0,
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.flash_off,
                                color: Colors.white,
                                size: 28,
                              )),
                          InkWell(
                              onTap: () async {
                                await captureAndUpload();
                              },
                              child: const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.flip_camera_ios,
                                color: Colors.white,
                                size: 28,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Hold For Video, Tap for photo',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> captureAndUpload() async {
    if (isCaptureInProgress) {
      setState(() {
      });
      return;
    }

    setState(() {
      isCaptureInProgress = true;
    });

    try {
      var re = await camController.takePicture();
      final expenseImage = File(re.path);
      await widget.imageService.uploadImageToStorage(expenseImage);
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPhoto(
            url: widget.imageService.imageController.text,
          ),
        ),
      );
      if (result == false) {
        widget.imageService.imageController.clear();
      }
    } catch (e) {
      print("Error during capture and upload: $e");
    } finally {
      setState(() {
        isCaptureInProgress = false;
      });
    }
  }
}
