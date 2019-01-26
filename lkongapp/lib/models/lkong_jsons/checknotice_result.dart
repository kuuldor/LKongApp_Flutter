import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:lkongapp/models/serializers.dart';

part 'checknotice_result.g.dart';

abstract class CheckNoticeResult
    implements Built<CheckNoticeResult, CheckNoticeResultBuilder> {
  CheckNoticeResult._();

  factory CheckNoticeResult([updates(CheckNoticeResultBuilder b)]) =
      _$CheckNoticeResult;

  @nullable
  @BuiltValueField(wireName: 'time')
  int get time;
  @nullable
  @BuiltValueField(wireName: 'notice')
  NewNotice get newNotice;
  @nullable
  @BuiltValueField(wireName: 'ok')
  bool get ok;
  String toJson() {
    return json
        .encode(serializers.serializeWith(CheckNoticeResult.serializer, this));
  }

  static CheckNoticeResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        CheckNoticeResult.serializer, json.decode(jsonString));
  }

  static Serializer<CheckNoticeResult> get serializer =>
      _$checkNoticeResultSerializer;
}

abstract class NewNotice implements Built<NewNotice, NewNoticeBuilder> {
  NewNotice._();

  factory NewNotice([updates(NewNoticeBuilder b)]) = _$NewNotice;

  @nullable
  @BuiltValueField(wireName: 'notice')
  int get notice;
  @nullable
  @BuiltValueField(wireName: 'atme')
  int get atme;
  @nullable
  @BuiltValueField(wireName: 'rate')
  int get rate;
  @nullable
  @BuiltValueField(wireName: 'fans')
  int get fans;
  @nullable
  @BuiltValueField(wireName: 'pm')
  int get pm;

  int get totalCount => (notice ?? 0) + (atme ?? 0) + (rate ?? 0) + (pm ?? 0);
  
  String toJson() {
    return json.encode(serializers.serializeWith(NewNotice.serializer, this));
  }

  static NewNotice fromJson(String jsonString) {
    return serializers.deserializeWith(
        NewNotice.serializer, json.decode(jsonString));
  }

  static Serializer<NewNotice> get serializer => _$newNoticeSerializer;
}
