import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/app_config.dart';
import 'package:lkongapp/models/auth_state.dart';
import 'package:lkongapp/models/ui_state.dart';
import 'package:lkongapp/models/serializers.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([updates(AppStateBuilder b)]) => _$AppState((b) {
        b
          ..persistState.replace(PersistentState())
          ..uiState.replace(UIState())
          ..rehydrated = false
          ..isLoading = false
          ..update(updates);
      });

  bool get rehydrated;

  bool get isLoading;

  @BuiltValueField(wireName: 'uiState')
  UIState get uiState;

  @BuiltValueField(wireName: 'persistState')
  PersistentState get persistState;

  String toJson() {
    return json.encode(serializers.serializeWith(AppState.serializer, this));
  }

  static AppState fromJson(String jsonString) {
    return serializers.deserializeWith(
        AppState.serializer, json.decode(jsonString));
  }

  static Serializer<AppState> get serializer => _$appStateSerializer;
}

abstract class PersistentState
    implements Built<PersistentState, PersistentStateBuilder> {
  PersistentState._();

  factory PersistentState([updates(PersistentStateBuilder b)]) =>
      _$PersistentState((b) {
        b
          ..appConfig.replace(AppConfig())
          ..authState.replace(AuthState())
          ..update(updates);
      });

  @BuiltValueField(wireName: 'authState')
  AuthState get authState;

  @BuiltValueField(wireName: 'appConfig')
  AppConfig get appConfig;

  String toJson() {
    return json
        .encode(serializers.serializeWith(PersistentState.serializer, this));
  }

  static PersistentState fromJson(String jsonString) {
    return serializers.deserializeWith(
        PersistentState.serializer, json.decode(jsonString));
  }

  static Serializer<PersistentState> get serializer =>
      _$persistentStateSerializer;
}
