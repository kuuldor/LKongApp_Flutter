import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';

import 'package:lkongapp/models/serializers.dart';

part 'personal_stuff.g.dart';

abstract class NoticeResult
    implements FetchResult<Notice>, Built<NoticeResult, NoticeResultBuilder> {
  NoticeResult._();

  factory NoticeResult([updates(NoticeResultBuilder b)]) = _$NoticeResult;

  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<Notice> get data;
  @BuiltValueField(wireName: 'nochecknew')
  bool get nochecknew;
  String toJson() {
    return json
        .encode(serializers.serializeWith(NoticeResult.serializer, this));
  }

  static NoticeResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        NoticeResult.serializer, json.decode(jsonString));
  }

  static Serializer<NoticeResult> get serializer => _$noticeResultSerializer;
}

abstract class Notice
    implements Identifiable, UserMessage, Built<Notice, NoticeBuilder> {
  Notice._();

  factory Notice([updates(NoticeBuilder b)]) = _$Notice;

  @BuiltValueField(wireName: 'uid')
  int get uid;
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'note')
  String get note;
  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  String toJson() {
    return json.encode(serializers.serializeWith(Notice.serializer, this));
  }

  static Notice fromJson(String jsonString) {
    return serializers.deserializeWith(
        Notice.serializer, json.decode(jsonString));
  }

  static Serializer<Notice> get serializer => _$noticeSerializer;
}

abstract class RatelogResult
    implements
        FetchResult<Ratelog>,
        Built<RatelogResult, RatelogResultBuilder> {
  RatelogResult._();

  factory RatelogResult([updates(RatelogResultBuilder b)]) = _$RatelogResult;

  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<Ratelog> get data;
  @BuiltValueField(wireName: 'nochecknew')
  bool get nochecknew;
  String toJson() {
    return json
        .encode(serializers.serializeWith(RatelogResult.serializer, this));
  }

  static RatelogResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        RatelogResult.serializer, json.decode(jsonString));
  }

  static Serializer<RatelogResult> get serializer => _$ratelogResultSerializer;
}

abstract class Ratelog
    implements Identifiable, UserMessage, Built<Ratelog, RatelogBuilder> {
  Ratelog._();

  factory Ratelog([updates(RatelogBuilder b)]) = _$Ratelog;

  @nullable
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @BuiltValueField(wireName: 'uid')
  int get uid;
  @nullable
  @BuiltValueField(wireName: 'username')
  String get username;
  @nullable
  @BuiltValueField(wireName: 'message')
  String get message;
  @BuiltValueField(wireName: 'extcredits')
  String get extcredits;
  @BuiltValueField(wireName: 'score')
  int get score;
  @BuiltValueField(wireName: 'reason')
  String get reason;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'pid')
  int get pid;
  @BuiltValueField(wireName: 'id')
  String get id;

  String toJson() {
    return json.encode(serializers.serializeWith(Ratelog.serializer, this));
  }

  static Ratelog fromJson(String jsonString) {
    return serializers.deserializeWith(
        Ratelog.serializer, json.decode(jsonString));
  }

  static Serializer<Ratelog> get serializer => _$ratelogSerializer;
}

abstract class UpvoteResult
    implements Built<UpvoteResult, UpvoteResultBuilder> {
  UpvoteResult._();

  factory UpvoteResult([updates(UpvoteResultBuilder b)]) = _$UpvoteResult;

  @BuiltValueField(wireName: 'ratelog')
  Ratelog get ratelog;
  @BuiltValueField(wireName: 'type')
  String get type;
  @BuiltValueField(wireName: 'pid')
  int get pid;
  String toJson() {
    return json
        .encode(serializers.serializeWith(UpvoteResult.serializer, this));
  }

  static UpvoteResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        UpvoteResult.serializer, json.decode(jsonString));
  }

  static Serializer<UpvoteResult> get serializer => _$upvoteResultSerializer;
}

abstract class PrivateMessageResult
    implements
        FetchResult<PrivateMessage>,
        Built<PrivateMessageResult, PrivateMessageResultBuilder> {
  PrivateMessageResult._();

  factory PrivateMessageResult([updates(PrivateMessageResultBuilder b)]) =
      _$PrivateMessageResult;

  @BuiltValueField(wireName: 'tmp')
  String get tmp;
  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<PrivateMessage> get data;
  @BuiltValueField(wireName: 'nochecknew')
  bool get nochecknew;
  String toJson() {
    return json.encode(
        serializers.serializeWith(PrivateMessageResult.serializer, this));
  }

  static PrivateMessageResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        PrivateMessageResult.serializer, json.decode(jsonString));
  }

  static Serializer<PrivateMessageResult> get serializer =>
      _$privateMessageResultSerializer;
}

abstract class PrivateMessage
    implements
        Identifiable,
        UserMessage,
        Built<PrivateMessage, PrivateMessageBuilder> {
  PrivateMessage._();

  factory PrivateMessage([updates(PrivateMessageBuilder b)]) =>
      _$PrivateMessage((b) => b
        ..uid = 0
        ..sortkey = 0
        ..dateline = ""
        ..message = ""
        ..id = ""
        ..msgfromid = 0);

  @BuiltValueField(wireName: 'uid')
  int get uid;
  @nullable
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'sortkey')
  int get sortkey;
  @BuiltValueField(wireName: 'dateline')
  String get dateline;
  @BuiltValueField(wireName: 'message')
  String get message;
  @BuiltValueField(wireName: 'id')
  String get id;
  @nullable
  @BuiltValueField(wireName: 'msgfromid')
  int get msgfromid;
  String toJson() {
    return json
        .encode(serializers.serializeWith(PrivateMessage.serializer, this));
  }

  static PrivateMessage fromJson(String jsonString) {
    return serializers.deserializeWith(
        PrivateMessage.serializer, json.decode(jsonString));
  }

  static Serializer<PrivateMessage> get serializer =>
      _$privateMessageSerializer;
}

abstract class PMSession
    implements FetchResult<PrivateMessage>, Built<PMSession, PMSessionBuilder> {
  PMSession._();

  factory PMSession([updates(PMSessionBuilder b)]) = _$PMSession;

  @nullable
  @BuiltValueField(wireName: 'nexttime')
  int get nexttime;
  @nullable
  @BuiltValueField(wireName: 'curtime')
  int get curtime;
  @BuiltValueField(wireName: 'data')
  BuiltList<PrivateMessage> get data;
  @BuiltValueField(wireName: 'loadtime')
  int get loadtime;
  @BuiltValueField(wireName: 'nochecknew')
  int get nochecknew;
  String toJson() {
    return json.encode(serializers.serializeWith(PMSession.serializer, this));
  }

  static PMSession fromJson(String jsonString) {
    return serializers.deserializeWith(
        PMSession.serializer, json.decode(jsonString));
  }

  static Serializer<PMSession> get serializer => _$pMSessionSerializer;
}
