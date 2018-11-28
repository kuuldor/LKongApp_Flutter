import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/utils/localization.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/models/serializers.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  AuthState._();

  factory AuthState([updates(AuthStateBuilder b)]) => _$AuthState((b) {
        b
          ..isAuthed = false
          ..currentUser.replace(User())
          ..update(updates);
      });

  @BuiltValueField(wireName: 'authed')
  bool get isAuthed;
  @BuiltValueField(wireName: 'currentUser')
  User get currentUser;
  @nullable
  @BuiltValueField(wireName: 'userInfo')
  UserInfo get userInfo;
  @nullable
  @BuiltValueField(wireName: 'error')
  String get error;

  String toJson() {
    return json.encode(serializers.serializeWith(AuthState.serializer, this));
  }

  static AuthState fromJson(String jsonString) {
    return serializers.deserializeWith(
        AuthState.serializer, json.decode(jsonString));
  }

  static Serializer<AuthState> get serializer => _$authStateSerializer;
}
