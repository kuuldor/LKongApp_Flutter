// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
  final StoryFetchList homeList;
  @override
  final BuiltMap<int, StoryPageList> storyRepo;
  @override
  final ForumLists forumInfo;
  @override
  final BuiltMap<int, StoryFetchList> forumRepo;
  @override
  final BuiltMap<int, UserData> userData;
  @override
  final SearchResult searchResult;
  @override
  final BuiltMap<int, Profile> profiles;

  factory _$ContentCache([void updates(ContentCacheBuilder b)]) =>
      (new ContentCacheBuilder()..update(updates)).build();

  _$ContentCache._(
      {this.lastError,
      this.homeList,
      this.storyRepo,
      this.forumInfo,
      this.forumRepo,
      this.userData,
      this.searchResult,
      this.profiles})
      : super._() {
    if (homeList == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'homeList');
    }
    if (storyRepo == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'storyRepo');
    }
    if (forumInfo == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'forumInfo');
    }
    if (forumRepo == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'forumRepo');
    }
    if (userData == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'userData');
    }
    if (searchResult == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'searchResult');
    }
    if (profiles == null) {
      throw new BuiltValueNullFieldError('ContentCache', 'profiles');
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
        forumInfo == other.forumInfo &&
        forumRepo == other.forumRepo &&
        userData == other.userData &&
        searchResult == other.searchResult &&
        profiles == other.profiles;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, lastError.hashCode), homeList.hashCode),
                            storyRepo.hashCode),
                        forumInfo.hashCode),
                    forumRepo.hashCode),
                userData.hashCode),
            searchResult.hashCode),
        profiles.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ContentCache')
          ..add('lastError', lastError)
          ..add('homeList', homeList)
          ..add('storyRepo', storyRepo)
          ..add('forumInfo', forumInfo)
          ..add('forumRepo', forumRepo)
          ..add('userData', userData)
          ..add('searchResult', searchResult)
          ..add('profiles', profiles))
        .toString();
  }
}

