// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppConfig> _$appConfigSerializer = new _$AppConfigSerializer();
Serializer<AppSetting> _$appSettingSerializer = new _$AppSettingSerializer();
Serializer<ThemeSetting> _$themeSettingSerializer =
    new _$ThemeSettingSerializer();
Serializer<AccountSettings> _$accountSettingsSerializer =
    new _$AccountSettingsSerializer();
Serializer<AccountSetting> _$accountSettingSerializer =
    new _$AccountSettingSerializer();

class _$AppConfigSerializer implements StructuredSerializer<AppConfig> {
  @override
  final Iterable<Type> types = const [AppConfig, _$AppConfig];
  @override
  final String wireName = 'AppConfig';

  @override
  Iterable serialize(Serializers serializers, AppConfig object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'setting',
      serializers.serialize(object.setting,
          specifiedType: const FullType(AppSetting)),
      'accountSettings',
      serializers.serialize(object.accountSettings,
          specifiedType: const FullType(AccountSettings)),
    ];

    return result;
  }

  @override
  AppConfig deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppConfigBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'setting':
          result.setting.replace(serializers.deserialize(value,
              specifiedType: const FullType(AppSetting)) as AppSetting);
          break;
        case 'accountSettings':
          result.accountSettings.replace(serializers.deserialize(value,
                  specifiedType: const FullType(AccountSettings))
              as AccountSettings);
          break;
      }
    }

    return result.build();
  }
}

class _$AppSettingSerializer implements StructuredSerializer<AppSetting> {
  @override
  final Iterable<Type> types = const [AppSetting, _$AppSetting];
  @override
  final String wireName = 'AppSetting';

  @override
  Iterable serialize(Serializers serializers, AppSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'saveCredential',
      serializers.serialize(object.saveCredential,
          specifiedType: const FullType(bool)),
      'autoLogin',
      serializers.serialize(object.autoLogin,
          specifiedType: const FullType(bool)),
      'autoPunch',
      serializers.serialize(object.autoPunch,
          specifiedType: const FullType(bool)),
      'version',
      serializers.serialize(object.version,
          specifiedType: const FullType(String)),
      'copyright',
      serializers.serialize(object.copyright,
          specifiedType: const FullType(String)),
      'themeSetting',
      serializers.serialize(object.themeSetting,
          specifiedType: const FullType(ThemeSetting)),
      'nightMode',
      serializers.serialize(object.nightMode,
          specifiedType: const FullType(bool)),
      'shakeToShiftNightMode',
      serializers.serialize(object.shakeToShiftNightMode,
          specifiedType: const FullType(bool)),
      'swipeThreshold',
      serializers.serialize(object.swipeThreshold,
          specifiedType: const FullType(int)),
      'lockOrientation',
      serializers.serialize(object.lockOrientation,
          specifiedType: const FullType(bool)),
      'fontSize',
      serializers.serialize(object.fontSize,
          specifiedType: const FullType(double)),
      'allowCopy',
      serializers.serialize(object.allowCopy,
          specifiedType: const FullType(bool)),
      'loadInSamePage',
      serializers.serialize(object.loadInSamePage,
          specifiedType: const FullType(bool)),
      'hideBlacklisterPost',
      serializers.serialize(object.hideBlacklisterPost,
          specifiedType: const FullType(bool)),
      'showDetailTime',
      serializers.serialize(object.showDetailTime,
          specifiedType: const FullType(bool)),
      'uploadImageAPI',
      serializers.serialize(object.uploadImageAPI,
          specifiedType: const FullType(int)),
      'noImageMode',
      serializers.serialize(object.noImageMode,
          specifiedType: const FullType(int)),
      'loadAvatar',
      serializers.serialize(object.loadAvatar,
          specifiedType: const FullType(bool)),
      'avatarDisplaySize',
      serializers.serialize(object.avatarDisplaySize,
          specifiedType: const FullType(int)),
      'backgroundFetch',
      serializers.serialize(object.backgroundFetch,
          specifiedType: const FullType(bool)),
      'cacheSize',
      serializers.serialize(object.cacheSize,
          specifiedType: const FullType(int)),
      'showForumInfo',
      serializers.serialize(object.showForumInfo,
          specifiedType: const FullType(bool)),
    ];
    if (object.detectLink != null) {
      result
        ..add('detectLink')
        ..add(serializers.serialize(object.detectLink,
            specifiedType: const FullType(bool)));
    }
    if (object.noCropImage != null) {
      result
        ..add('noCropImage')
        ..add(serializers.serialize(object.noCropImage,
            specifiedType: const FullType(bool)));
    }
    if (object.switchMethod != null) {
      result
        ..add('nightModeSwitchMethod')
        ..add(serializers.serialize(object.switchMethod,
            specifiedType: const FullType(int)));
    }
    if (object.alwaysSaveDraft != null) {
      result
        ..add('alwaysSaveDraft')
        ..add(serializers.serialize(object.alwaysSaveDraft,
            specifiedType: const FullType(bool)));
    }
    if (object.forumViewLayout != null) {
      result
        ..add('forumViewLayout')
        ..add(serializers.serialize(object.forumViewLayout,
            specifiedType: const FullType(int)));
    }
    if (object.shakeThreshold != null) {
      result
        ..add('shakeThreshold')
        ..add(serializers.serialize(object.shakeThreshold,
            specifiedType: const FullType(double)));
    }

