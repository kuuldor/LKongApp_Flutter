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
      ..add(Forum.serializer)
      ..add(ForumInfoResult.serializer)
      ..add(ForumListResult.serializer)
      ..add(ForumStoryResult.serializer)
      ..add(HomeListResult.serializer)
      ..add(Ratelog.serializer)
      ..add(Story.serializer)
      ..add(StoryContentResult.serializer)
      ..add(StoryInfoResult.serializer)
      ..add(ThemeSetting.serializer)
      ..add(Thread.serializer)
      ..add(UIState.serializer)
      ..add(User.serializer)
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
          const FullType(BuiltList, const [const FullType(Ratelog)]),
          () => new ListBuilder<Ratelog>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Story)]),
          () => new ListBuilder<Story>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(Forum)]),
          () => new MapBuilder<String, Forum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Thread)]),
          () => new ListBuilder<Thread>())
      ..addBuilderFactory(
          const FullType(
              BuiltMap, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>())
      ..addBuilderFactory(
          const FullType(Map,
              const [const FullType(String), const FullType(AccountSetting)]),
          () => new MapBuilder<String, AccountSetting>())
      ..addBuilderFactory(
          const FullType(
              Map, const [const FullType(String), const FullType(String)]),
          () => new MapBuilder<String, String>()))
    .build();
