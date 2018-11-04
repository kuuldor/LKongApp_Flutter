import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'theme.g.dart';

const Map<String, String> themeColorKeys = {
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

AppTheme defaultTheme = (AppThemeBuilder()
  ..name = "默认"
  ..colors = {
    "main": "#0080C0",
    "paper": "#FFF",
    "headerBG": "#F0F0F0",
    "quoteBG": "#E9E9E9",
    "text": "#111",
    "lightText": "#999",
    "mediumText": "#666",
    "darkText": "#333",
    "barText": "#FFF",
    "link": "#0099CC",
    "linkTap": "rgba(51, 51, 51, 0.5)"
  }).build();

AppTheme nightTheme = (AppThemeBuilder()
  ..name = "默认夜间"
  ..colors = {
    "main": "#222",
    "paper": "#111",
    "headerBG": "#282828",
    "quoteBG": "#333",
    "text": "#EEE",
    "lightText": "#666",
    "mediumText": "#999",
    "darkText": "#CCC",
    "barText": "#FFF",
    "link": "#0099CC",
    "linkTap": "rgba(204, 204, 204, 0.5)"
  }).build();

abstract class AppTheme implements Built<AppTheme, AppThemeBuilder> {
  AppTheme._();

  factory AppTheme([updates(AppThemeBuilder b)]) => _$AppTheme((b) => b
    ..name = ""
    ..colors = {}
    ..update(updates));

  @BuiltValueField(wireName: 'name')
  String get name;
  @BuiltValueField(wireName: 'colors')
  Map<String, String> get colors;
  String toJson() {
    return json.encode(serializers.serializeWith(AppTheme.serializer, this));
  }

  static AppTheme fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppTheme.serializer, json.decode(jsonString));
  }

  static Serializer<AppTheme> get serializer => _$appThemeSerializer;
}
