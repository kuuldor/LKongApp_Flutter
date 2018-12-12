import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';
import 'package:lkongapp/data/theme.dart' as themeData;

part 'theme.g.dart';

AppTheme defaultTheme = AppTheme().rebuild((b) => b
  ..name = themeData.defaultTheme["name"]
  ..colors.addAll(themeData.defaultTheme["colors"]));

AppTheme nightTheme = AppTheme().rebuild((b) => b
  ..name = themeData.nightTheme["name"]
  ..colors.addAll(themeData.nightTheme["colors"]));

Color htmlColor(String html, {bool nightRev: false}) {
  Color color;
  html = html.trim();
  RegExp hexPattern = RegExp('#(([0-9A-F]{3}){1,2})', caseSensitive: false);
  RegExp rgboPattern = RegExp(
      'rgba\\((\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+\\.\\d+)\\s*\\)',
      caseSensitive: false);

  if (hexPattern.hasMatch(html)) {
    String hexStr = hexPattern.firstMatch(html).group(1).toUpperCase();
    if (nightRev) {
      final quickMap = {
        "0": "F",
        "1": "E",
        "2": "D",
        "3": "C",
        "4": "B",
        "5": "A",
        "6": "9",
        "7": "8",
        "8": "7",
        "9": "6",
        "A": "5",
        "B": "4",
        "C": "3",
        "D": "2",
        "E": "1",
        "F": "0"
      };
      bool allSame = true;
      String rev = quickMap[hexStr[0]];
      for (int i = 1; i < hexStr.length; i++) {
        if (hexStr[i] != hexStr[0]) {
          allSame = false;
          break;
        }
        rev += quickMap[hexStr[i]];
      }
      if (allSame) {
        hexStr = rev;
      }
    }
    if (hexStr.length == 3) {
      hexStr =
          hexStr[0] + hexStr[0] + hexStr[1] + hexStr[1] + hexStr[2] + hexStr[2];
    }
    hexStr = 'FF' + hexStr;
    int hexInt = int.parse(hexStr, radix: 16);
    color = Color(hexInt);
  } else if (rgboPattern.hasMatch(html)) {
    Match match = rgboPattern.firstMatch(html);
    String r = match.group(1);
    String g = match.group(2);
    String b = match.group(3);
    String o = match.group(4);

    int red = int.parse(r);
    int green = int.parse(g);
    int blue = int.parse(b);

    if (nightRev) {
      if (red == green && green == blue) {
        int rev = 255 - red;
        red = rev;
        green = rev;
        blue = rev;
      }
    }

    color = Color.fromRGBO(red, green, blue, double.parse(o));
  } else {
    color = Color(0);
  }

  return color;
}

abstract class AppTheme implements Built<AppTheme, AppThemeBuilder> {
  AppTheme._();

  factory AppTheme([updates(AppThemeBuilder b)]) => _$AppTheme((b) => b
    ..name = ""
    ..colors.replace(Map<String, String>())
    ..update(updates));

  @BuiltValueField(wireName: 'name')
  String get name;
  @BuiltValueField(wireName: 'colors')
  BuiltMap<String, String> get colors;

  String toJson() {
    return json.encode(serializers.serializeWith(AppTheme.serializer, this));
  }

  static AppTheme fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppTheme.serializer, json.decode(jsonString));
  }

  static Serializer<AppTheme> get serializer => _$appThemeSerializer;
}