class ContentCacheBuilder
    implements Builder<ContentCache, ContentCacheBuilder> {
  _$ContentCache _$v;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  StoryFetchListBuilder _homeList;
  StoryFetchListBuilder get homeList =>
      _$this._homeList ??= new StoryFetchListBuilder();
  set homeList(StoryFetchListBuilder homeList) => _$this._homeList = homeList;

  MapBuilder<int, StoryPageList> _storyRepo;
  MapBuilder<int, StoryPageList> get storyRepo =>
      _$this._storyRepo ??= new MapBuilder<int, StoryPageList>();
  set storyRepo(MapBuilder<int, StoryPageList> storyRepo) =>
      _$this._storyRepo = storyRepo;

  ForumListsBuilder _forumInfo;
  ForumListsBuilder get forumInfo =>
      _$this._forumInfo ??= new ForumListsBuilder();
  set forumInfo(ForumListsBuilder forumInfo) => _$this._forumInfo = forumInfo;

  MapBuilder<int, StoryFetchList> _forumRepo;
  MapBuilder<int, StoryFetchList> get forumRepo =>
      _$this._forumRepo ??= new MapBuilder<int, StoryFetchList>();
  set forumRepo(MapBuilder<int, StoryFetchList> forumRepo) =>
      _$this._forumRepo = forumRepo;

  MapBuilder<int, UserData> _userData;
  MapBuilder<int, UserData> get userData =>
      _$this._userData ??= new MapBuilder<int, UserData>();
  set userData(MapBuilder<int, UserData> userData) =>
      _$this._userData = userData;

  SearchResultBuilder _searchResult;
  SearchResultBuilder get searchResult =>
      _$this._searchResult ??= new SearchResultBuilder();
  set searchResult(SearchResultBuilder searchResult) =>
      _$this._searchResult = searchResult;

  MapBuilder<int, Profile> _profiles;
  MapBuilder<int, Profile> get profiles =>
      _$this._profiles ??= new MapBuilder<int, Profile>();
  set profiles(MapBuilder<int, Profile> profiles) =>
      _$this._profiles = profiles;

  ContentCacheBuilder();

  ContentCacheBuilder get _$this {
    if (_$v != null) {
      _lastError = _$v.lastError;
      _homeList = _$v.homeList?.toBuilder();
      _storyRepo = _$v.storyRepo?.toBuilder();
      _forumInfo = _$v.forumInfo?.toBuilder();
      _forumRepo = _$v.forumRepo?.toBuilder();
      _userData = _$v.userData?.toBuilder();
      _searchResult = _$v.searchResult?.toBuilder();
      _profiles = _$v.profiles?.toBuilder();
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
              forumInfo: forumInfo.build(),
              forumRepo: forumRepo.build(),
              userData: userData.build(),
              searchResult: searchResult.build(),
              profiles: profiles.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'homeList';
        homeList.build();
        _$failedField = 'storyRepo';
        storyRepo.build();
        _$failedField = 'forumInfo';
        forumInfo.build();
        _$failedField = 'forumRepo';
        forumRepo.build();
        _$failedField = 'userData';
        userData.build();
        _$failedField = 'searchResult';
        searchResult.build();
        _$failedField = 'profiles';
        profiles.build();
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

class _$Profile extends Profile {
  @override
  final String lastError;
  @override
  final bool loading;
  @override
  final UserInfo user;
  @override
  final StoryFetchList stories;
  @override
  final SearchUserResult fans;
  @override
  final StoryFetchList digests;
  @override
  final SearchUserResult follows;

  factory _$Profile([void updates(ProfileBuilder b)]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._(
      {this.lastError,
      this.loading,
      this.user,
      this.stories,
      this.fans,
      this.digests,
      this.follows})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('Profile', 'loading');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('Profile', 'user');
    }
  }

  @override
  Profile rebuild(void updates(ProfileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => new ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        lastError == other.lastError &&
        loading == other.loading &&
        user == other.user &&
        stories == other.stories &&
        fans == other.fans &&
        digests == other.digests &&
        follows == other.follows;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, lastError.hashCode), loading.hashCode),
                        user.hashCode),
                    stories.hashCode),
                fans.hashCode),
            digests.hashCode),
        follows.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('lastError', lastError)
          ..add('loading', loading)
          ..add('user', user)
          ..add('stories', stories)
          ..add('fans', fans)
          ..add('digests', digests)
          ..add('follows', follows))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  UserInfoBuilder _user;
  UserInfoBuilder get user => _$this._user ??= new UserInfoBuilder();
  set user(UserInfoBuilder user) => _$this._user = user;

  StoryFetchListBuilder _stories;
  StoryFetchListBuilder get stories =>
      _$this._stories ??= new StoryFetchListBuilder();
  set stories(StoryFetchListBuilder stories) => _$this._stories = stories;

  SearchUserResultBuilder _fans;
  SearchUserResultBuilder get fans =>
      _$this._fans ??= new SearchUserResultBuilder();
  set fans(SearchUserResultBuilder fans) => _$this._fans = fans;

  StoryFetchListBuilder _digests;
  StoryFetchListBuilder get digests =>
      _$this._digests ??= new StoryFetchListBuilder();
  set digests(StoryFetchListBuilder digests) => _$this._digests = digests;

  SearchUserResultBuilder _follows;
  SearchUserResultBuilder get follows =>
      _$this._follows ??= new SearchUserResultBuilder();
  set follows(SearchUserResultBuilder follows) => _$this._follows = follows;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _lastError = _$v.lastError;
      _loading = _$v.loading;
      _user = _$v.user?.toBuilder();
      _stories = _$v.stories?.toBuilder();
      _fans = _$v.fans?.toBuilder();
      _digests = _$v.digests?.toBuilder();
      _follows = _$v.follows?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Profile;
  }

  @override
  void update(void updates(ProfileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Profile build() {
    _$Profile _$result;
    try {
      _$result = _$v ??
          new _$Profile._(
              lastError: lastError,
              loading: loading,
              user: user.build(),
              stories: _stories?.build(),
              fans: _fans?.build(),
              digests: _digests?.build(),
              follows: _follows?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'stories';
        _stories?.build();
        _$failedField = 'fans';
        _fans?.build();
        _$failedField = 'digests';
        _digests?.build();
        _$failedField = 'follows';
        _follows?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Profile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SearchResult extends SearchResult {
  @override
  final String lastError;
  @override
  final bool loading;
  @override
  final String searchString;
  @override
  final int searchType;
  @override
  final StoryFetchList stories;
  @override
  final SearchUserResult users;
  @override
  final SearchForumResult forums;

  factory _$SearchResult([void updates(SearchResultBuilder b)]) =>
      (new SearchResultBuilder()..update(updates)).build();

  _$SearchResult._(
      {this.lastError,
      this.loading,
      this.searchString,
      this.searchType,
      this.stories,
      this.users,
      this.forums})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('SearchResult', 'loading');
    }
    if (searchString == null) {
      throw new BuiltValueNullFieldError('SearchResult', 'searchString');
    }
    if (searchType == null) {
      throw new BuiltValueNullFieldError('SearchResult', 'searchType');
    }
  }

  @override
  SearchResult rebuild(void updates(SearchResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchResultBuilder toBuilder() => new SearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchResult &&
        lastError == other.lastError &&
        loading == other.loading &&
        searchString == other.searchString &&
        searchType == other.searchType &&
        stories == other.stories &&
        users == other.users &&
        forums == other.forums;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, lastError.hashCode), loading.hashCode),
                        searchString.hashCode),
                    searchType.hashCode),
                stories.hashCode),
            users.hashCode),
        forums.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchResult')
          ..add('lastError', lastError)
          ..add('loading', loading)
          ..add('searchString', searchString)
          ..add('searchType', searchType)
          ..add('stories', stories)
          ..add('users', users)
          ..add('forums', forums))
        .toString();
  }
}

