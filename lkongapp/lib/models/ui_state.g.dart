// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

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

Serializer<UIState> _$uIStateSerializer = new _$UIStateSerializer();

class _$UIStateSerializer implements StructuredSerializer<UIState> {
  @override
  final Iterable<Type> types = const [UIState, _$UIState];
  @override
  final String wireName = 'UIState';

  @override
  Iterable serialize(Serializers serializers, UIState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'navigationRoute',
      serializers.serialize(object.navigationRoute,
          specifiedType: const FullType(String)),
      'homePageIndex',
      serializers.serialize(object.homePageIndex,
          specifiedType: const FullType(int)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(ContentCache)),
    ];

    return result;
  }

  @override
  UIState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UIStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'navigationRoute':
          result.navigationRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'homePageIndex':
          result.homePageIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'content':
          result.content.replace(serializers.deserialize(value,
              specifiedType: const FullType(ContentCache)) as ContentCache);
          break;
      }
    }

    return result.build();
  }
}

class _$UIState extends UIState {
  @override
  final String navigationRoute;
  @override
  final int homePageIndex;
  @override
  final ContentCache content;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._({this.navigationRoute, this.homePageIndex, this.content})
      : super._() {
    if (navigationRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'navigationRoute');
    }
    if (homePageIndex == null) {
      throw new BuiltValueNullFieldError('UIState', 'homePageIndex');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('UIState', 'content');
    }
  }

  @override
  UIState rebuild(void updates(UIStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UIStateBuilder toBuilder() => new UIStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UIState &&
        navigationRoute == other.navigationRoute &&
        homePageIndex == other.homePageIndex &&
        content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, navigationRoute.hashCode), homePageIndex.hashCode),
        content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('navigationRoute', navigationRoute)
          ..add('homePageIndex', homePageIndex)
          ..add('content', content))
        .toString();
  }
}

class UIStateBuilder implements Builder<UIState, UIStateBuilder> {
  _$UIState _$v;

  String _navigationRoute;
  String get navigationRoute => _$this._navigationRoute;
  set navigationRoute(String navigationRoute) =>
      _$this._navigationRoute = navigationRoute;

  int _homePageIndex;
  int get homePageIndex => _$this._homePageIndex;
  set homePageIndex(int homePageIndex) => _$this._homePageIndex = homePageIndex;

  ContentCacheBuilder _content;
  ContentCacheBuilder get content =>
      _$this._content ??= new ContentCacheBuilder();
  set content(ContentCacheBuilder content) => _$this._content = content;

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _navigationRoute = _$v.navigationRoute;
      _homePageIndex = _$v.homePageIndex;
      _content = _$v.content?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UIState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UIState;
  }

  @override
  void update(void updates(UIStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UIState build() {
    _$UIState _$result;
    try {
      _$result = _$v ??
          new _$UIState._(
              navigationRoute: navigationRoute,
              homePageIndex: homePageIndex,
              content: content.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'content';
        content.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UIState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ContentCache extends ContentCache {
  @override
  final String lastError;
  @override
  final HomeList homeList;
  @override
  final BuiltMap<int, StoryPageList> storyRepo;
  @override
  final ForumInfo forumRepo;

  factory _$ContentCache([void updates(ContentCacheBuilder b)]) =>
      (new ContentCacheBuilder()..update(updates)).build();

  _$ContentCache._(
      {this.lastError, this.homeList, this.storyRepo, this.forumRepo})
      : super._() {
    if (homeList == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'homeList');
    }
    if (storyRepo == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'storyRepo');
    }
    if (forumRepo == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'forumRepo');
    }
  }

  @override
  ContentCache rebuild(void updates(ContentCacheBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ContentCacheBuilder toBuilder() => new ContentCacheBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContentCache &&
        lastError == other.lastError &&
        homeList == other.homeList &&
        storyRepo == other.storyRepo &&
        forumRepo == other.forumRepo;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, lastError.hashCode), homeList.hashCode),
            storyRepo.hashCode),
        forumRepo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ContentCache')
          ..add('lastError', lastError)
          ..add('homeList', homeList)
          ..add('storyRepo', storyRepo)
          ..add('forumRepo', forumRepo))
        .toString();
  }
}

