import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/utils/localization.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/serializers.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  UIState._();

  factory UIState([updates(UIStateBuilder b)]) => _$UIState((b) {
        b
          ..homePageIndex = 0
          ..homeList = (HomeListBuilder()..replace(HomeList()))
          ..update(updates);
      });

  @BuiltValueField(wireName: 'homePageIndex')
  int get homePageIndex;

  HomeList get homeList;

  String toJson() {
    return json.encode(serializers.serializeWith(UIState.serializer, this));
  }

  static UIState fromJson(String jsonString) {
    return serializers.deserializeWith(
        UIState.serializer, json.decode(jsonString));
  }

  static Serializer<UIState> get serializer => _$uIStateSerializer;
}

abstract class HomeList implements Built<HomeList, HomeListBuilder> {
  HomeList._();
  factory HomeList([updates(HomeListBuilder b)]) => _$HomeList((b) => b
    ..loading = false
    ..current = 0
    ..nexttime = 0
    ..update(updates));

  bool get loading;
  int get nexttime;
  int get current;
  BuiltList<Story> get stories;
}
