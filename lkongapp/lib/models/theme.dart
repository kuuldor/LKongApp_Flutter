import 'dart:convert';
import 'dart:ui';
import 'package:color/color.dart' as Colour;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:lkongapp/data/theme.dart';

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
  double opacity = 1.0;
  Colour.Color color;
  html = html.trim();
  RegExp hexPattern = RegExp('#([0-9A-F]{3,6})', caseSensitive: false);
  RegExp rgboPattern = RegExp(
      r'rgba\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+\.\d+)\s*\)',
      caseSensitive: false);
  RegExp rgbPattern =
      RegExp(r'rgb\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)', caseSensitive: false);

  String namedColor = htmlColorTable[html.toLowerCase()];
  if (namedColor != null) {
    color = Colour.Color.hex(namedColor);
  } else if (hexPattern.hasMatch(html)) {
    String hexStr = hexPattern.firstMatch(html).group(1);

    if (hexStr.length == 3) {
      hexStr =
          hexStr[0] + hexStr[0] + hexStr[1] + hexStr[1] + hexStr[2] + hexStr[2];
    }
    if (hexStr.length == 4) {
      hexStr = hexStr + "00";
    } else if (hexStr.length == 5) {
      hexStr = hexStr + "0";
    }

    color = Colour.Color.hex(hexStr);
  } else if (rgboPattern.hasMatch(html)) {
    Match match = rgboPattern.firstMatch(html);
    String r = match.group(1);
    String g = match.group(2);
    String b = match.group(3);
    String o = match.group(4);

    int red = int.parse(r);
    int green = int.parse(g);
    int blue = int.parse(b);

    opacity = double.parse(o);
    color = Colour.Color.rgb(red, green, blue);
  } else if (rgbPattern.hasMatch(html)) {
    Match match = rgbPattern.firstMatch(html);
    String r = match.group(1);
    String g = match.group(2);
    String b = match.group(3);

    int red = int.parse(r);
    int green = int.parse(g);
    int blue = int.parse(b);

    color = Colour.Color.rgb(red, green, blue);
  } else {
    color = Colour.Color.rgb(0, 0, 0);
  }

  if (nightRev) {
    Colour.HslColor hsl = color.toHslColor();
    color = Colour.Color.hsl(hsl.h, hsl.s, 100 - hsl.l);
  }

  Colour.RgbColor rgb = color.toRgbColor();

  return Color.fromRGBO(rgb.r, rgb.g, rgb.b, opacity);
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
