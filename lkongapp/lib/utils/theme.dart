import 'package:flutter/material.dart';
import 'dart:math';

import 'package:lkongapp/models/models.dart';

class LKongAppTheme {
  AppTheme _appTheme;

  static get theme {
    return ThemeData.light().copyWith(
        primaryColor: Colors.grey[800],
        accentColor: Colors.cyan[300],
        buttonColor: Colors.grey[800],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.grey[800]);
  }

  static String randomColor() => '#' + (Random.secure().nextInt(0xFFFFFFFF).toRadixString(16) + "000000").substring(2, 6);

  String applyTheme(String css) {
    RegExp pattern = RegExp(r"#-([a-zA-Z0-9_]+)-", caseSensitive: false);
    String newCSS = css.replaceAllMapped(pattern, (Match match) {
      String name = match[1];
      String color = _appTheme.colors[name];
      if (color != null) {
        return color;
      } else {
        return randomColor();
      }
    });
    return newCSS;
  }
}
