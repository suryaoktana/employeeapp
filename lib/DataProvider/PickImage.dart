import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

class PickImage{
  Future<ModelImagePicker> getCameraImage() async {
    var pickedFile;
    ModelImagePicker data;
    pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxHeight: 800,
        maxWidth: 800);
    if (pickedFile != null) {
      pickedFile = await FlutterExifRotation.rotateImage(path: pickedFile.path);
      data = new ModelImagePicker(
          File(pickedFile.path),
          base64Encode(File(pickedFile.path).readAsBytesSync()));
    }
    return data;
  }
}

class ModelImagePicker{
  String base64;
  File imageFile;
  ModelImagePicker(this.imageFile, this.base64);
}