    return result;
  }

  @override
  AppSetting deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'saveCredential':
          result.saveCredential = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'autoLogin':
          result.autoLogin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'autoPunch':
          result.autoPunch = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'version':
          result.version = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'copyright':
          result.copyright = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'themeSetting':
          result.themeSetting.replace(serializers.deserialize(value,
              specifiedType: const FullType(ThemeSetting)) as ThemeSetting);
          break;
        case 'nightMode':
          result.nightMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'shakeToShiftNightMode':
          result.shakeToShiftNightMode = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'swipeThreshold':
          result.swipeThreshold = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lockOrientation':
          result.lockOrientation = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'fontSize':
          result.fontSize = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'allowCopy':
          result.allowCopy = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'loadInSamePage':
          result.loadInSamePage = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'hideBlacklisterPost':
          result.hideBlacklisterPost = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'showDetailTime':
          result.showDetailTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'uploadImageAPI':
          result.uploadImageAPI = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'noImageMode':
          result.noImageMode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'loadAvatar':
          result.loadAvatar = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'avatarDisplaySize':
          result.avatarDisplaySize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'backgroundFetch':
          result.backgroundFetch = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'cacheSize':
          result.cacheSize = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'showForumInfo':
          result.showForumInfo = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'detectLink':
          result.detectLink = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'noCropImage':
          result.noCropImage = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'nightModeSwitchMethod':
          result.switchMethod = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'alwaysSaveDraft':
          result.alwaysSaveDraft = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'forumViewLayout':
          result.forumViewLayout = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'shakeThreshold':
          result.shakeThreshold = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$ThemeSettingSerializer implements StructuredSerializer<ThemeSetting> {
  @override
  final Iterable<Type> types = const [ThemeSetting, _$ThemeSetting];
  @override
  final String wireName = 'ThemeSetting';

  @override
  Iterable serialize(Serializers serializers, ThemeSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'day',
      serializers.serialize(object.day, specifiedType: const FullType(int)),
      'night',
      serializers.serialize(object.night, specifiedType: const FullType(int)),
      'theme',
      serializers.serialize(object.theme,
          specifiedType:
              const FullType(BuiltList, const [const FullType(AppTheme)])),
    ];

    return result;
  }

  @override
  ThemeSetting deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThemeSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'night':
          result.night = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'theme':
          result.theme.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(AppTheme)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$AccountSettingsSerializer
    implements StructuredSerializer<AccountSettings> {
  @override
  final Iterable<Type> types = const [AccountSettings, _$AccountSettings];
  @override
  final String wireName = 'AccountSettings';

  @override
  Iterable serialize(Serializers serializers, AccountSettings object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'accounts',
      serializers.serialize(object.accounts,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(int), const FullType(AccountSetting)])),
    ];
    if (object.currentSetting != null) {
      result
        ..add('currentSetting')
        ..add(serializers.serialize(object.currentSetting,
            specifiedType: const FullType(AccountSetting)));
    }

    return result;
  }

  @override
  AccountSettings deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountSettingsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentSetting':
          result.currentSetting.replace(serializers.deserialize(value,
              specifiedType: const FullType(AccountSetting)) as AccountSetting);
          break;
        case 'accounts':
          result.accounts.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(AccountSetting)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$AccountSettingSerializer
    implements StructuredSerializer<AccountSetting> {
  @override
  final Iterable<Type> types = const [AccountSetting, _$AccountSetting];
  @override
  final String wireName = 'AccountSetting';

  @override
  Iterable serialize(Serializers serializers, AccountSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'homePage',
      serializers.serialize(object.homePage,
          specifiedType: const FullType(int)),
      'threadOnlyHome',
      serializers.serialize(object.threadOnlyHome,
          specifiedType: const FullType(bool)),
      'signature',
      serializers.serialize(object.signature,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AccountSetting deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'homePage':
          result.homePage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'threadOnlyHome':
          result.threadOnlyHome = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'signature':
          result.signature = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AppConfig extends AppConfig {
  @override
  final AppSetting setting;
  @override
  final AccountSettings accountSettings;

  factory _$AppConfig([void updates(AppConfigBuilder b)]) =>
      (new AppConfigBuilder()..update(updates)).build();

  _$AppConfig._({this.setting, this.accountSettings}) : super._() {
    if (setting == null) {
      throw new BuiltValueNullFieldError('AppConfig', 'setting');
    }
    if (accountSettings == null) {
      throw new BuiltValueNullFieldError('AppConfig', 'accountSettings');
    }
  }

  @override
  AppConfig rebuild(void updates(AppConfigBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppConfigBuilder toBuilder() => new AppConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppConfig &&
        setting == other.setting &&
        accountSettings == other.accountSettings;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, setting.hashCode), accountSettings.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppConfig')
          ..add('setting', setting)
          ..add('accountSettings', accountSettings))
        .toString();
  }
}

class AppConfigBuilder implements Builder<AppConfig, AppConfigBuilder> {
  _$AppConfig _$v;

  AppSettingBuilder _setting;
  AppSettingBuilder get setting => _$this._setting ??= new AppSettingBuilder();
  set setting(AppSettingBuilder setting) => _$this._setting = setting;

  AccountSettingsBuilder _accountSettings;
  AccountSettingsBuilder get accountSettings =>
      _$this._accountSettings ??= new AccountSettingsBuilder();
  set accountSettings(AccountSettingsBuilder accountSettings) =>
      _$this._accountSettings = accountSettings;

  AppConfigBuilder();

  AppConfigBuilder get _$this {
    if (_$v != null) {
      _setting = _$v.setting?.toBuilder();
      _accountSettings = _$v.accountSettings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppConfig other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppConfig;
  }

  @override
  void update(void updates(AppConfigBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppConfig build() {
    _$AppConfig _$result;
    try {
      _$result = _$v ??
          new _$AppConfig._(
              setting: setting.build(),
              accountSettings: accountSettings.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'setting';
        setting.build();
        _$failedField = 'accountSettings';
        accountSettings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AppSetting extends AppSetting {
  @override
  final bool saveCredential;
  @override
  final bool autoLogin;
  @override
  final bool autoPunch;
  @override
  final String version;
  @override
  final String copyright;
  @override
  final ThemeSetting themeSetting;
  @override
  final bool nightMode;
  @override
  final bool shakeToShiftNightMode;
  @override
  final int swipeThreshold;
  @override
  final bool lockOrientation;
  @override
  final double fontSize;
  @override
  final bool allowCopy;
  @override
  final bool loadInSamePage;
  @override
  final bool hideBlacklisterPost;
  @override
  final bool showDetailTime;
  @override
  final int uploadImageAPI;
  @override
  final int noImageMode;
  @override
  final bool loadAvatar;
  @override
  final int avatarDisplaySize;
  @override
  final bool backgroundFetch;
  @override
  final int cacheSize;
  @override
  final bool showForumInfo;
  @override
  final bool detectLink;
  @override
  final bool noCropImage;
  @override
  final int switchMethod;
  @override
  final bool alwaysSaveDraft;
  @override
  final int forumViewLayout;
  @override
  final double shakeThreshold;

  factory _$AppSetting([void updates(AppSettingBuilder b)]) =>
      (new AppSettingBuilder()..update(updates)).build();

  _$AppSetting._(
      {this.saveCredential,
      this.autoLogin,
      this.autoPunch,
      this.version,
      this.copyright,
      this.themeSetting,
      this.nightMode,
      this.shakeToShiftNightMode,
      this.swipeThreshold,
      this.lockOrientation,
      this.fontSize,
      this.allowCopy,
      this.loadInSamePage,
      this.hideBlacklisterPost,
      this.showDetailTime,
      this.uploadImageAPI,
      this.noImageMode,
      this.loadAvatar,
      this.avatarDisplaySize,
      this.backgroundFetch,
      this.cacheSize,
      this.showForumInfo,
      this.detectLink,
      this.noCropImage,
      this.switchMethod,
      this.alwaysSaveDraft,
      this.forumViewLayout,
      this.shakeThreshold})
      : super._() {
    if (saveCredential == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'saveCredential');
    }
    if (autoLogin == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'autoLogin');
    }
    if (autoPunch == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'autoPunch');
    }
    if (version == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'version');
    }
    if (copyright == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'copyright');
    }
    if (themeSetting == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'themeSetting');
    }
    if (nightMode == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'nightMode');
    }
    if (shakeToShiftNightMode == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'shakeToShiftNightMode');
    }
    if (swipeThreshold == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'swipeThreshold');
    }
    if (lockOrientation == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'lockOrientation');
    }
    if (fontSize == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'fontSize');
    }
    if (allowCopy == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'allowCopy');
    }
    if (loadInSamePage == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'loadInSamePage');
    }
    if (hideBlacklisterPost == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'hideBlacklisterPost');
    }
    if (showDetailTime == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'showDetailTime');
    }
    if (uploadImageAPI == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'uploadImageAPI');
    }
    if (noImageMode == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'noImageMode');
    }
    if (loadAvatar == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'loadAvatar');
    }
    if (avatarDisplaySize == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'avatarDisplaySize');
    }
    if (backgroundFetch == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'backgroundFetch');
    }
    if (cacheSize == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'cacheSize');
    }
    if (showForumInfo == null) {
      throw new BuiltValueNullFieldError('AppSetting', 'showForumInfo');
    }
  }

  @override
  AppSetting rebuild(void updates(AppSettingBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppSettingBuilder toBuilder() => new AppSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppSetting &&
        saveCredential == other.saveCredential &&
        autoLogin == other.autoLogin &&
        autoPunch == other.autoPunch &&
        version == other.version &&
        copyright == other.copyright &&
        themeSetting == other.themeSetting &&
        nightMode == other.nightMode &&
        shakeToShiftNightMode == other.shakeToShiftNightMode &&
        swipeThreshold == other.swipeThreshold &&
        lockOrientation == other.lockOrientation &&
        fontSize == other.fontSize &&
        allowCopy == other.allowCopy &&
        loadInSamePage == other.loadInSamePage &&
        hideBlacklisterPost == other.hideBlacklisterPost &&
        showDetailTime == other.showDetailTime &&
        uploadImageAPI == other.uploadImageAPI &&
        noImageMode == other.noImageMode &&
        loadAvatar == other.loadAvatar &&
        avatarDisplaySize == other.avatarDisplaySize &&
        backgroundFetch == other.backgroundFetch &&
        cacheSize == other.cacheSize &&
        showForumInfo == other.showForumInfo &&
        detectLink == other.detectLink &&
        noCropImage == other.noCropImage &&
        switchMethod == other.switchMethod &&
        alwaysSaveDraft == other.alwaysSaveDraft &&
        forumViewLayout == other.forumViewLayout &&
        shakeThreshold == other.shakeThreshold;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, saveCredential.hashCode), autoLogin.hashCode), autoPunch.hashCode), version.hashCode), copyright.hashCode), themeSetting.hashCode), nightMode.hashCode), shakeToShiftNightMode.hashCode), swipeThreshold.hashCode),
                                                                                lockOrientation.hashCode),
                                                                            fontSize.hashCode),
                                                                        allowCopy.hashCode),
                                                                    loadInSamePage.hashCode),
                                                                hideBlacklisterPost.hashCode),
                                                            showDetailTime.hashCode),
                                                        uploadImageAPI.hashCode),
                                                    noImageMode.hashCode),
                                                loadAvatar.hashCode),
                                            avatarDisplaySize.hashCode),
                                        backgroundFetch.hashCode),
                                    cacheSize.hashCode),
                                showForumInfo.hashCode),
                            detectLink.hashCode),
                        noCropImage.hashCode),
                    switchMethod.hashCode),
                alwaysSaveDraft.hashCode),
            forumViewLayout.hashCode),
        shakeThreshold.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppSetting')
          ..add('saveCredential', saveCredential)
          ..add('autoLogin', autoLogin)
          ..add('autoPunch', autoPunch)
          ..add('version', version)
          ..add('copyright', copyright)
          ..add('themeSetting', themeSetting)
          ..add('nightMode', nightMode)
          ..add('shakeToShiftNightMode', shakeToShiftNightMode)
          ..add('swipeThreshold', swipeThreshold)
          ..add('lockOrientation', lockOrientation)
          ..add('fontSize', fontSize)
          ..add('allowCopy', allowCopy)
          ..add('loadInSamePage', loadInSamePage)
          ..add('hideBlacklisterPost', hideBlacklisterPost)
          ..add('showDetailTime', showDetailTime)
          ..add('uploadImageAPI', uploadImageAPI)
          ..add('noImageMode', noImageMode)
          ..add('loadAvatar', loadAvatar)
          ..add('avatarDisplaySize', avatarDisplaySize)
          ..add('backgroundFetch', backgroundFetch)
          ..add('cacheSize', cacheSize)
          ..add('showForumInfo', showForumInfo)
          ..add('detectLink', detectLink)
          ..add('noCropImage', noCropImage)
          ..add('switchMethod', switchMethod)
          ..add('alwaysSaveDraft', alwaysSaveDraft)
          ..add('forumViewLayout', forumViewLayout)
          ..add('shakeThreshold', shakeThreshold))
        .toString();
  }
}

