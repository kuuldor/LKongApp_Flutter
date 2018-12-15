import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:lkongapp/models/lkong_jsons/forum_result.dart';

import 'package:lkongapp/models/serializers.dart';
import 'package:lkongapp/models/user.dart';

part 'search_result.g.dart';

abstract class SearchUserResult
    implements Built<SearchUserResult, SearchUserResultBuilder> {
  SearchUserResult._();

  factory SearchUserResult([updates(SearchUserResultBuilder b)]) =>
      _$SearchUserResult((b) => b
        ..tmp = ""
        ..nexttime = 0);

  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<UserInfo> get user;
  String toJson() {
    return json
        .encode(serializers.serializeWith(SearchUserResult.serializer, this));
  }

  static SearchUserResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        SearchUserResult.serializer, json.decode(jsonString));
  }

  static Serializer<SearchUserResult> get serializer =>
      _$searchUserResultSerializer;
}

abstract class SearchForumResult
    implements Built<SearchForumResult, SearchForumResultBuilder> {
  SearchForumResult._();

  factory SearchForumResult([updates(SearchForumResultBuilder b)]) =>
      _$SearchForumResult((b) => b
        ..tmp = ""
        ..nexttime = 0);

  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @BuiltValueField(wireName: 'data')
  BuiltList<ForumInfoResult> get forumInfo;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SearchForumResult.serializer, this));
  }

  static SearchForumResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        SearchForumResult.serializer, json.decode(jsonString));
  }

  static Serializer<SearchForumResult> get serializer =>
      _$searchForumResultSerializer;
}
