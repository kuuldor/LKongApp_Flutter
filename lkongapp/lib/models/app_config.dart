import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/utils/localization.dart';
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/models/serializers.dart';

part 'app_config.g.dart';

abstract class AppConfig implements Built<AppConfig, AppConfigBuilder> {
  AppConfig._();

  factory AppConfig([updates(AppConfigBuilder b)]) => _$AppConfig((b) {
        b
          ..setting.replace(AppSetting())
          ..accountSettings.replace(AccountSettings())
          ..update(updates);
      });

  @BuiltValueField(wireName: 'setting')
  AppSetting get setting;
  @BuiltValueField(wireName: 'accountSettings')
  AccountSettings get accountSettings;
  String toJson() {
    return json.encode(serializers.serializeWith(AppConfig.serializer, this));
  }

  static AppConfig fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppConfig.serializer, json.decode(jsonString));
  }

  static Serializer<AppConfig> get serializer => _$appConfigSerializer;
}

abstract class AppSetting implements Built<AppSetting, AppSettingBuilder> {
  AppSetting._();

  factory AppSetting([updates(AppSettingBuilder b)]) => _$AppSetting((b) {
        b
          ..saveCredential = true
          ..autoLogin = true
          ..autoPunch = true
          ..version = '0.1'
          ..copyright = '2017 Akeysoft'
          ..nightMode = false
          ..showForumInfo = false
          ..themeSetting.replace(ThemeSetting())
          ..shakeToShiftNightMode = true
          ..swipeThreshold = 80
          ..lockOrientation = false
          ..fontSize = 6
          ..allowCopy = false
          ..loadInSamePage = true
          ..hideBlacklisterPost = false
          ..showDetailTime = false
          ..uploadImageAPI = 0
          ..noImageMode = 0
          ..loadAvatar = false
          ..avatarDisplaySize = 1
          ..backgroundFetch = true
          ..cacheSize = 4
          ..detectLink = false
          ..update(updates);
      });

  @BuiltValueField(wireName: 'saveCredential')
  bool get saveCredential;
  @BuiltValueField(wireName: 'autoLogin')
  bool get autoLogin;
  @BuiltValueField(wireName: 'autoPunch')
  bool get autoPunch;
  @BuiltValueField(wireName: 'version')
  String get version;
  @BuiltValueField(wireName: 'copyright')
  String get copyright;
  @BuiltValueField(wireName: 'themeSetting')
  ThemeSetting get themeSetting;
  @BuiltValueField(wireName: 'nightMode')
  bool get nightMode;
  @BuiltValueField(wireName: 'shakeToShiftNightMode')
  bool get shakeToShiftNightMode;
  @BuiltValueField(wireName: 'swipeThreshold')
  int get swipeThreshold;
  @BuiltValueField(wireName: 'lockOrientation')
  bool get lockOrientation;
  @BuiltValueField(wireName: 'fontSize')
  double get fontSize;
  @BuiltValueField(wireName: 'allowCopy')
  bool get allowCopy;
  @BuiltValueField(wireName: 'loadInSamePage')
  bool get loadInSamePage;
  @BuiltValueField(wireName: 'hideBlacklisterPost')
  bool get hideBlacklisterPost;
  @BuiltValueField(wireName: 'showDetailTime')
  bool get showDetailTime;
  @BuiltValueField(wireName: 'uploadImageAPI')
  int get uploadImageAPI;
  @BuiltValueField(wireName: 'noImageMode')
  int get noImageMode;
  @BuiltValueField(wireName: 'loadAvatar')
  bool get loadAvatar;
  @BuiltValueField(wireName: 'avatarDisplaySize')
  int get avatarDisplaySize;
  @BuiltValueField(wireName: 'backgroundFetch')
  bool get backgroundFetch;
  @BuiltValueField(wireName: 'cacheSize')
  int get cacheSize;
  @BuiltValueField(wireName: 'showForumInfo')
  bool get showForumInfo;
  @nullable
  @BuiltValueField(wireName: 'detectLink')
  bool get detectLink;
  String toJson() {
    return json.encode(serializers.serializeWith(AppSetting.serializer, this));
  }

  static AppSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppSetting.serializer, json.decode(jsonString));
  }

  static Serializer<AppSetting> get serializer => _$appSettingSerializer;
}

abstract class ThemeSetting
    implements Built<ThemeSetting, ThemeSettingBuilder> {
  ThemeSetting._();

  factory ThemeSetting([updates(ThemeSettingBuilder b)]) =>
      _$ThemeSetting((b) => b
        ..day = 0
        ..night = 1
        ..theme = ListBuilder<AppTheme>([defaultTheme, nightTheme])
        ..update(updates));

  @BuiltValueField(wireName: 'day')
  int get day;
  @BuiltValueField(wireName: 'night')
  int get night;
  @BuiltValueField(wireName: 'theme')
  BuiltList<AppTheme> get theme;
  String toJson() {
    return json
        .encode(serializers.serializeWith(ThemeSetting.serializer, this));
  }

  static ThemeSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        ThemeSetting.serializer, json.decode(jsonString));
  }

  static Serializer<ThemeSetting> get serializer => _$themeSettingSerializer;
}

abstract class AccountSettings
    implements Built<AccountSettings, AccountSettingsBuilder> {
  AccountSettings._();

  factory AccountSettings([updates(AccountSettingsBuilder b)]) =>
      _$AccountSettings((b) {
        b
          ..currentSetting.replace(AccountSetting())
          ..accounts.addAll(Map<int, AccountSetting>())
          ..update(updates);
      });

  @BuiltValueField(wireName: 'currentSetting')
  AccountSetting get currentSetting;

  @BuiltValueField(wireName: 'accounts')
  BuiltMap<int, AccountSetting> get accounts;
  String toJson() {
    return json
        .encode(serializers.serializeWith(AccountSettings.serializer, this));
  }

  static AccountSettings fromJson(String jsonString) {
    return serializers.deserializeWith(
        AccountSettings.serializer, json.decode(jsonString));
  }

  static Serializer<AccountSettings> get serializer =>
      _$accountSettingsSerializer;
}

abstract class AccountSetting
    implements Built<AccountSetting, AccountSettingBuilder> {
  AccountSetting._();

  factory AccountSetting([updates(AccountSettingBuilder b)]) =>
      _$AccountSetting((b) => b
        ..homePage = 0
        ..threadOnlyHome = false
        ..signature = LKongLocalizations().defaultSignature
        ..update(updates));

  @BuiltValueField(wireName: 'homePage')
  int get homePage;
  @BuiltValueField(wireName: 'threadOnlyHome')
  bool get threadOnlyHome;
  @BuiltValueField(wireName: 'signature')
  String get signature;
  String toJson() {
    return json
        .encode(serializers.serializeWith(AccountSetting.serializer, this));
  }

  static AccountSetting fromJson(String jsonString) {
    return serializers.deserializeWith(
        AccountSetting.serializer, json.decode(jsonString));
  }

  static Serializer<AccountSetting> get serializer =>
      _$accountSettingSerializer;
}
