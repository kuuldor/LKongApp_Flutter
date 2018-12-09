import 'dart:async';

import 'package:flutter/material.dart';

class LKongLocalizations {
  static LKongLocalizations of(BuildContext context) {
    return Localizations.of<LKongLocalizations>(
      context,
      LKongLocalizations,
    );
  }

  String get appTitle => "龙空";
  String get defaultSignature => "正在使用龙空Flutter App";
}

class LKongLocalizationsDelegate
    extends LocalizationsDelegate<LKongLocalizations> {
  @override
  Future<LKongLocalizations> load(Locale locale) =>
      Future(() => LKongLocalizations());

  @override
  bool shouldReload(LKongLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en") 
      || locale.languageCode.toLowerCase().contains("zh");
}