class AppSettingBuilder implements Builder<AppSetting, AppSettingBuilder> {
  _$AppSetting _$v;

  bool _saveCredential;
  bool get saveCredential => _$this._saveCredential;
  set saveCredential(bool saveCredential) =>
      _$this._saveCredential = saveCredential;

  bool _autoLogin;
  bool get autoLogin => _$this._autoLogin;
  set autoLogin(bool autoLogin) => _$this._autoLogin = autoLogin;

  bool _autoPunch;
  bool get autoPunch => _$this._autoPunch;
  set autoPunch(bool autoPunch) => _$this._autoPunch = autoPunch;

  String _version;
  String get version => _$this._version;
  set version(String version) => _$this._version = version;

  String _copyright;
  String get copyright => _$this._copyright;
  set copyright(String copyright) => _$this._copyright = copyright;

  ThemeSettingBuilder _themeSetting;
  ThemeSettingBuilder get themeSetting =>
      _$this._themeSetting ??= new ThemeSettingBuilder();
  set themeSetting(ThemeSettingBuilder themeSetting) =>
      _$this._themeSetting = themeSetting;

  bool _nightMode;
  bool get nightMode => _$this._nightMode;
  set nightMode(bool nightMode) => _$this._nightMode = nightMode;

  bool _shakeToShiftNightMode;
  bool get shakeToShiftNightMode => _$this._shakeToShiftNightMode;
  set shakeToShiftNightMode(bool shakeToShiftNightMode) =>
      _$this._shakeToShiftNightMode = shakeToShiftNightMode;

