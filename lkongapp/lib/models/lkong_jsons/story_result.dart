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
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
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
  int get uid;
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

abstract class ForumStoryResult
    implements Built<ForumStoryResult, ForumStoryResultBuilder> {
  ForumStoryResult._();

  factory ForumStoryResult([updates(ForumStoryResultBuilder b)]) =
      _$ForumStoryResult;

  @BuiltValueField(wireName: 'data')
  BuiltList<Thread> get data;
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
        .encode(serializers.serializeWith(ForumStoryResult.serializer, this));
  }

  static ForumStoryResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        ForumStoryResult.serializer, json.decode(jsonString));
  }

  static Serializer<ForumStoryResult> get serializer =>
      _$forumStoryResultSerializer;
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

abstract class StoryInfoResult
    implements Built<StoryInfoResult, StoryInfoResultBuilder> {
  StoryInfoResult._();

  factory StoryInfoResult([updates(StoryInfoResultBuilder b)]) =
      _$StoryInfoResult;

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

  factory Comment([updates(CommentBuilder b)]) = _$Comment;

  @BuiltValueField(wireName: 'fid')
  int get fid;
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
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
  String get authorid;
  @BuiltValueField(wireName: 'isme')
  int get isme;
  @BuiltValueField(wireName: 'notgroup')
  int get notgroup;
  @BuiltValueField(wireName: 'pid')
  String get pid;
  @BuiltValueField(wireName: 'first')
  int get first;
  @BuiltValueField(wireName: 'status')
  int get status;
  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'tsadmin')
  bool get tsadmin;
  @BuiltValueField(wireName: 'isadmin')
  int get isadmin;
  @BuiltValueField(wireName: 'lou')
  int get lou;
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

abstract class Ratelog implements Built<Ratelog, RatelogBuilder> {
  Ratelog._();

  factory Ratelog([updates(RatelogBuilder b)]) = _$Ratelog;

  @BuiltValueField(wireName: '_id')
  BuiltMap<String, String> get id;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'extcredits')
  int get extcredits;
  @BuiltValueField(wireName: 'pid')
  int get pid;
  @BuiltValueField(wireName: 'reason')
  String get reason;
  @BuiltValueField(wireName: 'score')
  int get score;
  @BuiltValueField(wireName: 'uid')
  int get uid;
  @BuiltValueField(wireName: 'username')
  String get username;
  String toJson() {
    return json.encode(serializers.serializeWith(Ratelog.serializer, this));
  }

  static Ratelog fromJson(String jsonString) {
    return serializers.deserializeWith(
        Ratelog.serializer, json.decode(jsonString));
  }

  static Serializer<Ratelog> get serializer => _$ratelogSerializer;
}
