import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';

import 'package:lkongapp/models/serializers.dart';
import 'personal_stuff.dart';
part 'story_result.g.dart';

abstract class StoryListResult
    implements
        FetchResult<Story>,
        Built<StoryListResult, StoryListResultBuilder> {
  StoryListResult._();

  factory StoryListResult([updates(StoryListResultBuilder b)]) =
      _$StoryListResult;

  @BuiltValueField(wireName: 'data')
  BuiltList<Story> get data;
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'tmp')
  String get tmp;

  String toJson() {
    return json
        .encode(serializers.serializeWith(StoryListResult.serializer, this));
  }

  static StoryListResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        StoryListResult.serializer, json.decode(jsonString));
  }

  static Serializer<StoryListResult> get serializer =>
      _$storyListResultSerializer;
}

abstract class Story implements Identifiable, Built<Story, StoryBuilder> {
  Story._();

  factory Story([updates(StoryBuilder b)]) = _$Story;

  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  @BuiltValueField(wireName: 'username')
  String get username;
  @nullable
  @BuiltValueField(wireName: 'digest')
  int get digest;
  @nullable
  @BuiltValueField(wireName: 'closed')
  int get closed;
  @nullable
  @BuiltValueField(wireName: 'uid')
  int get uid;

  @BuiltValueField(wireName: 'id')
  String get id;
  @nullable
  @BuiltValueField(wireName: 'fid')
  int get fid;

  @nullable
  @BuiltValueField(wireName: 'isquote')
  bool get isquote;

  @nullable
  @BuiltValueField(wireName: 'message')
  String get message;
  @nullable
  @BuiltValueField(wireName: 'isthread')
  bool get isthread;
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

  @nullable
  @BuiltValueField(wireName: 'replynum')
  int get replynum;

  String toJson() {
    return json.encode(serializers.serializeWith(Story.serializer, this));
  }

  static Story fromJson(String jsonString) {
    return serializers.deserializeWith(
        Story.serializer, json.decode(jsonString));
  }

  static Serializer<Story> get serializer => _$storySerializer;
}

abstract class StoryInfoResult
    implements Built<StoryInfoResult, StoryInfoResultBuilder> {
  StoryInfoResult._();

  factory StoryInfoResult([updates(StoryInfoResultBuilder b)]) =>
      _$StoryInfoResult((b) => b
        ..fid = 0
        ..tid = 0
        ..subject = ""
        ..views = 0
        ..replies = 0
        ..digest = false
        ..timestamp = 0
        ..authorid = 0
        ..author = ""
        ..dateline = ""
        ..id = ""
        ..isok = true);

  @BuiltValueField(wireName: 'fid')
  int get fid;
  @BuiltValueField(wireName: 'tid')
  int get tid;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  @BuiltValueField(wireName: 'views')
  int get views;
  @BuiltValueField(wireName: 'replies')
  int get replies;
  @nullable
  @BuiltValueField(wireName: 'forumname')
  String get forumname;
  @BuiltValueField(wireName: 'digest')
  bool get digest;
  @BuiltValueField(wireName: 'timestamp')
  int get timestamp;
  @nullable
  @BuiltValueField(wireName: 'uid')
  int get uid;
  @nullable
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'authorid')
  int get authorid;
  @BuiltValueField(wireName: 'author')
  String get author;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'isok')
  bool get isok;
  String toJson() {
    return json
        .encode(serializers.serializeWith(StoryInfoResult.serializer, this));
  }

  static StoryInfoResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        StoryInfoResult.serializer, json.decode(jsonString));
  }

  static Serializer<StoryInfoResult> get serializer =>
      _$storyInfoResultSerializer;
}

abstract class StoryContentResult
    implements Built<StoryContentResult, StoryContentResultBuilder> {
  StoryContentResult._();

  factory StoryContentResult([updates(StoryContentResultBuilder b)]) =
      _$StoryContentResult;

  @nullable
  @BuiltValueField(wireName: 'isfull')
  int get isfull;
  @BuiltValueField(wireName: 'model')
  String get model;
  @BuiltValueField(wireName: 'replies')
  int get replies;
  @BuiltValueField(wireName: 'page')
  int get page;
  @BuiltValueField(wireName: 'data')
  BuiltList<Comment> get comments;
  @BuiltValueField(wireName: 'isend')
  int get isend;
  @BuiltValueField(wireName: 'loadtime')
  int get loadtime;
  @BuiltValueField(wireName: 'tmp')
  String get tmp;

  String toJson() {
    return json
        .encode(serializers.serializeWith(StoryContentResult.serializer, this));
  }

  static StoryContentResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        StoryContentResult.serializer, json.decode(jsonString));
  }

  static Serializer<StoryContentResult> get serializer =>
      _$storyContentResultSerializer;
}

abstract class Comment implements Built<Comment, CommentBuilder> {
  Comment._();

  factory Comment([updates(CommentBuilder b)]) => _$Comment((b) => b
    ..fid = 0
    ..warning = false
    ..warningReason = ""
    ..dateline = ""
    ..message = ""
    ..author = ""
    ..authorid = 0
    ..pid = 0
    ..id = 0
    ..lou = 0
    ..update(updates));

  @BuiltValueField(wireName: 'fid')
  int get fid;
  @BuiltValueField(wireName: 'warning')
  bool get warning;
  @BuiltValueField(wireName: 'warningreason')
  String get warningReason;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'message')
  String get message;
  @BuiltValueField(wireName: 'author')
  String get author;
  @BuiltValueField(wireName: 'authorid')
  int get authorid;
  @BuiltValueField(wireName: 'pid')
  int get pid;
  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'lou')
  int get lou;

  @nullable
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @nullable
  @BuiltValueField(wireName: 'isme')
  int get isme;
  @nullable
  @BuiltValueField(wireName: 'notgroup')
  int get notgroup;
  @nullable
  @BuiltValueField(wireName: 'first')
  int get first;
  @nullable
  @BuiltValueField(wireName: 'status')
  int get status;
  @nullable
  @BuiltValueField(wireName: 'favorite')
  bool get favorite;
  @nullable
  @BuiltValueField(wireName: 'tsadmin')
  bool get tsadmin;
  @nullable
  @BuiltValueField(wireName: 'isadmin')
  int get isadmin;
  @nullable
  @BuiltValueField(wireName: 'tid')
  int get tid;
  @nullable
  @BuiltValueField(wireName: 'ratelog')
  BuiltList<Ratelog> get ratelog;

  String toJson() {
    return json.encode(serializers.serializeWith(Comment.serializer, this));
  }

  static Comment fromJson(String jsonString) {
    return serializers.deserializeWith(
        Comment.serializer, json.decode(jsonString));
  }

  static Serializer<Comment> get serializer => _$commentSerializer;
}
