import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'forum_result.g.dart';

abstract class ForumListResult
    implements Built<ForumListResult, ForumListResultBuilder> {
  ForumListResult._();

  factory ForumListResult([updates(ForumListResultBuilder b)]) =
      _$ForumListResult;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'isok')
  bool get isok;
  @BuiltValueField(wireName: 'forumlist')
  BuiltList<Forum> get forumList;
  @BuiltValueField(wireName: 'sysweimian')
  BuiltList<Forum> get sysweimian;
  String toJson() {
    return json
        .encode(serializers.serializeWith(ForumListResult.serializer, this));
  }

  static ForumListResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        ForumListResult.serializer, json.decode(jsonString));
  }

  static Serializer<ForumListResult> get serializer =>
      _$forumListResultSerializer;
}

abstract class Forum implements Built<Forum, ForumBuilder> {
  Forum._();

  factory Forum([updates(ForumBuilder b)]) => _$Forum((b) => b..fid = 0);

  @nullable
  @BuiltValueField(wireName: 'fid')
  int get fid;
  @nullable
  @BuiltValueField(wireName: 'name')
  String get name;

  String toJson() {
    return json.encode(serializers.serializeWith(Forum.serializer, this));
  }

  static Forum fromJson(String jsonString) {
    return serializers.deserializeWith(
        Forum.serializer, json.decode(jsonString));
  }

  static Serializer<Forum> get serializer => _$forumSerializer;
}

abstract class ForumInfoResult
    implements Built<ForumInfoResult, ForumInfoResultBuilder> {
  ForumInfoResult._();

  factory ForumInfoResult([updates(ForumInfoResultBuilder b)]) =
      _$ForumInfoResult;

  @nullable
  @BuiltValueField(wireName: 'type')
  String get type;
  @BuiltValueField(wireName: 'fid')
  int get fid;
  @BuiltValueField(wireName: 'name')
  String get name;
  @nullable
  @BuiltValueField(wireName: 'description')
  String get description;
  @nullable
  @BuiltValueField(wireName: 'status')
  String get status;
  @nullable
  @BuiltValueField(wireName: 'sortbydateline')
  int get sortbydateline;
  @nullable
  @BuiltValueField(wireName: 'threads')
  String get threads;
  @nullable
  @BuiltValueField(wireName: 'todayposts')
  int get todayposts;
  @BuiltValueField(wireName: 'fansnum')
  int get fansnum;
  @nullable
  @BuiltValueField(wireName: 'blackboard')
  String get blackboard;
  @nullable
  @BuiltValueField(wireName: 'moderators')
  BuiltList<String> get moderators;
  @nullable
  @BuiltValueField(wireName: 'verify')
  bool get verify;
  @nullable
  @BuiltValueField(wireName: 'verifymessage')
  String get verifymessage;
  @nullable
  @BuiltValueField(wireName: 'isadmin')
  int get isadmin;
  @nullable
  @BuiltValueField(wireName: 'linktitle')
  String get linktitle;
  @nullable
  @BuiltValueField(wireName: 'links')
  BuiltMap<String, Forum> get links;
  @BuiltValueField(wireName: 'id')
  String get id;
  @nullable
  @BuiltValueField(wireName: 'isok')
  bool get isok;
  @nullable
  @BuiltValueField(wireName: 'jointype')
  String get jointype;
  @nullable
  @BuiltValueField(wireName: 'membernum')
  int get membernum;
  @nullable
  @BuiltValueField(wireName: 'ismem')
  int get ismem;
  @nullable
  @BuiltValueField(wireName: 'isgroup')
  bool get isgroup;

  String toJson() {
    return json
        .encode(serializers.serializeWith(ForumInfoResult.serializer, this));
  }

  static ForumInfoResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        ForumInfoResult.serializer, json.decode(jsonString));
  }

  static Serializer<ForumInfoResult> get serializer =>
      _$forumInfoResultSerializer;
}
