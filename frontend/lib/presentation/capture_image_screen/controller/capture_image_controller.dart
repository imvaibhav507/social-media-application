import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/utils/file_upload_helper_2.dart';
import '../../../core/app_export.dart';

class CaptureImageController extends GetxController {

  RxBool isCameraInitialized = false.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await _requestCameraPermission();
    await initCameraController();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    cameraController.dispose();
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  late CameraController cameraController;
  late CameraDescription activeCamera;

  FileManagerTwo fileManagerTwo = FileManagerTwo();

  Future<void> _requestCameraPermission() async {
    if (await Permission.camera.status == PermissionStatus.denied) {
      await Permission.camera.request();
    }
  }

  Future<void> takePicture() async {
    // Capture the image
    try {
      List<XFile> capturedFiles = <XFile>[];
      XFile capturedImage = await cameraController.takePicture();
      capturedFiles.add(capturedImage);
      // Handle captured image (e.g., display or save)
      print(capturedImage.path);
      Get.toNamed(AppRoutes.addStoryScreen, arguments: capturedFiles);
    } catch (e) {
      print(e);
    }
  }

  Future<void> initCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    print(cameras);
    activeCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    cameraController = CameraController(activeCamera, ResolutionPreset.veryHigh);
    await cameraController.initialize();
    isCameraInitialized.value = true;
    print("camera initialized");
    return;
  }

  Future<void> switchCamera() async {
    isCameraInitialized.value = false;
    List<CameraDescription> cameras = await availableCameras();
    // Find the other camera based on the currently active camera
    CameraDescription newCamera;
    if (activeCamera.lensDirection == CameraLensDirection.front) {
      newCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    } else {
      newCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    }

    // Initialize the new camera controller with the new camera
    cameraController = CameraController(newCamera, ResolutionPreset.veryHigh);
    await cameraController.initialize();
    isCameraInitialized.value = true;
    // Update the active camera
    activeCamera = newCamera;
  }

  Future<void> selectImagesFromGallery() async {
    fileManagerTwo.openGallery(
        context: Get.context!,
        isMultiImage: true,
        getFiles: (files) {
          if(files.isNotEmpty){
            print(files.map((e) => e?.path));
            Get.toNamed(AppRoutes.addStoryScreen, arguments: files);
          }
    });
  }

}