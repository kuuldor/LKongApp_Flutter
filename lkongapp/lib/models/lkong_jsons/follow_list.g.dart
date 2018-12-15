// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FollowList> _$followListSerializer = new _$FollowListSerializer();
Serializer<PunchCardResult> _$punchCardResultSerializer =
    new _$PunchCardResultSerializer();

class _$FollowListSerializer implements StructuredSerializer<FollowList> {
  @override
  final Iterable<Type> types = const [FollowList, _$FollowList];
  @override
  final String wireName = 'FollowList';

  @override
  Iterable serialize(Serializers serializers, FollowList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uid',
      serializers.serialize(object.uid,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'fid',
      serializers.serialize(object.fid,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'tid',
      serializers.serialize(object.tid,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'black',
      serializers.serialize(object.black,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  FollowList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FollowListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'fid':
          result.fid.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'tid':
          result.tid.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'black':
          result.black.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$PunchCardResultSerializer
    implements StructuredSerializer<PunchCardResult> {
  @override
  final Iterable<Type> types = const [PunchCardResult, _$PunchCardResult];
  @override
  final String wireName = 'PunchCardResult';

  @override
  Iterable serialize(Serializers serializers, PunchCardResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'punchtime',
      serializers.serialize(object.punchtime,
          specifiedType: const FullType(int)),
      'punchday',
      serializers.serialize(object.punchday,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  PunchCardResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PunchCardResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'punchtime':
          result.punchtime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'punchday':
          result.punchday = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$FollowList extends FollowList {
  @override
  final BuiltList<String> uid;
  @override
  final BuiltList<String> fid;
  @override
  final BuiltList<String> tid;
  @override
  final BuiltList<String> black;

  factory _$FollowList([void updates(FollowListBuilder b)]) =>
      (new FollowListBuilder()..update(updates)).build();

  _$FollowList._({this.uid, this.fid, this.tid, this.black}) : super._() {
    if (uid == null) {
      throw new BuiltValueNullFieldError('FollowList', 'uid');
    }
    if (fid == null) {
      throw new BuiltValueNullFieldError('FollowList', 'fid');
    }
    if (tid == null) {
      throw new BuiltValueNullFieldError('FollowList', 'tid');
    }
    if (black == null) {
      throw new BuiltValueNullFieldError('FollowList', 'black');
    }
  }

  @override
  FollowList rebuild(void updates(FollowListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FollowListBuilder toBuilder() => new FollowListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowList &&
        uid == other.uid &&
        fid == other.fid &&
        tid == other.tid &&
        black == other.black;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, uid.hashCode), fid.hashCode), tid.hashCode),
        black.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FollowList')
          ..add('uid', uid)
          ..add('fid', fid)
          ..add('tid', tid)
          ..add('black', black))
        .toString();
  }
}

class FollowListBuilder implements Builder<FollowList, FollowListBuilder> {
  _$FollowList _$v;

  ListBuilder<String> _uid;
  ListBuilder<String> get uid => _$this._uid ??= new ListBuilder<String>();
  set uid(ListBuilder<String> uid) => _$this._uid = uid;

  ListBuilder<String> _fid;
  ListBuilder<String> get fid => _$this._fid ??= new ListBuilder<String>();
  set fid(ListBuilder<String> fid) => _$this._fid = fid;

  ListBuilder<String> _tid;
  ListBuilder<String> get tid => _$this._tid ??= new ListBuilder<String>();
  set tid(ListBuilder<String> tid) => _$this._tid = tid;

  ListBuilder<String> _black;
  ListBuilder<String> get black => _$this._black ??= new ListBuilder<String>();
  set black(ListBuilder<String> black) => _$this._black = black;

  FollowListBuilder();

  FollowListBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid?.toBuilder();
      _fid = _$v.fid?.toBuilder();
      _tid = _$v.tid?.toBuilder();
      _black = _$v.black?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FollowList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FollowList;
  }

  @override
  void update(void updates(FollowListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FollowList build() {
    _$FollowList _$result;
    try {
      _$result = _$v ??
          new _$FollowList._(
              uid: uid.build(),
              fid: fid.build(),
              tid: tid.build(),
              black: black.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'uid';
        uid.build();
        _$failedField = 'fid';
        fid.build();
        _$failedField = 'tid';
        tid.build();
        _$failedField = 'black';
        black.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FollowList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PunchCardResult extends PunchCardResult {
  @override
  final int punchtime;
  @override
  final int punchday;

  factory _$PunchCardResult([void updates(PunchCardResultBuilder b)]) =>
      (new PunchCardResultBuilder()..update(updates)).build();

  _$PunchCardResult._({this.punchtime, this.punchday}) : super._() {
    if (punchtime == null) {
      throw new BuiltValueNullFieldError('PunchCardResult', 'punchtime');
    }
    if (punchday == null) {
      throw new BuiltValueNullFieldError('PunchCardResult', 'punchday');
    }
  }

  @override
  PunchCardResult rebuild(void updates(PunchCardResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PunchCardResultBuilder toBuilder() =>
      new PunchCardResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PunchCardResult &&
        punchtime == other.punchtime &&
        punchday == other.punchday;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, punchtime.hashCode), punchday.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PunchCardResult')
          ..add('punchtime', punchtime)
          ..add('punchday', punchday))
        .toString();
  }
}

class PunchCardResultBuilder
    implements Builder<PunchCardResult, PunchCardResultBuilder> {
  _$PunchCardResult _$v;

  int _punchtime;
  int get punchtime => _$this._punchtime;
  set punchtime(int punchtime) => _$this._punchtime = punchtime;

  int _punchday;
  int get punchday => _$this._punchday;
  set punchday(int punchday) => _$this._punchday = punchday;

  PunchCardResultBuilder();

  PunchCardResultBuilder get _$this {
    if (_$v != null) {
      _punchtime = _$v.punchtime;
      _punchday = _$v.punchday;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PunchCardResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PunchCardResult;
  }

  @override
  void update(void updates(PunchCardResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PunchCardResult build() {
    final _$result = _$v ??
        new _$PunchCardResult._(punchtime: punchtime, punchday: punchday);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
