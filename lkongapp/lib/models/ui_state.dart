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
          ..content = (ContentCacheBuilder()..replace(ContentCache()))
          ..navigationRoute = "/"
          ..update(updates);
      });

  String get navigationRoute;

  @BuiltValueField(wireName: 'homePageIndex')
  int get homePageIndex;

  ContentCache get content;

  String toJson() {
    return json.encode(serializers.serializeWith(UIState.serializer, this));
  }

  static UIState fromJson(String jsonString) {
    return serializers.deserializeWith(
        UIState.serializer, json.decode(jsonString));
  }

  static Serializer<UIState> get serializer => _$uIStateSerializer;
}

abstract class ContentCache
    implements Built<ContentCache, ContentCacheBuilder> {
  ContentCache._();
  factory ContentCache([updates(ContentCacheBuilder b)]) =>
      _$ContentCache((b) => b
        ..forumInfo.replace(ForumInfo())
        ..homeList.replace(StoryFetchList())
        ..update(updates));

  @nullable
  String get lastError;
  StoryFetchList get homeList;
  BuiltMap<int, StoryPageList> get storyRepo;
  ForumInfo get forumInfo;
  BuiltMap<int, StoryFetchList> get forumRepo;
}

abstract class StoryFetchList
    implements Built<StoryFetchList, StoryFetchListBuilder> {
  StoryFetchList._();
  factory StoryFetchList([updates(StoryFetchListBuilder b)]) =>
      _$StoryFetchList((b) => b
        ..loading = false
        ..current = 0
        ..nexttime = 0
        ..newcount = 0
        ..update(updates));

  bool get loading;
  int get nexttime;
  int get current;
  int get newcount;

  @nullable
  String get lastError;

  BuiltList<Story> get stories;
}

abstract class StoryPageList
    implements Built<StoryPageList, StoryPageListBuilder> {
  @nullable
  StoryInfoResult get storyInfo;
  bool get loading;
  BuiltMap<int, StoryPage> get pages;

  @nullable
  String get lastError;

  StoryPageList._();
  factory StoryPageList([updates(StoryPageListBuilder b)]) =>
      _$StoryPageList((b) => b
        ..loading = false
        ..update(updates));
}

abstract class StoryPage implements Built<StoryPage, StoryPageBuilder> {
  StoryPage._();
  factory StoryPage([updates(StoryPageBuilder b)]) =>
      _$StoryPage((b) => b..update(updates));
  BuiltList<Comment> get comments;
}

abstract class ForumInfo implements Built<ForumInfo, ForumInfoBuilder> {
  ForumInfo._();
  factory ForumInfo([updates(ForumInfoBuilder b)]) => _$ForumInfo((b) => b
    ..loading = false
    ..update(updates));

  bool get loading;
  @nullable
  String get lastError;
  BuiltList<Forum> get forums;
  BuiltList<Forum> get sysplanes;
  BuiltList<Forum> get planes;
  BuiltMap<int, ForumInfoResult> get info;
}
