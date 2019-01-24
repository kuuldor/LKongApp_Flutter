import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:lkongapp/utils/localization.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/serializers.dart';

part 'ui_state.g.dart';

abstract class UIState implements Built<UIState, UIStateBuilder> {
  UIState._();

  factory UIState([updates(UIStateBuilder b)]) => _$UIState((b) {
        b
          ..homePageIndex = 0
          ..atMeScreenType = 0
          ..content.replace(ContentCache())
          ..navigationRoute = "/"
          ..update(updates);
      });

  String get navigationRoute;

  @BuiltValueField(wireName: 'homePageIndex')
  int get homePageIndex;

  int get atMeScreenType;

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
        ..loading = false
        ..forumInfo.replace(ForumLists())
        ..homeList.replace(FetchList<Story>())
        ..searchResult.replace(SearchResult())
        ..update(updates));

  @nullable
  String get lastError;
  @nullable
  bool get loading;
  FetchList<Story> get homeList;
  BuiltMap<int, StoryPageList> get storyRepo;
  ForumLists get forumInfo;
  BuiltMap<int, FetchList<Story>> get forumRepo;
  //Private data for login user
  BuiltMap<int, UserData> get userData;
  SearchResult get searchResult;
  //Public data for all users
  BuiltMap<int, Profile> get profiles;

  BuiltList<HotDigestResult> get hotDigest;
}

abstract class Profile implements Built<Profile, ProfileBuilder> {
  Profile._();
  factory Profile([updates(ProfileBuilder b)]) => _$Profile((b) => b
    ..loading = false
    ..user.replace(UserInfo())
    ..update(updates));

  @nullable
  String get lastError;
  bool get loading;

  UserInfo get user;

  @nullable
  FetchList<Story> get stories;
  @nullable
  SearchUserResult get fans;
  @nullable
  FetchList<Story> get digests;
  @nullable
  SearchUserResult get follows;
  @nullable
  FetchList<Story> get allPosts;
}

abstract class SearchResult
    implements Built<SearchResult, SearchResultBuilder> {
  SearchResult._();
  factory SearchResult([updates(SearchResultBuilder b)]) =>
      _$SearchResult((b) => b
        ..loading = false
        ..searchString = ""
        ..searchType = -1
        ..sortType = -1
        ..update(updates));

  @nullable
  String get lastError;
  bool get loading;
  String get searchString;
  int get searchType;
  int get sortType;
  @nullable
  FetchList<Story> get stories;
  @nullable
  SearchUserResult get users;
  @nullable
  SearchForumResult get forums;
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

abstract class ForumLists implements Built<ForumLists, ForumListsBuilder> {
  ForumLists._();
  factory ForumLists([updates(ForumListsBuilder b)]) => _$ForumLists((b) => b
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