class SearchResultBuilder
    implements Builder<SearchResult, SearchResultBuilder> {
  _$SearchResult _$v;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  String _searchString;
  String get searchString => _$this._searchString;
  set searchString(String searchString) => _$this._searchString = searchString;

  int _searchType;
  int get searchType => _$this._searchType;
  set searchType(int searchType) => _$this._searchType = searchType;

  StoryFetchListBuilder _stories;
  StoryFetchListBuilder get stories =>
      _$this._stories ??= new StoryFetchListBuilder();
  set stories(StoryFetchListBuilder stories) => _$this._stories = stories;

  SearchUserResultBuilder _users;
  SearchUserResultBuilder get users =>
      _$this._users ??= new SearchUserResultBuilder();
  set users(SearchUserResultBuilder users) => _$this._users = users;

  SearchForumResultBuilder _forums;
  SearchForumResultBuilder get forums =>
      _$this._forums ??= new SearchForumResultBuilder();
  set forums(SearchForumResultBuilder forums) => _$this._forums = forums;

  SearchResultBuilder();

  SearchResultBuilder get _$this {
    if (_$v != null) {
      _lastError = _$v.lastError;
      _loading = _$v.loading;
      _searchString = _$v.searchString;
      _searchType = _$v.searchType;
      _stories = _$v.stories?.toBuilder();
      _users = _$v.users?.toBuilder();
      _forums = _$v.forums?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchResult;
  }

  @override
  void update(void updates(SearchResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchResult build() {
    _$SearchResult _$result;
    try {
      _$result = _$v ??
          new _$SearchResult._(
              lastError: lastError,
              loading: loading,
              searchString: searchString,
              searchType: searchType,
              stories: _stories?.build(),
              users: _users?.build(),
              forums: _forums?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stories';
        _stories?.build();
        _$failedField = 'users';
        _users?.build();
        _$failedField = 'forums';
        _forums?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StoryFetchList extends StoryFetchList {
  @override
  final bool loading;
  @override
  final int nexttime;
  @override
  final int current;
  @override
  final int newcount;
  @override
  final String lastError;
  @override
  final BuiltList<Story> stories;

  factory _$StoryFetchList([void updates(StoryFetchListBuilder b)]) =>
      (new StoryFetchListBuilder()..update(updates)).build();

  _$StoryFetchList._(
      {this.loading,
      this.nexttime,
      this.current,
      this.newcount,
      this.lastError,
      this.stories})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('StoryFetchList', 'loading');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('StoryFetchList', 'nexttime');
    }
    if (current == null) {
      throw new BuiltValueNullFieldError('StoryFetchList', 'current');
    }
    if (newcount == null) {
      throw new BuiltValueNullFieldError('StoryFetchList', 'newcount');
    }
    if (stories == null) {
      throw new BuiltValueNullFieldError('StoryFetchList', 'stories');
    }
  }

  @override
  StoryFetchList rebuild(void updates(StoryFetchListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryFetchListBuilder toBuilder() =>
      new StoryFetchListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryFetchList &&
        loading == other.loading &&
        nexttime == other.nexttime &&
        current == other.current &&
        newcount == other.newcount &&
        lastError == other.lastError &&
        stories == other.stories;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, loading.hashCode), nexttime.hashCode),
                    current.hashCode),
                newcount.hashCode),
            lastError.hashCode),
        stories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryFetchList')
          ..add('loading', loading)
          ..add('nexttime', nexttime)
          ..add('current', current)
          ..add('newcount', newcount)
          ..add('lastError', lastError)
          ..add('stories', stories))
        .toString();
  }
}

