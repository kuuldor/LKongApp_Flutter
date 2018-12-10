// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AccountSetting.serializer)
      ..add(AccountSettings.serializer)
      ..add(AppConfig.serializer)
      ..add(AppSetting.serializer)
      ..add(AppState.serializer)
      ..add(AppTheme.serializer)
      ..add(AuthState.serializer)
      ..add(Comment.serializer)
      ..add(FollowList.serializer)
      ..add(Forum.serializer)
      ..add(ForumInfoResult.serializer)
      ..add(ForumListResult.serializer)
      ..add(PersistentState.serializer)
      ..add(PunchCardResult.serializer)
      ..add(Ratelog.serializer)
      ..add(SearchForumResult.serializer)
      ..add(SearchUserResult.serializer)
      ..add(Story.serializer)
      ..add(StoryContentResult.serializer)
      ..add(StoryInfoResult.serializer)
      ..add(StoryListResult.serializer)
      ..add(ThemeSetting.serializer)
      ..add(UIState.serializer)
      ..add(User.serializer)
      ..add(UserData.serializer)
      ..add(UserInfo.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AppTheme)]),
          () => new ListBuilder<AppTheme>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Comment)]),
          () => new ListBuilder<Comment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Forum)]),
          () => new ListBuilder<Forum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Forum)]),
          () => new ListBuilder<Forum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ForumInfoResult)]),
          () => new ListBuilder<ForumInfoResult>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Ratelog)]),
          () => new ListBuilder<Ratelog>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Story)]),
          () => new ListBuilder<Story>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(Forum)]),
          () => new MapBuilder<String, Forum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(UserInfo)]),
          () => new ListBuilder<UserInfo>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(AccountSetting)]),
          () => new MapBuilder<int, AccountSetting>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(int), const FullType(User)]),
          () => new MapBuilder<int, User>()))
    .build();