  int _swipeThreshold;
  int get swipeThreshold => _$this._swipeThreshold;
  set swipeThreshold(int swipeThreshold) =>
      _$this._swipeThreshold = swipeThreshold;

  bool _lockOrientation;
  bool get lockOrientation => _$this._lockOrientation;
  set lockOrientation(bool lockOrientation) =>
      _$this._lockOrientation = lockOrientation;

  double _fontSize;
  double get fontSize => _$this._fontSize;
  set fontSize(double fontSize) => _$this._fontSize = fontSize;

  bool _allowCopy;
  bool get allowCopy => _$this._allowCopy;
  set allowCopy(bool allowCopy) => _$this._allowCopy = allowCopy;

  bool _loadInSamePage;
  bool get loadInSamePage => _$this._loadInSamePage;
  set loadInSamePage(bool loadInSamePage) =>
      _$this._loadInSamePage = loadInSamePage;

  bool _hideBlacklisterPost;
  bool get hideBlacklisterPost => _$this._hideBlacklisterPost;
  set hideBlacklisterPost(bool hideBlacklisterPost) =>
      _$this._hideBlacklisterPost = hideBlacklisterPost;

  bool _showDetailTime;
  bool get showDetailTime => _$this._showDetailTime;
  set showDetailTime(bool showDetailTime) =>
      _$this._showDetailTime = showDetailTime;

