import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lkongapp/ui/modeled_app.dart';

void chooseImage(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey, {
  @required Function(File) onChosen,
  bool cropping: true,
}) {
  final theme = LKModeledApp.modelOf(context).theme;
  final sources = <ImageSource>[ImageSource.camera, ImageSource.gallery];
  final titles = <String>["相机", "图库"];
  final chosen = (int i) async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(source: sources[i]);
    if (cropping) {
      // print("File size before cropping: ${await image?.length()}");
      image = await ImageCropper.cropImage(
        sourcePath: image.path,
        toolbarColor: theme.mainColor,
      );
      // print("File size after cropping: ${await image?.length()}");
    }
    onChosen(image);
  };
  scaffoldKey.currentState.showBottomSheet((context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, i) => ListTile(
              title: Text(titles[i]),
              onTap: () => chosen(i),
            ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: theme.mainColor, width: 1.0),
          borderRadius: BorderRadius.circular(6.0)),
    );
  });
}
