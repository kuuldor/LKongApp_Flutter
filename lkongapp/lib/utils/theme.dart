import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'dart:math';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';

class LKongAppTheme {


  final bool isNightMode;
  final AppTheme appTheme;

  Color get mainColor => htmlColor(appTheme.colors['main']);
  Color get pageColor => htmlColor(appTheme.colors['paper']);
  Color get barTextColor => htmlColor(appTheme.colors['barText']);
  Color get headerBG => htmlColor(appTheme.colors['headerBG']);
  Color get quoteBG => htmlColor(appTheme.colors['quoteBG']);
  Color get textColor => htmlColor(appTheme.colors['text']);
  Color get lightTextColor => htmlColor(appTheme.colors['lightText']);
  Color get mediumTextColor => htmlColor(appTheme.colors['mediumText']);
  Color get darkTextColor => htmlColor(appTheme.colors['darkText']);
  Color get linkColor => htmlColor(appTheme.colors['link']);
  Color get linkTapColor => htmlColor(appTheme.colors['linkTap']);

  @override
  bool operator ==(other) {
    return other is LKongAppTheme &&
        appTheme == other.appTheme &&
        isNightMode == other.isNightMode;
  }

  @override
  int get hashCode {
    return hash2(appTheme, isNightMode);
  }

  LKongAppTheme(this.appTheme, this.isNightMode);

  static LKongAppTheme fromStore(Store<AppState> store) {
    bool night = store.state.appConfig.setting.nightMode;

    int themeIndex = night
        ? store.state.appConfig.setting.themeSetting.night
        : store.state.appConfig.setting.themeSetting.day;
    AppTheme theme =
        store.state.appConfig.setting.themeSetting.theme[themeIndex];

    return LKongAppTheme(theme, night);
  }

  ThemeData get themeData {
    ThemeData template = isNightMode ? ThemeData.dark() : ThemeData.light();

    return template.copyWith(
        primaryColor: mainColor,
        backgroundColor: pageColor,
        accentColor: mainColor,
        bottomAppBarColor: pageColor,
        primaryTextTheme: template.primaryTextTheme.apply(
          displayColor: textColor,
          bodyColor: barTextColor,
        ));
  }

  static String randomColor() =>
      '#' +
      (Random.secure().nextInt(0xFFFFFFFF).toRadixString(16) + "000000")
          .substring(2, 6);

  String applyTheme(String css) {
    RegExp pattern = RegExp(r"#-([a-zA-Z0-9_]+)-", caseSensitive: false);
    String newCSS = css.replaceAllMapped(pattern, (Match match) {
      String name = match[1];
      String color = appTheme.colors[name];
      if (color != null) {
        return color;
      } else {
        return randomColor();
      }
    });
    return newCSS;
  }
}
