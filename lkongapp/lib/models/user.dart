import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) => _$User((b) => b
  ..identity = null
  ..password = null
  ..uid = -1
  ..update(updates)
  );

  @nullable @BuiltValueField(wireName: 'identity')
  String get identity;
  @nullable @BuiltValueField(wireName: 'password')
  String get password;
  @nullable @BuiltValueField(wireName: 'userid')
  int get uid;
  
  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(
        User.serializer, json.decode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;
}

abstract class UserInfo implements Built<UserInfo, UserInfoBuilder> {
  UserInfo._();

  factory UserInfo([updates(UserInfoBuilder b)]) = _$UserInfo;

  @nullable @BuiltValueField(wireName: 'blacklists')
  String get blacklists;
  @nullable @BuiltValueField(wireName: 'customstatus')
  String get customstatus;
  @nullable @BuiltValueField(wireName: 'email')
  int get email;
  @nullable @BuiltValueField(wireName: 'gender')
  int get gender;
  @nullable @BuiltValueField(wireName: 'invite')
  int get invite;
  @nullable @BuiltValueField(wireName: 'phonenum')
  int get phonenum;
  @nullable @BuiltValueField(wireName: 'regdate')
  String get regdate;
  @nullable @BuiltValueField(wireName: 'sightml')
  String get sightml;
  @nullable @BuiltValueField(wireName: 'uid')
  int get uid;
  @nullable @BuiltValueField(wireName: 'username')
  String get username;
  @nullable @BuiltValueField(wireName: 'me')
  int get me;
  @nullable @BuiltValueField(wireName: 'fansnum')
  int get fansnum;
  @nullable @BuiltValueField(wireName: 'followuidnum')
  int get followuidnum;
  @nullable @BuiltValueField(wireName: 'digestposts')
  int get digestposts;
  @nullable @BuiltValueField(wireName: 'extcredits1')
  int get extcredits1;
  @nullable @BuiltValueField(wireName: 'extcredits2')
  int get extcredits2;
  @nullable @BuiltValueField(wireName: 'extcredits3')
  int get extcredits3;
  @nullable @BuiltValueField(wireName: 'extcredits4')
  int get extcredits4;
  @nullable @BuiltValueField(wireName: 'extcredits5')
  int get extcredits5;
  @nullable @BuiltValueField(wireName: 'extcredits6')
  int get extcredits6;
  @nullable @BuiltValueField(wireName: 'extcredits7')
  int get extcredits7;
  @nullable @BuiltValueField(wireName: 'extcredits8')
  int get extcredits8;
  @nullable @BuiltValueField(wireName: 'followfidnum')
  int get followfidnum;
  @nullable @BuiltValueField(wireName: 'oltime')
  int get oltime;
  @nullable @BuiltValueField(wireName: 'posts')
  int get posts;
  @nullable @BuiltValueField(wireName: 'punchallday')
  int get punchallday;
  @nullable @BuiltValueField(wireName: 'punchday')
  int get punchday;
  @nullable @BuiltValueField(wireName: 'punchhighestday')
  int get punchhighestday;
  @nullable @BuiltValueField(wireName: 'punchtime')
  int get punchtime;
  @nullable @BuiltValueField(wireName: 'sendphonemessage')
  String get sendphonemessage;
  @nullable @BuiltValueField(wireName: 'threads')
  int get threads;
  @nullable @BuiltValueField(wireName: 'todaypostnum')
  String get todaypostnum;
  @nullable @BuiltValueField(wireName: 'isok')
  bool get isok;

  String toJson() {
    return json.encode(serializers.serializeWith(UserInfo.serializer, this));
  }

  static UserInfo fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserInfo.serializer, json.decode(jsonString));
  }

  static Serializer<UserInfo> get serializer => _$userInfoSerializer;
}