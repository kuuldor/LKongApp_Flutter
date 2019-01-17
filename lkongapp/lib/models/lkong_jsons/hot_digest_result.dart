import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'hot_digest_result.g.dart';

abstract class HotDigestResult
    implements Built<HotDigestResult, HotDigestResultBuilder> {
  HotDigestResult._();

  factory HotDigestResult([updates(HotDigestResultBuilder b)]) =
      _$HotDigestResult;

  @BuiltValueField(wireName: 'thread')
  BuiltList<Thread> get thread;
  @BuiltValueField(wireName: 'title')
  String get title;
  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'isok')
  bool get isok;
  String toJson() {
    return json
        .encode(serializers.serializeWith(HotDigestResult.serializer, this));
  }

  static HotDigestResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        HotDigestResult.serializer, json.decode(jsonString));
  }

  static Serializer<HotDigestResult> get serializer =>
      _$hotDigestResultSerializer;
}

abstract class Thread implements Built<Thread, ThreadBuilder> {
  Thread._();

  factory Thread([updates(ThreadBuilder b)]) = _$Thread;

  @BuiltValueField(wireName: 'tid')
  int get tid;
  @BuiltValueField(wireName: 'subject')
  String get subject;
  String toJson() {
    return json.encode(serializers.serializeWith(Thread.serializer, this));
  }

  static Thread fromJson(String jsonString) {
    return serializers.deserializeWith(
        Thread.serializer, json.decode(jsonString));
  }

  static Serializer<Thread> get serializer => _$threadSerializer;
}