  int _uploadImageAPI;
  int get uploadImageAPI => _$this._uploadImageAPI;
  set uploadImageAPI(int uploadImageAPI) =>
      _$this._uploadImageAPI = uploadImageAPI;

  int _noImageMode;
  int get noImageMode => _$this._noImageMode;
  set noImageMode(int noImageMode) => _$this._noImageMode = noImageMode;

  bool _loadAvatar;
  bool get loadAvatar => _$this._loadAvatar;
  set loadAvatar(bool loadAvatar) => _$this._loadAvatar = loadAvatar;

  int _avatarDisplaySize;
  int get avatarDisplaySize => _$this._avatarDisplaySize;
  set avatarDisplaySize(int avatarDisplaySize) =>
      _$this._avatarDisplaySize = avatarDisplaySize;

  bool _backgroundFetch;
  bool get backgroundFetch => _$this._backgroundFetch;
  set backgroundFetch(bool backgroundFetch) =>
      _$this._backgroundFetch = backgroundFetch;

  int _cacheSize;
  int get cacheSize => _$this._cacheSize;
  set cacheSize(int cacheSize) => _$this._cacheSize = cacheSize;

  bool _showForumInfo;
  bool get showForumInfo => _$this._showForumInfo;
  set showForumInfo(bool showForumInfo) =>
      _$this._showForumInfo = showForumInfo;

