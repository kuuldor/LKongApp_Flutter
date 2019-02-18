import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lkongapp/ui/modeled_app.dart';

void chooseImage(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
    Function(File) onChange) {
  final theme = LKModeledApp.modelOf(context).theme;
  final sources = <ImageSource>[ImageSource.camera, ImageSource.gallery];
  final titles = <String>["相机", "图库"];
  final chosen = (int i) async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(source: sources[i]);
    onChange(image);
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
