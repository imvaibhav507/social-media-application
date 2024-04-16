import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/capture_image_screen/controller/capture_image_controller.dart';

class CameraWidget extends StatelessWidget {
  CameraWidget({Key? key}): super(key: key);

  var controller = Get.find<CaptureImageController>();


  @override
  Widget build(BuildContext context) {
    return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(controller.cameraController),
                ),
              ],
            );
  }
}

