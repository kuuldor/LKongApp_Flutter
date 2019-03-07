// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checknotice_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CheckNoticeResult> _$checkNoticeResultSerializer =
    new _$CheckNoticeResultSerializer();
Serializer<NewNotice> _$newNoticeSerializer = new _$NewNoticeSerializer();

class _$CheckNoticeResultSerializer
    implements StructuredSerializer<CheckNoticeResult> {
  @override
  final Iterable<Type> types = const [CheckNoticeResult, _$CheckNoticeResult];
  @override
  final String wireName = 'CheckNoticeResult';

  @override
  Iterable serialize(Serializers serializers, CheckNoticeResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.time != null) {
      result
        ..add('time')
        ..add(serializers.serialize(object.time,
            specifiedType: const FullType(int)));
    }
    if (object.newNotice != null) {
      result
        ..add('notice')
        ..add(serializers.serialize(object.newNotice,
            specifiedType: const FullType(NewNotice)));
    }
    if (object.ok != null) {
      result
        ..add('ok')
        ..add(serializers.serialize(object.ok,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  CheckNoticeResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CheckNoticeResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'notice':
          result.newNotice.replace(serializers.deserialize(value,
              specifiedType: const FullType(NewNotice)) as NewNotice);
          break;
        case 'ok':
          result.ok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$NewNoticeSerializer implements StructuredSerializer<NewNotice> {
  @override
  final Iterable<Type> types = const [NewNotice, _$NewNotice];
  @override
  final String wireName = 'NewNotice';

  @override
  Iterable serialize(Serializers serializers, NewNotice object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.notice != null) {
      result
        ..add('notice')
        ..add(serializers.serialize(object.notice,
            specifiedType: const FullType(int)));
    }
    if (object.atme != null) {
      result
        ..add('atme')
        ..add(serializers.serialize(object.atme,
            specifiedType: const FullType(int)));
    }
    if (object.rate != null) {
      result
        ..add('rate')
        ..add(serializers.serialize(object.rate,
            specifiedType: const FullType(int)));
    }
    if (object.fans != null) {
      result
        ..add('fans')
        ..add(serializers.serialize(object.fans,
            specifiedType: const FullType(int)));
    }
    if (object.pm != null) {
      result
        ..add('pm')
        ..add(serializers.serialize(object.pm,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  NewNotice deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewNoticeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'notice':
          result.notice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'atme':
          result.atme = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fans':
          result.fans = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pm':
          result.pm = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$CheckNoticeResult extends CheckNoticeResult {
  @override
  final int time;
  @override
  final NewNotice newNotice;
  @override
  final bool ok;

  factory _$CheckNoticeResult([void updates(CheckNoticeResultBuilder b)]) =>
      (new CheckNoticeResultBuilder()..update(updates)).build();

  _$CheckNoticeResult._({this.time, this.newNotice, this.ok}) : super._();

  @override
  CheckNoticeResult rebuild(void updates(CheckNoticeResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckNoticeResultBuilder toBuilder() =>
      new CheckNoticeResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckNoticeResult &&
        time == other.time &&
        newNotice == other.newNotice &&
        ok == other.ok;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, time.hashCode), newNotice.hashCode), ok.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CheckNoticeResult')
          ..add('time', time)
          ..add('newNotice', newNotice)
          ..add('ok', ok))
        .toString();
  }
}

class CheckNoticeResultBuilder
    implements Builder<CheckNoticeResult, CheckNoticeResultBuilder> {
  _$CheckNoticeResult _$v;

  int _time;
  int get time => _$this._time;
  set time(int time) => _$this._time = time;

  NewNoticeBuilder _newNotice;
  NewNoticeBuilder get newNotice =>
      _$this._newNotice ??= new NewNoticeBuilder();
  set newNotice(NewNoticeBuilder newNotice) => _$this._newNotice = newNotice;

  bool _ok;
  bool get ok => _$this._ok;
  set ok(bool ok) => _$this._ok = ok;

  CheckNoticeResultBuilder();

  CheckNoticeResultBuilder get _$this {
    if (_$v != null) {
      _time = _$v.time;
      _newNotice = _$v.newNotice?.toBuilder();
      _ok = _$v.ok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckNoticeResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CheckNoticeResult;
  }

  @override
  void update(void updates(CheckNoticeResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CheckNoticeResult build() {
    _$CheckNoticeResult _$result;
    try {
      _$result = _$v ??
          new _$CheckNoticeResult._(
              time: time, newNotice: _newNotice?.build(), ok: ok);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'newNotice';
        _newNotice?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CheckNoticeResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$NewNotice extends NewNotice {
  @override
  final int notice;
  @override
  final int atme;
  @override
  final int rate;
  @override
  final int fans;
  @override
  final int pm;

  factory _$NewNotice([void updates(NewNoticeBuilder b)]) =>
      (new NewNoticeBuilder()..update(updates)).build();

  _$NewNotice._({this.notice, this.atme, this.rate, this.fans, this.pm})
      : super._();

  @override
  NewNotice rebuild(void updates(NewNoticeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NewNoticeBuilder toBuilder() => new NewNoticeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewNotice &&
        notice == other.notice &&
        atme == other.atme &&
        rate == other.rate &&
        fans == other.fans &&
        pm == other.pm;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, notice.hashCode), atme.hashCode), rate.hashCode),
            fans.hashCode),
        pm.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewNotice')
          ..add('notice', notice)
          ..add('atme', atme)
          ..add('rate', rate)
          ..add('fans', fans)
          ..add('pm', pm))
        .toString();
  }
}

class NewNoticeBuilder implements Builder<NewNotice, NewNoticeBuilder> {
  _$NewNotice _$v;

  int _notice;
  int get notice => _$this._notice;
  set notice(int notice) => _$this._notice = notice;

  int _atme;
  int get atme => _$this._atme;
  set atme(int atme) => _$this._atme = atme;

  int _rate;
  int get rate => _$this._rate;
  set rate(int rate) => _$this._rate = rate;

  int _fans;
  int get fans => _$this._fans;
  set fans(int fans) => _$this._fans = fans;

  int _pm;
  int get pm => _$this._pm;
  set pm(int pm) => _$this._pm = pm;

  NewNoticeBuilder();

  NewNoticeBuilder get _$this {
    if (_$v != null) {
      _notice = _$v.notice;
      _atme = _$v.atme;
      _rate = _$v.rate;
      _fans = _$v.fans;
      _pm = _$v.pm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewNotice other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewNotice;
  }

  @override
  void update(void updates(NewNoticeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$NewNotice build() {
    final _$result = _$v ??
        new _$NewNotice._(
            notice: notice, atme: atme, rate: rate, fans: fans, pm: pm);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
