import 'dart:async';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

void main() {
  hexColorTest();
}

void hexColorTest() {
  const colors = {
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
  };
  test('Hex Color Test', () {
    colors.forEach((key, value) {
      Color color = htmlColor(value);
      print(key + ": " + value + "  => " + color.toString());
    });

    // expect(map['uid'], 812695);
   
  });
}
