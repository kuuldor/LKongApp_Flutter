// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_digest_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HotDigestResult> _$hotDigestResultSerializer =
    new _$HotDigestResultSerializer();
Serializer<Thread> _$threadSerializer = new _$ThreadSerializer();

class _$HotDigestResultSerializer
    implements StructuredSerializer<HotDigestResult> {
  @override
  final Iterable<Type> types = const [HotDigestResult, _$HotDigestResult];
  @override
  final String wireName = 'HotDigestResult';

  @override
  Iterable serialize(Serializers serializers, HotDigestResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'thread',
      serializers.serialize(object.thread,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Thread)])),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isok',
      serializers.serialize(object.isok, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  HotDigestResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HotDigestResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'thread':
          result.thread.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Thread)]))
              as BuiltList);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isok':
          result.isok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ThreadSerializer implements StructuredSerializer<Thread> {
  @override
  final Iterable<Type> types = const [Thread, _$Thread];
  @override
  final String wireName = 'Thread';

  @override
  Iterable serialize(Serializers serializers, Thread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tid',
      serializers.serialize(object.tid, specifiedType: const FullType(int)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Thread deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThreadBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tid':
          result.tid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HotDigestResult extends HotDigestResult {
  @override
  final BuiltList<Thread> thread;
  @override
  final String title;
  @override
  final String id;
  @override
  final bool isok;

  factory _$HotDigestResult([void updates(HotDigestResultBuilder b)]) =>
      (new HotDigestResultBuilder()..update(updates)).build();

  _$HotDigestResult._({this.thread, this.title, this.id, this.isok})
      : super._() {
    if (thread == null) {
      throw new BuiltValueNullFieldError('HotDigestResult', 'thread');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('HotDigestResult', 'title');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('HotDigestResult', 'id');
    }
    if (isok == null) {
      throw new BuiltValueNullFieldError('HotDigestResult', 'isok');
    }
  }

  @override
  HotDigestResult rebuild(void updates(HotDigestResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HotDigestResultBuilder toBuilder() =>
      new HotDigestResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HotDigestResult &&
        thread == other.thread &&
        title == other.title &&
        id == other.id &&
        isok == other.isok;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, thread.hashCode), title.hashCode), id.hashCode),
        isok.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HotDigestResult')
          ..add('thread', thread)
          ..add('title', title)
          ..add('id', id)
          ..add('isok', isok))
        .toString();
  }
}

class HotDigestResultBuilder
    implements Builder<HotDigestResult, HotDigestResultBuilder> {
  _$HotDigestResult _$v;

  ListBuilder<Thread> _thread;
  ListBuilder<Thread> get thread =>
      _$this._thread ??= new ListBuilder<Thread>();
  set thread(ListBuilder<Thread> thread) => _$this._thread = thread;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _isok;
  bool get isok => _$this._isok;
  set isok(bool isok) => _$this._isok = isok;

  HotDigestResultBuilder();

  HotDigestResultBuilder get _$this {
    if (_$v != null) {
      _thread = _$v.thread?.toBuilder();
      _title = _$v.title;
      _id = _$v.id;
      _isok = _$v.isok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HotDigestResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HotDigestResult;
  }

  @override
  void update(void updates(HotDigestResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$HotDigestResult build() {
    _$HotDigestResult _$result;
    try {
      _$result = _$v ??
          new _$HotDigestResult._(
              thread: thread.build(), title: title, id: id, isok: isok);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'thread';
        thread.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HotDigestResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Thread extends Thread {
  @override
  final int tid;
  @override
  final String subject;

  factory _$Thread([void updates(ThreadBuilder b)]) =>
      (new ThreadBuilder()..update(updates)).build();

  _$Thread._({this.tid, this.subject}) : super._() {
    if (tid == null) {
      throw new BuiltValueNullFieldError('Thread', 'tid');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('Thread', 'subject');
    }
  }

  @override
  Thread rebuild(void updates(ThreadBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ThreadBuilder toBuilder() => new ThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Thread && tid == other.tid && subject == other.subject;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, tid.hashCode), subject.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Thread')
          ..add('tid', tid)
          ..add('subject', subject))
        .toString();
  }
}

class ThreadBuilder implements Builder<Thread, ThreadBuilder> {
  _$Thread _$v;

  int _tid;
  int get tid => _$this._tid;
  set tid(int tid) => _$this._tid = tid;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  ThreadBuilder();

  ThreadBuilder get _$this {
    if (_$v != null) {
      _tid = _$v.tid;
      _subject = _$v.subject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Thread other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Thread;
  }

  @override
  void update(void updates(ThreadBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Thread build() {
    final _$result = _$v ?? new _$Thread._(tid: tid, subject: subject);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