class StoryFetchListBuilder
    implements Builder<StoryFetchList, StoryFetchListBuilder> {
  _$StoryFetchList _$v;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _current;
  int get current => _$this._current;
  set current(int current) => _$this._current = current;

  int _newcount;
  int get newcount => _$this._newcount;
  set newcount(int newcount) => _$this._newcount = newcount;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  ListBuilder<Story> _stories;
  ListBuilder<Story> get stories =>
      _$this._stories ??= new ListBuilder<Story>();
  set stories(ListBuilder<Story> stories) => _$this._stories = stories;

  StoryFetchListBuilder();

  StoryFetchListBuilder get _$this {
    if (_$v != null) {
      _loading = _$v.loading;
      _nexttime = _$v.nexttime;
      _current = _$v.current;
      _newcount = _$v.newcount;
      _lastError = _$v.lastError;
      _stories = _$v.stories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryFetchList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryFetchList;
  }

  @override
  void update(void updates(StoryFetchListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryFetchList build() {
    _$StoryFetchList _$result;
    try {
      _$result = _$v ??
          new _$StoryFetchList._(
              loading: loading,
              nexttime: nexttime,
              current: current,
              newcount: newcount,
              lastError: lastError,
              stories: stories.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'stories';
        stories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StoryFetchList', _$failedField, e.toString());
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
  final bool loading;
  @override
  final BuiltMap<int, StoryPage> pages;
  @override
  final String lastError;

  factory _$StoryPageList([void updates(StoryPageListBuilder b)]) =>
      (new StoryPageListBuilder()..update(updates)).build();

  _$StoryPageList._({this.storyInfo, this.loading, this.pages, this.lastError})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('StoryPageList', 'loading');
    }
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
        loading == other.loading &&
        pages == other.pages &&
        lastError == other.lastError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, storyInfo.hashCode), loading.hashCode), pages.hashCode),
        lastError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryPageList')
          ..add('storyInfo', storyInfo)
          ..add('loading', loading)
          ..add('pages', pages)
          ..add('lastError', lastError))
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

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  MapBuilder<int, StoryPage> _pages;
  MapBuilder<int, StoryPage> get pages =>
      _$this._pages ??= new MapBuilder<int, StoryPage>();
  set pages(MapBuilder<int, StoryPage> pages) => _$this._pages = pages;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

  StoryPageListBuilder();

  StoryPageListBuilder get _$this {
    if (_$v != null) {
      _storyInfo = _$v.storyInfo?.toBuilder();
      _loading = _$v.loading;
      _pages = _$v.pages?.toBuilder();
      _lastError = _$v.lastError;
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
              storyInfo: _storyInfo?.build(),
              loading: loading,
              pages: pages.build(),
              lastError: lastError);
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

class _$ForumLists extends ForumLists {
  @override
  final bool loading;
  @override
  final String lastError;
  @override
  final BuiltList<Forum> forums;
  @override
  final BuiltList<Forum> sysplanes;
  @override
  final BuiltList<Forum> planes;
  @override
  final BuiltMap<int, ForumInfoResult> info;

  factory _$ForumLists([void updates(ForumListsBuilder b)]) =>
      (new ForumListsBuilder()..update(updates)).build();

  _$ForumLists._(
      {this.loading,
      this.lastError,
      this.forums,
      this.sysplanes,
      this.planes,
      this.info})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('ForumLists', 'loading');
    }
    if (forums == null) {
      throw new BuiltValueNullFieldError('ForumLists', 'forums');
    }
    if (sysplanes == null) {
      throw new BuiltValueNullFieldError('ForumLists', 'sysplanes');
    }
    if (planes == null) {
      throw new BuiltValueNullFieldError('ForumLists', 'planes');
    }
    if (info == null) {
      throw new BuiltValueNullFieldError('ForumLists', 'info');
    }
  }

  @override
  ForumLists rebuild(void updates(ForumListsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumListsBuilder toBuilder() => new ForumListsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForumLists &&
        loading == other.loading &&
        lastError == other.lastError &&
        forums == other.forums &&
        sysplanes == other.sysplanes &&
        planes == other.planes &&
        info == other.info;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, loading.hashCode), lastError.hashCode),
                    forums.hashCode),
                sysplanes.hashCode),
            planes.hashCode),
        info.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForumLists')
          ..add('loading', loading)
          ..add('lastError', lastError)
          ..add('forums', forums)
          ..add('sysplanes', sysplanes)
          ..add('planes', planes)
          ..add('info', info))
        .toString();
  }
}

class ForumListsBuilder implements Builder<ForumLists, ForumListsBuilder> {
  _$ForumLists _$v;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  String _lastError;
  String get lastError => _$this._lastError;
  set lastError(String lastError) => _$this._lastError = lastError;

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

  ForumListsBuilder();

  ForumListsBuilder get _$this {
    if (_$v != null) {
      _loading = _$v.loading;
      _lastError = _$v.lastError;
      _forums = _$v.forums?.toBuilder();
      _sysplanes = _$v.sysplanes?.toBuilder();
      _planes = _$v.planes?.toBuilder();
      _info = _$v.info?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForumLists other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ForumLists;
  }

  @override
  void update(void updates(ForumListsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ForumLists build() {
    _$ForumLists _$result;
    try {
      _$result = _$v ??
          new _$ForumLists._(
              loading: loading,
              lastError: lastError,
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
            'ForumLists', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
