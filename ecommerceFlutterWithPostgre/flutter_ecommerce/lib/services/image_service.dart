import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ImageService extends ChangeNotifier{

  static File? file;

  uploadImageFromGallery() async {
    final _imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image

      image = await _imagePicker.getImage(source: ImageSource.gallery);
      file = File(image!.path);


    } else {
      print('Permission not granted. Try Again with permission access');
      notifyListeners();
    }
  }

  uploadImageFromCamera() async {
    final _imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.camera);
      file = File(image!.path);

    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  Future<void> showImageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kamera - Galeri"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Kamera ile veya galeriden resim yükle"),
                Text("Kamera veya galeriden resim yüklemek için izinleri kabul edin."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Galeri"),
              onPressed: () {
                //GetSampleHelper.uploadImageFromGallery(GetSampleHelper.file);
                uploadImageFromGallery();
                Navigator.of(context).pop();
                notifyListeners();
              },
            ),
            TextButton(
              child: Text("Kamera",),
              onPressed: () {
                uploadImageFromCamera();
                Navigator.of(context).pop();
                notifyListeners();
              },
            ),
            file == null
                ? TextButton(
                child: Text("Sil",),
                onPressed: null
            )
                : TextButton(
              child: Text("Sil",),
              onPressed: () {
                file = null;
                notifyListeners();
              },
            ),
          ],
        );
      },
    );
  }
}