class ContentCacheBuilder
    implements Builder<ContentCache, ContentCacheBuilder> {
  _$ContentCache _$v;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  HomeListBuilder _homeList;
  HomeListBuilder get homeList => _$this._homeList ??= new HomeListBuilder();
  set homeList(HomeListBuilder homeList) => _$this._homeList = homeList;

  MapBuilder<int, StoryPageList> _storyRepo;
  MapBuilder<int, StoryPageList> get storyRepo =>
      _$this._storyRepo ??= new MapBuilder<int, StoryPageList>();
  set storyRepo(MapBuilder<int, StoryPageList> storyRepo) =>
      _$this._storyRepo = storyRepo;

  ForumInfoBuilder _forumRepo;
  ForumInfoBuilder get forumRepo =>
      _$this._forumRepo ??= new ForumInfoBuilder();
  set forumRepo(ForumInfoBuilder forumRepo) => _$this._forumRepo = forumRepo;

  ContentCacheBuilder();

  ContentCacheBuilder get _$this {
    if (_$v != null) {
      _lastError = _$v.lastError;
      _homeList = _$v.homeList?.toBuilder();
      _storyRepo = _$v.storyRepo?.toBuilder();
      _forumRepo = _$v.forumRepo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContentCache other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ContentCache;
  }

  @override
  void update(void updates(ContentCacheBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ContentCache build() {
    _$ContentCache _$result;
    try {
      _$result = _$v ??
          new _$ContentCache._(
              lastError: lastError,
              homeList: homeList.build(),
              storyRepo: storyRepo.build(),
              forumRepo: forumRepo.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'homeList';
        homeList.build();
        _$failedField = 'storyRepo';
        storyRepo.build();
        _$failedField = 'forumRepo';
        forumRepo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ContentCache', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$HomeList extends HomeList {
  @override
  final int nexttime;
  @override
  final int current;
  @override
  final BuiltList<Story> stories;

  factory _$HomeList([void updates(HomeListBuilder b)]) =>
      (new HomeListBuilder()..update(updates)).build();

  _$HomeList._({this.nexttime, this.current, this.stories}) : super._() {
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('HomeList', 'nexttime');
    }
    if (current == null) {
      throw new BuiltValueNullFieldError('HomeList', 'current');
    }
    if (stories == null) {
      throw new BuiltValueNullFieldError('HomeList', 'stories');
    }
  }

  @override
  HomeList rebuild(void updates(HomeListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeListBuilder toBuilder() => new HomeListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeList &&
        nexttime == other.nexttime &&
        current == other.current &&
        stories == other.stories;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, nexttime.hashCode), current.hashCode), stories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeList')
          ..add('nexttime', nexttime)
          ..add('current', current)
          ..add('stories', stories))
        .toString();
  }
}

class HomeListBuilder implements Builder<HomeList, HomeListBuilder> {
  _$HomeList _$v;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _current;
  int get current => _$this._current;
  set current(int current) => _$this._current = current;

  ListBuilder<Story> _stories;
  ListBuilder<Story> get stories =>
      _$this._stories ??= new ListBuilder<Story>();
  set stories(ListBuilder<Story> stories) => _$this._stories = stories;

  HomeListBuilder();

  HomeListBuilder get _$this {
    if (_$v != null) {
      _nexttime = _$v.nexttime;
      _current = _$v.current;
      _stories = _$v.stories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomeList;
  }

  @override
  void update(void updates(HomeListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeList build() {
    _$HomeList _$result;
    try {
      _$result = _$v ??
          new _$HomeList._(
              nexttime: nexttime, current: current, stories: stories.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stories';
        stories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomeList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StoryPageList extends StoryPageList {
  @override
  final StoryInfoResult storyInfo;
  @override
  final BuiltMap<int, StoryPage> pages;

  factory _$StoryPageList([void updates(StoryPageListBuilder b)]) =>
      (new StoryPageListBuilder()..update(updates)).build();

  _$StoryPageList._({this.storyInfo, this.pages}) : super._() {
    if (pages == null) {
      throw new BuiltValueNullFieldError('StoryPageList', 'pages');
    }
  }

  @override
  StoryPageList rebuild(void updates(StoryPageListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryPageListBuilder toBuilder() => new StoryPageListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryPageList &&
        storyInfo == other.storyInfo &&
        pages == other.pages;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, storyInfo.hashCode), pages.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryPageList')
          ..add('storyInfo', storyInfo)
          ..add('pages', pages))
        .toString();
  }
}

class StoryPageListBuilder
    implements Builder<StoryPageList, StoryPageListBuilder> {
  _$StoryPageList _$v;

  StoryInfoResultBuilder _storyInfo;
  StoryInfoResultBuilder get storyInfo =>
      _$this._storyInfo ??= new StoryInfoResultBuilder();
  set storyInfo(StoryInfoResultBuilder storyInfo) =>
      _$this._storyInfo = storyInfo;

  MapBuilder<int, StoryPage> _pages;
  MapBuilder<int, StoryPage> get pages =>
      _$this._pages ??= new MapBuilder<int, StoryPage>();
  set pages(MapBuilder<int, StoryPage> pages) => _$this._pages = pages;

  StoryPageListBuilder();

  StoryPageListBuilder get _$this {
    if (_$v != null) {
      _storyInfo = _$v.storyInfo?.toBuilder();
      _pages = _$v.pages?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryPageList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryPageList;
  }

  @override
  void update(void updates(StoryPageListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryPageList build() {
    _$StoryPageList _$result;
    try {
      _$result = _$v ??
          new _$StoryPageList._(
              storyInfo: _storyInfo?.build(), pages: pages.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'storyInfo';
        _storyInfo?.build();
        _$failedField = 'pages';
        pages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StoryPageList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StoryPage extends StoryPage {
  @override
  final BuiltList<Comment> comments;

  factory _$StoryPage([void updates(StoryPageBuilder b)]) =>
      (new StoryPageBuilder()..update(updates)).build();

  _$StoryPage._({this.comments}) : super._() {
    if (comments == null) {
      throw new BuiltValueNullFieldError('StoryPage', 'comments');
    }
  }

  @override
  StoryPage rebuild(void updates(StoryPageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryPageBuilder toBuilder() => new StoryPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryPage && comments == other.comments;
  }

  @override
  int get hashCode {
    return $jf($jc(0, comments.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryPage')..add('comments', comments))
        .toString();
  }
}

class StoryPageBuilder implements Builder<StoryPage, StoryPageBuilder> {
  _$StoryPage _$v;

  ListBuilder<Comment> _comments;
  ListBuilder<Comment> get comments =>
      _$this._comments ??= new ListBuilder<Comment>();
  set comments(ListBuilder<Comment> comments) => _$this._comments = comments;

  StoryPageBuilder();

  StoryPageBuilder get _$this {
    if (_$v != null) {
      _comments = _$v.comments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryPage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryPage;
  }

  @override
  void update(void updates(StoryPageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryPage build() {
    _$StoryPage _$result;
    try {
      _$result = _$v ?? new _$StoryPage._(comments: comments.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'comments';
        comments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StoryPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ForumInfo extends ForumInfo {
  @override
  final BuiltList<Forum> forums;
  @override
  final BuiltList<Forum> sysplanes;
  @override
  final BuiltList<Forum> planes;
  @override
  final BuiltMap<int, ForumInfoResult> info;

  factory _$ForumInfo([void updates(ForumInfoBuilder b)]) =>
      (new ForumInfoBuilder()..update(updates)).build();

  _$ForumInfo._({this.forums, this.sysplanes, this.planes, this.info})
      : super._() {
    if (forums == null) {
      throw new BuiltValueNullFieldError('ForumInfo', 'forums');
    }
    if (sysplanes == null) {
      throw new BuiltValueNullFieldError('ForumInfo', 'sysplanes');
    }
    if (planes == null) {
      throw new BuiltValueNullFieldError('ForumInfo', 'planes');
    }
    if (info == null) {
      throw new BuiltValueNullFieldError('ForumInfo', 'info');
    }
  }

  @override
  ForumInfo rebuild(void updates(ForumInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumInfoBuilder toBuilder() => new ForumInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForumInfo &&
        forums == other.forums &&
        sysplanes == other.sysplanes &&
        planes == other.planes &&
        info == other.info;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, forums.hashCode), sysplanes.hashCode), planes.hashCode),
        info.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForumInfo')
          ..add('forums', forums)
          ..add('sysplanes', sysplanes)
          ..add('planes', planes)
          ..add('info', info))
        .toString();
  }
}

class ForumInfoBuilder implements Builder<ForumInfo, ForumInfoBuilder> {
  _$ForumInfo _$v;

  ListBuilder<Forum> _forums;
  ListBuilder<Forum> get forums => _$this._forums ??= new ListBuilder<Forum>();
  set forums(ListBuilder<Forum> forums) => _$this._forums = forums;

  ListBuilder<Forum> _sysplanes;
  ListBuilder<Forum> get sysplanes =>
      _$this._sysplanes ??= new ListBuilder<Forum>();
  set sysplanes(ListBuilder<Forum> sysplanes) => _$this._sysplanes = sysplanes;

  ListBuilder<Forum> _planes;
  ListBuilder<Forum> get planes => _$this._planes ??= new ListBuilder<Forum>();
  set planes(ListBuilder<Forum> planes) => _$this._planes = planes;

  MapBuilder<int, ForumInfoResult> _info;
  MapBuilder<int, ForumInfoResult> get info =>
      _$this._info ??= new MapBuilder<int, ForumInfoResult>();
  set info(MapBuilder<int, ForumInfoResult> info) => _$this._info = info;

  ForumInfoBuilder();

  ForumInfoBuilder get _$this {
    if (_$v != null) {
      _forums = _$v.forums?.toBuilder();
      _sysplanes = _$v.sysplanes?.toBuilder();
      _planes = _$v.planes?.toBuilder();
      _info = _$v.info?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForumInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ForumInfo;
  }

  @override
  void update(void updates(ForumInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ForumInfo build() {
    _$ForumInfo _$result;
    try {
      _$result = _$v ??
          new _$ForumInfo._(
              forums: forums.build(),
              sysplanes: sysplanes.build(),
              planes: planes.build(),
              info: info.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'forums';
        forums.build();
        _$failedField = 'sysplanes';
        sysplanes.build();
        _$failedField = 'planes';
        planes.build();
        _$failedField = 'info';
        info.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ForumInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
