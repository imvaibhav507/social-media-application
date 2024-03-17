import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class FileManagerTwo {

  // List<XFile>? _mediaFileList;
  //
  // void _setImageFileListFromFile(XFile? value) {
  //   _mediaFileList = value == null ? null : <XFile>[value];
  // }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();
  /// Shows a modal bottom sheet for selecting images from the gallery or camera.
  ///
  /// The [maxFileSize] parameter specifies the maximum size of the image file, in bytes.
  /// The [allowedExtensions] parameter is a list of allowed file extensions for the images.
  /// The [getImages] parameter is a callback function that is called when the
  /// user selects an image. It receives a list of image paths as its argument.
  ///
  /// Returns a [Future] that completes when the bottom sheet is dismissed.
  showModelSheetForImage({
    int maxFileSize = 10 * 1024,
    List<String> allowedExtensions = const [],
    void Function(List<XFile?>)? getFiles,
    required BuildContext context,
  }) async {
    await Get.bottomSheet(
        SafeArea(
            child: Wrap(children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    List<XFile>? filesList =
                    await _onImageButtonPressed(
                        ImageSource.gallery,
                        isMultiImage: false,
                        isMedia: false,
                        context: context);
                    if (getFiles != null) {
                      getFiles(filesList!);
                    }
                    Get.back();
                  }),
              ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    List<XFile>? filesList =
                    await _onImageButtonPressed(
                        ImageSource.camera,
                        isMultiImage: false,
                        isMedia: false,
                        context: context);
                    if (getFiles != null) {
                      getFiles(filesList!);
                    }
                    Get.back();
                  })
            ])),
        backgroundColor: Colors.white);
  }

  /// Retrieves a list of image paths selected from the gallery.
  ///
  /// The [maxFileSize] parameter specifies the maximum size of the image file, in bytes.
  /// The [allowedExtensions] parameter is a list of allowed file extensions for the images.
  ///
  /// Returns a [Future] that completes with a list of image paths as its result.
  Future<List<String?>> _imgFromGallery(
      int maxFileSize,
      List<String>? allowedExtensions,
      ) async {
    List<String?> files = [];
    List<Media>? res1 =
    await ImagesPicker.pick(pickType: PickType.image, maxSize: maxFileSize);
    res1?.forEach((element) {
      var extension = element.path.split('.');
      if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
        if (allowedExtensions.contains(extension.last)) {
          files.add(element.path);
        } else {
          Get.snackbar('msg', 'only $allowedExtensions images are allowed');
        }
      } else {
        files.add(element.path);
      }
    });
    return files;
  }

  Future<List<String?>> _imgFromCamera(
      int maxFileSize,
      List<String>? allowedExtensions,
      ) async {
    List<String?> files = [];
    List<Media>? res1 = await ImagesPicker.openCamera(
        pickType: PickType.image, maxSize: maxFileSize);
    res1?.forEach((element) {
      var extension = element.path.split('.');
      if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
        if (allowedExtensions.contains(extension.last)) {
          files.add(element.path);
        } else {
          Get.snackbar('msg', 'only $allowedExtensions images are allowed');
        }
      } else {
        files.add(element.path);
      }
    });
    return files;
  }

  Future<List<XFile>?> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
        bool isMultiImage = false,
        bool isMedia = false,
      }) async {
    List<XFile>? filesList;
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final List<XFile> pickedFileList = <XFile>[];
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        if(file!=null) {
          pickedFileList.add(file);
          filesList = pickedFileList;
        }
        return filesList;
      } else if (isMultiImage) {
        try {
          final List<XFile> pickedFileList = isMedia
              ? await _picker.pickMultipleMedia()
              : await _picker.pickMultiImage();
          filesList = pickedFileList;
          return filesList;
        } catch (e) {
          _pickImageError = e;
        };
      } else if (isMedia) {
        try {
          final List<XFile> pickedFileList = <XFile>[];
          final XFile? media = await _picker.pickMedia();
          if (media != null) {
            pickedFileList.add(media);
            filesList = pickedFileList;
          }
          return filesList;
        } catch (e) {
          _pickImageError = e;
        };
      } else {
        try {
          final List<XFile> pickedFileList = <XFile>[];
          final XFile? pickedFile = await _picker.pickImage(
            source: source);
          if (pickedFile != null) {
            pickedFileList.add(pickedFile);
            filesList = pickedFileList;
          }
          return filesList;
        } catch (e) {
          _pickImageError = e;
        }
      }
    }
    return filesList;
  }


}
