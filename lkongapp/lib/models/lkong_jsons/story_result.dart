import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'story_result.g.dart';

abstract class HomeListResult  
    implements Built<HomeListResult, HomeListResultBuilder> {
  HomeListResult._();

  factory HomeListResult([updates(HomeListResultBuilder b)]) = _$HomeListResult;

  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<Story> get data;
  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  String toJson() {
    return json
        .encode(serializers.serializeWith(HomeListResult.serializer, this));
  }

  static HomeListResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        HomeListResult.serializer, json.decode(jsonString));
  }

  static Serializer<HomeListResult> get serializer =>
      _$homeListResultSerializer;
}

abstract class Story implements Built<Story, StoryBuilder> {
  Story._();

  factory Story([updates(StoryBuilder b)]) = _$Story;

  @BuiltValueField(wireName: 'isquote')
  bool get isquote;
  @BuiltValueField(wireName: 'uid')
  String get uid;
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'message')
  String get message;
  @BuiltValueField(wireName: 'isthread')
  bool get isthread;
  @nullable
  @BuiltValueField(wireName: 'tid')
  String get tid;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  @nullable
  @BuiltValueField(wireName: 't_author')
  String get tAuthor;
  @nullable
  @BuiltValueField(wireName: 't_authorid')
  int get tAuthorid;
  @nullable
  @BuiltValueField(wireName: 't_replynum')
  int get tReplynum;
  @BuiltValueField(wireName: 'id')
  String get id;
  @nullable
  @BuiltValueField(wireName: 'replynum')
  int get replynum;
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  String toJson() {
    return json.encode(serializers.serializeWith(Story.serializer, this));
  }

  static Story fromJson(String jsonString) {
    return serializers.deserializeWith(
        Story.serializer, json.decode(jsonString));
  }

  static Serializer<Story> get serializer => _$storySerializer;
}

abstract class ForumListResult
    implements Built<ForumListResult, ForumListResultBuilder> {
  ForumListResult._();

  factory ForumListResult([updates(ForumListResultBuilder b)]) =
      _$ForumListResult;

  @BuiltValueField(wireName: 'data')
  BuiltList<Thread> get data;
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'tmp')
  String get tmp;
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

abstract class Thread implements Built<Thread, ThreadBuilder> {
  Thread._();

  factory Thread([updates(ThreadBuilder b)]) = _$Thread;

  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'digest')
  int get digest;
  @BuiltValueField(wireName: 'closed')
  int get closed;
  @BuiltValueField(wireName: 'uid')
  int get uid;
  @BuiltValueField(wireName: 'replynum')
  int get replynum;
  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'fid')
  int get fid;
  String toJson() {
    return json.encode(serializers.serializeWith(Thread.serializer, this));
  }

  static Thread fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thread.serializer, json.decode(jsonString));
  }

  static Serializer<Thread> get serializer => _$threadSerializer;
}
