import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/models/serializers.dart';

part 'follow_list.g.dart';

abstract class FollowList implements Built<FollowList, FollowListBuilder> {
  FollowList._();

  factory FollowList([updates(FollowListBuilder b)]) = _$FollowList;

  @BuiltValueField(wireName: 'uid')
  BuiltList<String> get uid;
  @BuiltValueField(wireName: 'fid')
  BuiltList<String> get fid;
  @BuiltValueField(wireName: 'tid')
  BuiltList<String> get tid;
  @BuiltValueField(wireName: 'black')
  BuiltList<String> get black;
  String toJson() {
    return json.encode(serializers.serializeWith(FollowList.serializer, this));
  }

  static FollowList fromJson(String jsonString) {
    return serializers.deserializeWith(
        FollowList.serializer, json.decode(jsonString));
  }

  static Serializer<FollowList> get serializer => _$followListSerializer;
}

abstract class PunchCardResult
    implements Built<PunchCardResult, PunchCardResultBuilder> {
  PunchCardResult._();

  factory PunchCardResult([updates(PunchCardResultBuilder b)]) =>
      _$PunchCardResult((b) {
        b
          ..punchtime = 0
          ..punchday = 0
          ..update(updates);
      });

  @BuiltValueField(wireName: 'punchtime')
  int get punchtime;
  @BuiltValueField(wireName: 'punchday')
  int get punchday;
  String toJson() {
    return json
        .encode(serializers.serializeWith(PunchCardResult.serializer, this));
  }

  static PunchCardResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        PunchCardResult.serializer, json.decode(jsonString));
  }

  static Serializer<PunchCardResult> get serializer =>
      _$punchCardResultSerializer;
}
