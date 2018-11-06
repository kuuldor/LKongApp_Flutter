import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'story_result.g.dart';

abstract class StoryResult implements Built<StoryResult, StoryResultBuilder> {
  StoryResult._();

  factory StoryResult([updates(StoryResultBuilder b)]) = _$StoryResult;

  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<Thread> get data;
  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  String toJson() {
    return json.encode(serializers.serializeWith(StoryResult.serializer, this));
  }

  static StoryResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        StoryResult.serializer, json.decode(jsonString));
  }

  static Serializer<StoryResult> get serializer => _$storyResultSerializer;
}

abstract class Thread implements Built<Thread, ThreadBuilder> {
  Thread._();

  factory Thread([updates(ThreadBuilder b)]) = _$Thread;

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
  @BuiltValueField(wireName: 'replynum')
  int get replyNum;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  @nullable
  @BuiltValueField(wireName: 'fid')
  int get fid;
  @nullable
  @BuiltValueField(wireName: 'forumname')
  String get forumName;
  @nullable
  @BuiltValueField(wireName: 'author')
  String get author;
  @nullable
  @BuiltValueField(wireName: 'authorid')
  int get authorid;
  @nullable
  @BuiltValueField(wireName: 'tid')
  String get tid;
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
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  String toJson() {
    return json.encode(serializers.serializeWith(Thread.serializer, this));
  }

  static Thread fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thread.serializer, json.decode(jsonString));
  }

  static Serializer<Thread> get serializer => _$threadSerializer;
}
