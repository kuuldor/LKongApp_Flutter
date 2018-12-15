// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchUserResult> _$searchUserResultSerializer =
    new _$SearchUserResultSerializer();
Serializer<SearchForumResult> _$searchForumResultSerializer =
    new _$SearchForumResultSerializer();

class _$SearchUserResultSerializer
    implements StructuredSerializer<SearchUserResult> {
  @override
  final Iterable<Type> types = const [SearchUserResult, _$SearchUserResult];
  @override
  final String wireName = 'SearchUserResult';

  @override
  Iterable serialize(Serializers serializers, SearchUserResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.user,
          specifiedType:
              const FullType(BuiltList, const [const FullType(UserInfo)])),
    ];
    if (object.nexttime != null) {
      result
        ..add('nexttime')
        ..add(serializers.serialize(object.nexttime,
            specifiedType: const FullType(int)));
    }
    if (object.curtime != null) {
      result
        ..add('curtime')
        ..add(serializers.serialize(object.curtime,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  SearchUserResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchUserResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tmp':
          result.tmp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nexttime':
          result.nexttime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'curtime':
          result.curtime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(UserInfo)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchForumResultSerializer
    implements StructuredSerializer<SearchForumResult> {
  @override
  final Iterable<Type> types = const [SearchForumResult, _$SearchForumResult];
  @override
  final String wireName = 'SearchForumResult';

  @override
  Iterable serialize(Serializers serializers, SearchForumResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.forumInfo,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ForumInfoResult)])),
    ];

    return result;
  }

  @override
  SearchForumResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchForumResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tmp':
          result.tmp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nexttime':
          result.nexttime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.forumInfo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ForumInfoResult)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchUserResult extends SearchUserResult {
  @override
  final String tmp;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<UserInfo> user;

  factory _$SearchUserResult([void updates(SearchUserResultBuilder b)]) =>
      (new SearchUserResultBuilder()..update(updates)).build();

  _$SearchUserResult._({this.tmp, this.nexttime, this.curtime, this.user})
      : super._() {
    if (tmp == null) {
      throw new BuiltValueNullFieldError('SearchUserResult', 'tmp');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('SearchUserResult', 'user');
    }
  }

  @override
  SearchUserResult rebuild(void updates(SearchUserResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchUserResultBuilder toBuilder() =>
      new SearchUserResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchUserResult &&
        tmp == other.tmp &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, tmp.hashCode), nexttime.hashCode), curtime.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchUserResult')
          ..add('tmp', tmp)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('user', user))
        .toString();
  }
}

class SearchUserResultBuilder
    implements Builder<SearchUserResult, SearchUserResultBuilder> {
  _$SearchUserResult _$v;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<UserInfo> _user;
  ListBuilder<UserInfo> get user =>
      _$this._user ??= new ListBuilder<UserInfo>();
  set user(ListBuilder<UserInfo> user) => _$this._user = user;

  SearchUserResultBuilder();

  SearchUserResultBuilder get _$this {
    if (_$v != null) {
      _tmp = _$v.tmp;
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchUserResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchUserResult;
  }

  @override
  void update(void updates(SearchUserResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchUserResult build() {
    _$SearchUserResult _$result;
    try {
      _$result = _$v ??
          new _$SearchUserResult._(
              tmp: tmp,
              nexttime: nexttime,
              curtime: curtime,
              user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchUserResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SearchForumResult extends SearchForumResult {
  @override
  final String tmp;
  @override
  final int nexttime;
  @override
  final BuiltList<ForumInfoResult> forumInfo;

  factory _$SearchForumResult([void updates(SearchForumResultBuilder b)]) =>
      (new SearchForumResultBuilder()..update(updates)).build();

  _$SearchForumResult._({this.tmp, this.nexttime, this.forumInfo}) : super._() {
    if (tmp == null) {
      throw new BuiltValueNullFieldError('SearchForumResult', 'tmp');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('SearchForumResult', 'nexttime');
    }
    if (forumInfo == null) {
      throw new BuiltValueNullFieldError('SearchForumResult', 'forumInfo');
    }
  }

  @override
  SearchForumResult rebuild(void updates(SearchForumResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchForumResultBuilder toBuilder() =>
      new SearchForumResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchForumResult &&
        tmp == other.tmp &&
        nexttime == other.nexttime &&
        forumInfo == other.forumInfo;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, tmp.hashCode), nexttime.hashCode), forumInfo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchForumResult')
          ..add('tmp', tmp)
          ..add('nexttime', nexttime)
          ..add('forumInfo', forumInfo))
        .toString();
  }
}

class SearchForumResultBuilder
    implements Builder<SearchForumResult, SearchForumResultBuilder> {
  _$SearchForumResult _$v;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  ListBuilder<ForumInfoResult> _forumInfo;
  ListBuilder<ForumInfoResult> get forumInfo =>
      _$this._forumInfo ??= new ListBuilder<ForumInfoResult>();
  set forumInfo(ListBuilder<ForumInfoResult> forumInfo) =>
      _$this._forumInfo = forumInfo;

  SearchForumResultBuilder();

  SearchForumResultBuilder get _$this {
    if (_$v != null) {
      _tmp = _$v.tmp;
      _nexttime = _$v.nexttime;
      _forumInfo = _$v.forumInfo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchForumResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchForumResult;
  }

  @override
  void update(void updates(SearchForumResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchForumResult build() {
    _$SearchForumResult _$result;
    try {
      _$result = _$v ??
          new _$SearchForumResult._(
              tmp: tmp, nexttime: nexttime, forumInfo: forumInfo.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'forumInfo';
        forumInfo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchForumResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
