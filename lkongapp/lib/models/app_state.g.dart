// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();
Serializer<PersistentState> _$persistentStateSerializer =
    new _$PersistentStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'rehydrated',
      serializers.serialize(object.rehydrated,
          specifiedType: const FullType(bool)),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'uiState',
      serializers.serialize(object.uiState,
          specifiedType: const FullType(UIState)),
      'persistState',
      serializers.serialize(object.persistState,
          specifiedType: const FullType(PersistentState)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'rehydrated':
          result.rehydrated = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'uiState':
          result.uiState.replace(serializers.deserialize(value,
              specifiedType: const FullType(UIState)) as UIState);
          break;
        case 'persistState':
          result.persistState.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PersistentState))
              as PersistentState);
          break;
      }
    }

    return result.build();
  }
}

class _$PersistentStateSerializer
    implements StructuredSerializer<PersistentState> {
  @override
  final Iterable<Type> types = const [PersistentState, _$PersistentState];
  @override
  final String wireName = 'PersistentState';

  @override
  Iterable serialize(Serializers serializers, PersistentState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'authState',
      serializers.serialize(object.authState,
          specifiedType: const FullType(AuthState)),
      'appConfig',
      serializers.serialize(object.appConfig,
          specifiedType: const FullType(AppConfig)),
    ];

    return result;
  }

  @override
  PersistentState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PersistentStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'authState':
          result.authState.replace(serializers.deserialize(value,
              specifiedType: const FullType(AuthState)) as AuthState);
          break;
        case 'appConfig':
          result.appConfig.replace(serializers.deserialize(value,
              specifiedType: const FullType(AppConfig)) as AppConfig);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final bool rehydrated;
  @override
  final bool isLoading;
  @override
  final UIState uiState;
  @override
  final PersistentState persistState;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {this.rehydrated, this.isLoading, this.uiState, this.persistState})
      : super._() {
    if (rehydrated == null) {
      throw new BuiltValueNullFieldError('AppState', 'rehydrated');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('AppState', 'isLoading');
    }
    if (uiState == null) {
      throw new BuiltValueNullFieldError('AppState', 'uiState');
    }
    if (persistState == null) {
      throw new BuiltValueNullFieldError('AppState', 'persistState');
    }
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        rehydrated == other.rehydrated &&
        isLoading == other.isLoading &&
        uiState == other.uiState &&
        persistState == other.persistState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, rehydrated.hashCode), isLoading.hashCode),
            uiState.hashCode),
        persistState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('rehydrated', rehydrated)
          ..add('isLoading', isLoading)
          ..add('uiState', uiState)
          ..add('persistState', persistState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  bool _rehydrated;
  bool get rehydrated => _$this._rehydrated;
  set rehydrated(bool rehydrated) => _$this._rehydrated = rehydrated;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  UIStateBuilder _uiState;
  UIStateBuilder get uiState => _$this._uiState ??= new UIStateBuilder();
  set uiState(UIStateBuilder uiState) => _$this._uiState = uiState;

  PersistentStateBuilder _persistState;
  PersistentStateBuilder get persistState =>
      _$this._persistState ??= new PersistentStateBuilder();
  set persistState(PersistentStateBuilder persistState) =>
      _$this._persistState = persistState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _rehydrated = _$v.rehydrated;
      _isLoading = _$v.isLoading;
      _uiState = _$v.uiState?.toBuilder();
      _persistState = _$v.persistState?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              rehydrated: rehydrated,
              isLoading: isLoading,
              uiState: uiState.build(),
              persistState: persistState.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'uiState';
        uiState.build();
        _$failedField = 'persistState';
        persistState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PersistentState extends PersistentState {
  @override
  final AuthState authState;
  @override
  final AppConfig appConfig;

  factory _$PersistentState([void updates(PersistentStateBuilder b)]) =>
      (new PersistentStateBuilder()..update(updates)).build();

  _$PersistentState._({this.authState, this.appConfig}) : super._() {
    if (authState == null) {
      throw new BuiltValueNullFieldError('PersistentState', 'authState');
    }
    if (appConfig == null) {
      throw new BuiltValueNullFieldError('PersistentState', 'appConfig');
    }
  }

  @override
  PersistentState rebuild(void updates(PersistentStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PersistentStateBuilder toBuilder() =>
      new PersistentStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PersistentState &&
        authState == other.authState &&
        appConfig == other.appConfig;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, authState.hashCode), appConfig.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PersistentState')
          ..add('authState', authState)
          ..add('appConfig', appConfig))
        .toString();
  }
}

class PersistentStateBuilder
    implements Builder<PersistentState, PersistentStateBuilder> {
  _$PersistentState _$v;

  AuthStateBuilder _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder authState) => _$this._authState = authState;

  AppConfigBuilder _appConfig;
  AppConfigBuilder get appConfig =>
      _$this._appConfig ??= new AppConfigBuilder();
  set appConfig(AppConfigBuilder appConfig) => _$this._appConfig = appConfig;

  PersistentStateBuilder();

  PersistentStateBuilder get _$this {
    if (_$v != null) {
      _authState = _$v.authState?.toBuilder();
      _appConfig = _$v.appConfig?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PersistentState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PersistentState;
  }

  @override
  void update(void updates(PersistentStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PersistentState build() {
    _$PersistentState _$result;
    try {
      _$result = _$v ??
          new _$PersistentState._(
              authState: authState.build(), appConfig: appConfig.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();
        _$failedField = 'appConfig';
        appConfig.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PersistentState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
