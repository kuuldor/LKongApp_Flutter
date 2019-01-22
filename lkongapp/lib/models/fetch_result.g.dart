// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FetchList<T> extends FetchList<T> {
  @override
  final bool loading;
  @override
  final bool sending;
  @override
  final int nexttime;
  @override
  final int current;
  @override
  final int newcount;
  @override
  final String lastError;
  @override
  final BuiltList<T> data;

  factory _$FetchList([void updates(FetchListBuilder<T> b)]) =>
      (new FetchListBuilder<T>()..update(updates)).build();

  _$FetchList._(
      {this.loading,
      this.sending,
      this.nexttime,
      this.current,
      this.newcount,
      this.lastError,
      this.data})
      : super._() {
    if (loading == null) {
      throw new BuiltValueNullFieldError('FetchList', 'loading');
    }
    if (sending == null) {
      throw new BuiltValueNullFieldError('FetchList', 'sending');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('FetchList', 'nexttime');
    }
    if (current == null) {
      throw new BuiltValueNullFieldError('FetchList', 'current');
    }
    if (newcount == null) {
      throw new BuiltValueNullFieldError('FetchList', 'newcount');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('FetchList', 'data');
    }
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('FetchList', 'T');
    }
  }

  @override
  FetchList<T> rebuild(void updates(FetchListBuilder<T> b)) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchListBuilder<T> toBuilder() => new FetchListBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchList &&
        loading == other.loading &&
        sending == other.sending &&
        nexttime == other.nexttime &&
        current == other.current &&
        newcount == other.newcount &&
        lastError == other.lastError &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, loading.hashCode), sending.hashCode),
                        nexttime.hashCode),
                    current.hashCode),
                newcount.hashCode),
            lastError.hashCode),
        data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FetchList')
          ..add('loading', loading)
          ..add('sending', sending)
          ..add('nexttime', nexttime)
          ..add('current', current)
          ..add('newcount', newcount)
          ..add('lastError', lastError)
          ..add('data', data))
        .toString();
  }
}

class FetchListBuilder<T>
    implements Builder<FetchList<T>, FetchListBuilder<T>> {
  _$FetchList<T> _$v;

  bool _loading;
  bool get loading => _$this._loading;
  set loading(bool loading) => _$this._loading = loading;

  bool _sending;
  bool get sending => _$this._sending;
  set sending(bool sending) => _$this._sending = sending;

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

  ListBuilder<T> _data;
  ListBuilder<T> get data => _$this._data ??= new ListBuilder<T>();
  set data(ListBuilder<T> data) => _$this._data = data;

  FetchListBuilder();

  FetchListBuilder<T> get _$this {
    if (_$v != null) {
      _loading = _$v.loading;
      _sending = _$v.sending;
      _nexttime = _$v.nexttime;
      _current = _$v.current;
      _newcount = _$v.newcount;
      _lastError = _$v.lastError;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FetchList<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FetchList<T>;
  }

  @override
  void update(void updates(FetchListBuilder<T> b)) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchList<T> build() {
    _$FetchList<T> _$result;
    try {
      _$result = _$v ??
          new _$FetchList<T>._(
              loading: loading,
              sending: sending,
              nexttime: nexttime,
              current: current,
              newcount: newcount,
              lastError: lastError,
              data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FetchList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
