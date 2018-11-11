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
      'homeList',
      serializers.serialize(object.homeList,
          specifiedType: const FullType(HomeList)),
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
        case 'homeList':
          result.homeList.replace(serializers.deserialize(value,
              specifiedType: const FullType(HomeList)) as HomeList);
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
  final HomeList homeList;

  factory _$UIState([void updates(UIStateBuilder b)]) =>
      (new UIStateBuilder()..update(updates)).build();

  _$UIState._({this.navigationRoute, this.homePageIndex, this.homeList})
      : super._() {
    if (navigationRoute == null) {
      throw new BuiltValueNullFieldError('UIState', 'navigationRoute');
    }
    if (homePageIndex == null) {
      throw new BuiltValueNullFieldError('UIState', 'homePageIndex');
    }
    if (homeList == null) {
      throw new BuiltValueNullFieldError('UIState', 'homeList');
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
        homeList == other.homeList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, navigationRoute.hashCode), homePageIndex.hashCode),
        homeList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UIState')
          ..add('navigationRoute', navigationRoute)
          ..add('homePageIndex', homePageIndex)
          ..add('homeList', homeList))
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

  HomeListBuilder _homeList;
  HomeListBuilder get homeList => _$this._homeList ??= new HomeListBuilder();
  set homeList(HomeListBuilder homeList) => _$this._homeList = homeList;

  UIStateBuilder();

  UIStateBuilder get _$this {
    if (_$v != null) {
      _navigationRoute = _$v.navigationRoute;
      _homePageIndex = _$v.homePageIndex;
      _homeList = _$v.homeList?.toBuilder();
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
              homeList: homeList.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'homeList';
        homeList.build();
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

class _$HomeList extends HomeList {
  @override
  final bool loading;
  @override
  final int nexttime;
  @override
  final int current;
  @override
  final BuiltList<Story> stories;

  factory _$HomeList([void updates(HomeListBuilder b)]) =>
      (new HomeListBuilder()..update(updates)).build();

  _$HomeList._({this.loading, this.nexttime, this.current, this.stories})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('HomeList', 'loading');
    }
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
        loading == other.loading &&
        nexttime == other.nexttime &&
        current == other.current &&
        stories == other.stories;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, loading.hashCode), nexttime.hashCode), current.hashCode),
        stories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeList')
          ..add('loading', loading)
          ..add('nexttime', nexttime)
          ..add('current', current)
          ..add('stories', stories))
        .toString();
  }
}

class HomeListBuilder implements Builder<HomeList, HomeListBuilder> {
  _$HomeList _$v;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

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
      _loading = _$v.loading;
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
              loading: loading,
              nexttime: nexttime,
              current: current,
              stories: stories.build());
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