  bool _detectLink;
  bool get detectLink => _$this._detectLink;
  set detectLink(bool detectLink) => _$this._detectLink = detectLink;

  bool _noCropImage;
  bool get noCropImage => _$this._noCropImage;
  set noCropImage(bool noCropImage) => _$this._noCropImage = noCropImage;

  int _switchMethod;
  int get switchMethod => _$this._switchMethod;
  set switchMethod(int switchMethod) => _$this._switchMethod = switchMethod;

  bool _alwaysSaveDraft;
  bool get alwaysSaveDraft => _$this._alwaysSaveDraft;
  set alwaysSaveDraft(bool alwaysSaveDraft) =>
      _$this._alwaysSaveDraft = alwaysSaveDraft;

  int _forumViewLayout;
  int get forumViewLayout => _$this._forumViewLayout;
  set forumViewLayout(int forumViewLayout) =>
      _$this._forumViewLayout = forumViewLayout;

  double _shakeThreshold;
  double get shakeThreshold => _$this._shakeThreshold;
  set shakeThreshold(double shakeThreshold) =>
      _$this._shakeThreshold = shakeThreshold;

  AppSettingBuilder();

  AppSettingBuilder get _$this {
    if (_$v != null) {
      _saveCredential = _$v.saveCredential;
      _autoLogin = _$v.autoLogin;
      _autoPunch = _$v.autoPunch;
      _version = _$v.version;
      _copyright = _$v.copyright;
      _themeSetting = _$v.themeSetting?.toBuilder();
      _nightMode = _$v.nightMode;
      _shakeToShiftNightMode = _$v.shakeToShiftNightMode;
      _swipeThreshold = _$v.swipeThreshold;
      _lockOrientation = _$v.lockOrientation;
      _fontSize = _$v.fontSize;
      _allowCopy = _$v.allowCopy;
      _loadInSamePage = _$v.loadInSamePage;
      _hideBlacklisterPost = _$v.hideBlacklisterPost;
      _showDetailTime = _$v.showDetailTime;
      _uploadImageAPI = _$v.uploadImageAPI;
      _noImageMode = _$v.noImageMode;
      _loadAvatar = _$v.loadAvatar;
      _avatarDisplaySize = _$v.avatarDisplaySize;
      _backgroundFetch = _$v.backgroundFetch;
      _cacheSize = _$v.cacheSize;
      _showForumInfo = _$v.showForumInfo;
      _detectLink = _$v.detectLink;
      _noCropImage = _$v.noCropImage;
      _switchMethod = _$v.switchMethod;
      _alwaysSaveDraft = _$v.alwaysSaveDraft;
      _forumViewLayout = _$v.forumViewLayout;
      _shakeThreshold = _$v.shakeThreshold;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppSetting;
  }

  @override
  void update(void updates(AppSettingBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppSetting build() {
    _$AppSetting _$result;
    try {
      _$result = _$v ??
          new _$AppSetting._(
              saveCredential: saveCredential,
              autoLogin: autoLogin,
              autoPunch: autoPunch,
              version: version,
              copyright: copyright,
              themeSetting: themeSetting.build(),
              nightMode: nightMode,
              shakeToShiftNightMode: shakeToShiftNightMode,
              swipeThreshold: swipeThreshold,
              lockOrientation: lockOrientation,
              fontSize: fontSize,
              allowCopy: allowCopy,
              loadInSamePage: loadInSamePage,
              hideBlacklisterPost: hideBlacklisterPost,
              showDetailTime: showDetailTime,
              uploadImageAPI: uploadImageAPI,
              noImageMode: noImageMode,
              loadAvatar: loadAvatar,
              avatarDisplaySize: avatarDisplaySize,
              backgroundFetch: backgroundFetch,
              cacheSize: cacheSize,
              showForumInfo: showForumInfo,
              detectLink: detectLink,
              noCropImage: noCropImage,
              switchMethod: switchMethod,
              alwaysSaveDraft: alwaysSaveDraft,
              forumViewLayout: forumViewLayout,
              shakeThreshold: shakeThreshold);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'themeSetting';
        themeSetting.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppSetting', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ThemeSetting extends ThemeSetting {
  @override
  final int day;
  @override
  final int night;
  @override
  final BuiltList<AppTheme> theme;

  factory _$ThemeSetting([void updates(ThemeSettingBuilder b)]) =>
      (new ThemeSettingBuilder()..update(updates)).build();

  _$ThemeSetting._({this.day, this.night, this.theme}) : super._() {
    if (day == null) {
      throw new BuiltValueNullFieldError('ThemeSetting', 'day');
    }
    if (night == null) {
      throw new BuiltValueNullFieldError('ThemeSetting', 'night');
    }
    if (theme == null) {
      throw new BuiltValueNullFieldError('ThemeSetting', 'theme');
    }
  }

  @override
  ThemeSetting rebuild(void updates(ThemeSettingBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ThemeSettingBuilder toBuilder() => new ThemeSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ThemeSetting &&
        day == other.day &&
        night == other.night &&
        theme == other.theme;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, day.hashCode), night.hashCode), theme.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ThemeSetting')
          ..add('day', day)
          ..add('night', night)
          ..add('theme', theme))
        .toString();
  }
}

class ThemeSettingBuilder
    implements Builder<ThemeSetting, ThemeSettingBuilder> {
  _$ThemeSetting _$v;

  int _day;
  int get day => _$this._day;
  set day(int day) => _$this._day = day;

  int _night;
  int get night => _$this._night;
  set night(int night) => _$this._night = night;

  ListBuilder<AppTheme> _theme;
  ListBuilder<AppTheme> get theme =>
      _$this._theme ??= new ListBuilder<AppTheme>();
  set theme(ListBuilder<AppTheme> theme) => _$this._theme = theme;

  ThemeSettingBuilder();

  ThemeSettingBuilder get _$this {
    if (_$v != null) {
      _day = _$v.day;
      _night = _$v.night;
      _theme = _$v.theme?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ThemeSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ThemeSetting;
  }

  @override
  void update(void updates(ThemeSettingBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ThemeSetting build() {
    _$ThemeSetting _$result;
    try {
      _$result = _$v ??
          new _$ThemeSetting._(day: day, night: night, theme: theme.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'theme';
        theme.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ThemeSetting', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AccountSettings extends AccountSettings {
  @override
  final AccountSetting currentSetting;
  @override
  final BuiltMap<int, AccountSetting> accounts;

  factory _$AccountSettings([void updates(AccountSettingsBuilder b)]) =>
      (new AccountSettingsBuilder()..update(updates)).build();

  _$AccountSettings._({this.currentSetting, this.accounts}) : super._() {
    if (accounts == null) {
      throw new BuiltValueNullFieldError('AccountSettings', 'accounts');
    }
  }

  @override
  AccountSettings rebuild(void updates(AccountSettingsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountSettingsBuilder toBuilder() =>
      new AccountSettingsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountSettings &&
        currentSetting == other.currentSetting &&
        accounts == other.accounts;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, currentSetting.hashCode), accounts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountSettings')
          ..add('currentSetting', currentSetting)
          ..add('accounts', accounts))
        .toString();
  }
}

class AccountSettingsBuilder
    implements Builder<AccountSettings, AccountSettingsBuilder> {
  _$AccountSettings _$v;

  AccountSettingBuilder _currentSetting;
  AccountSettingBuilder get currentSetting =>
      _$this._currentSetting ??= new AccountSettingBuilder();
  set currentSetting(AccountSettingBuilder currentSetting) =>
      _$this._currentSetting = currentSetting;

  MapBuilder<int, AccountSetting> _accounts;
  MapBuilder<int, AccountSetting> get accounts =>
      _$this._accounts ??= new MapBuilder<int, AccountSetting>();
  set accounts(MapBuilder<int, AccountSetting> accounts) =>
      _$this._accounts = accounts;

  AccountSettingsBuilder();

  AccountSettingsBuilder get _$this {
    if (_$v != null) {
      _currentSetting = _$v.currentSetting?.toBuilder();
      _accounts = _$v.accounts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountSettings other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AccountSettings;
  }

  @override
  void update(void updates(AccountSettingsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AccountSettings build() {
    _$AccountSettings _$result;
    try {
      _$result = _$v ??
          new _$AccountSettings._(
              currentSetting: _currentSetting?.build(),
              accounts: accounts.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentSetting';
        _currentSetting?.build();
        _$failedField = 'accounts';
        accounts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AccountSettings', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$AccountSetting extends AccountSetting {
  @override
  final int homePage;
  @override
  final bool threadOnlyHome;
  @override
  final String signature;

  factory _$AccountSetting([void updates(AccountSettingBuilder b)]) =>
      (new AccountSettingBuilder()..update(updates)).build();

  _$AccountSetting._({this.homePage, this.threadOnlyHome, this.signature})
      : super._() {
    if (homePage == null) {
      throw new BuiltValueNullFieldError('AccountSetting', 'homePage');
    }
    if (threadOnlyHome == null) {
      throw new BuiltValueNullFieldError('AccountSetting', 'threadOnlyHome');
    }
    if (signature == null) {
      throw new BuiltValueNullFieldError('AccountSetting', 'signature');
    }
  }

  @override
  AccountSetting rebuild(void updates(AccountSettingBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountSettingBuilder toBuilder() =>
      new AccountSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountSetting &&
        homePage == other.homePage &&
        threadOnlyHome == other.threadOnlyHome &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, homePage.hashCode), threadOnlyHome.hashCode),
        signature.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountSetting')
          ..add('homePage', homePage)
          ..add('threadOnlyHome', threadOnlyHome)
          ..add('signature', signature))
        .toString();
  }
}

class AccountSettingBuilder
    implements Builder<AccountSetting, AccountSettingBuilder> {
  _$AccountSetting _$v;

  int _homePage;
  int get homePage => _$this._homePage;
  set homePage(int homePage) => _$this._homePage = homePage;

  bool _threadOnlyHome;
  bool get threadOnlyHome => _$this._threadOnlyHome;
  set threadOnlyHome(bool threadOnlyHome) =>
      _$this._threadOnlyHome = threadOnlyHome;

  String _signature;
  String get signature => _$this._signature;
  set signature(String signature) => _$this._signature = signature;

  AccountSettingBuilder();

  AccountSettingBuilder get _$this {
    if (_$v != null) {
      _homePage = _$v.homePage;
      _threadOnlyHome = _$v.threadOnlyHome;
      _signature = _$v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AccountSetting;
  }

  @override
  void update(void updates(AccountSettingBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AccountSetting build() {
    final _$result = _$v ??
        new _$AccountSetting._(
            homePage: homePage,
            threadOnlyHome: threadOnlyHome,
            signature: signature);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
