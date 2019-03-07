import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/globals.dart' as globals;
import 'package:install_plugin/install_plugin.dart';
import 'package:lkongapp/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

checkUpgrade(BuildContext context) async {
  final cancelSpinner = await showSpinner(context);

  final result = await apiDispatch(CHECK_UPGRADE_API, null);
  cancelSpinner();

  if (result != null) {
    String version = result["version"];
    int build = result["build"];
    String downloadURL = result["download"];
    String changeLog = result["changelog"];

    if (version != null && build != null && downloadURL != null) {
      if (build > int.parse(globals.packageInfo.buildNumber)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text('版本更新'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text('发现新版本，是否更新？'),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "版本$version-$build",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text("更新记录：\n$changeLog"),
                  ],
                ),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: Text(
                    "放弃",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("更新"),
                  onPressed: () async {
                    Navigator.of(context).pop();

                    final downloadPath =
                        (await getExternalStorageDirectory()).path +
                            "/Download";
                    final params = Map();
                    params["URL"] = downloadURL;
                    params["CACHE_PATH"] = downloadPath;
                    params["HEADERS"] = Map<String, String>();

                    final spinnerCancel = await showSpinner(context);

                    bool granted = await SimplePermissions.checkPermission(
                        Permission.WriteExternalStorage);
                    if (!granted) {
                      final status = await SimplePermissions.requestPermission(
                          Permission.WriteExternalStorage);
                      if (status != PermissionStatus.authorized) {
                        return;
                      }
                    }

                    final result = await enqueueDownload(params);
                    String fileName = result["FILENAME"];
                    try {
                      InstallPlugin.installApk(downloadPath + "/" + fileName,
                          globals.packageInfo.packageName);
                    } catch (e) {
                      print(e.toString());
                    }
                    spinnerCancel();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}

Future<Function> showSpinner(BuildContext context) {
  final completer = Completer<Function>();

  final theme = LKModeledApp.modelOf(context).theme;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      completer.complete(() => Navigator.of(context).pop());
      return Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              color: theme.quoteBG,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    },
  );

  return completer.future;
}
