import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'dart:math';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';

class LKongAppTheme {
  static Map<String, String> get themeColorKeys => {
        "main": "主色调",
        "barText": "标题栏文字颜色",
        "paper": "背景色",
        "headerBG": "标题背景",
        "quoteBG": "引文背景",
        "text": "正文颜色",
        "lightText": "淡色文字",
        "mediumText": "浅色文字",
        "darkText": "深色文字",
        "link": "链接颜色",
        "linkTap": "点击高亮"
      };

  final bool _isNightMode;
  final AppTheme _appTheme;

  @override
  bool operator ==(other) {
    return other is LKongAppTheme &&
        _appTheme == other._appTheme &&
        _isNightMode == other._isNightMode;
  }

  @override
  int get hashCode {
    return hash2(_appTheme, _isNightMode);
  }

  LKongAppTheme(this._appTheme, this._isNightMode);

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
    Color mainColor = htmlColor(_appTheme.colors['main']);
    Color pageColor = htmlColor(_appTheme.colors['paper']);
    Color barTextColor = htmlColor(_appTheme.colors['barText']);
    Color headerBG = htmlColor(_appTheme.colors['headerBG']);
    Color quoteBG = htmlColor(_appTheme.colors['quoteBG']);
    Color textColor = htmlColor(_appTheme.colors['text']);
    Color lightTextColor = htmlColor(_appTheme.colors['lightText']);
    Color mediumTextColor = htmlColor(_appTheme.colors['mediumText']);
    Color darkTextColor = htmlColor(_appTheme.colors['darkText']);
    Color linkColor = htmlColor(_appTheme.colors['link']);
    Color linkTapColor = htmlColor(_appTheme.colors['linkTap']);

    ThemeData template = _isNightMode ? ThemeData.dark() : ThemeData.light();

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
