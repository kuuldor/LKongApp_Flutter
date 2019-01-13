// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_stuff.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NoticeResult> _$noticeResultSerializer =
    new _$NoticeResultSerializer();
Serializer<Notice> _$noticeSerializer = new _$NoticeSerializer();
Serializer<RatelogResult> _$ratelogResultSerializer =
    new _$RatelogResultSerializer();
Serializer<Ratelog> _$ratelogSerializer = new _$RatelogSerializer();
Serializer<UpvoteResult> _$upvoteResultSerializer =
    new _$UpvoteResultSerializer();
Serializer<PrivateMessageResult> _$privateMessageResultSerializer =
    new _$PrivateMessageResultSerializer();
Serializer<PrivateMessage> _$privateMessageSerializer =
    new _$PrivateMessageSerializer();

class _$NoticeResultSerializer implements StructuredSerializer<NoticeResult> {
  @override
  final Iterable<Type> types = const [NoticeResult, _$NoticeResult];
  @override
  final String wireName = 'NoticeResult';

  @override
  Iterable serialize(Serializers serializers, NoticeResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'curtime',
      serializers.serialize(object.curtime, specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.notices,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Notice)])),
      'nochecknew',
      serializers.serialize(object.nochecknew,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  NoticeResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoticeResultBuilder();

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
          result.notices.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Notice)]))
              as BuiltList);
          break;
        case 'nochecknew':
          result.nochecknew = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$NoticeSerializer implements StructuredSerializer<Notice> {
  @override
  final Iterable<Type> types = const [Notice, _$Notice];
  @override
  final String wireName = 'Notice';

  @override
  Iterable serialize(Serializers serializers, Notice object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'note',
      serializers.serialize(object.note, specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'sortkey',
      serializers.serialize(object.sortkey, specifiedType: const FullType(int)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Notice deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoticeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$RatelogResultSerializer implements StructuredSerializer<RatelogResult> {
  @override
  final Iterable<Type> types = const [RatelogResult, _$RatelogResult];
  @override
  final String wireName = 'RatelogResult';

  @override
  Iterable serialize(Serializers serializers, RatelogResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'curtime',
      serializers.serialize(object.curtime, specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.ratelogs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Ratelog)])),
      'nochecknew',
      serializers.serialize(object.nochecknew,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  RatelogResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatelogResultBuilder();

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
          result.ratelogs.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Ratelog)])) as BuiltList);
          break;
        case 'nochecknew':
          result.nochecknew = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$RatelogSerializer implements StructuredSerializer<Ratelog> {
  @override
  final Iterable<Type> types = const [Ratelog, _$Ratelog];
  @override
  final String wireName = 'Ratelog';

  @override
  Iterable serialize(Serializers serializers, Ratelog object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'extcredits',
      serializers.serialize(object.extcredits,
          specifiedType: const FullType(int)),
      'score',
      serializers.serialize(object.score, specifiedType: const FullType(int)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(String)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'pid',
      serializers.serialize(object.pid, specifiedType: const FullType(int)),
    ];
    if (object.sortkey != null) {
      result
        ..add('sortkey')
        ..add(serializers.serialize(object.sortkey,
            specifiedType: const FullType(int)));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Ratelog deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatelogBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'extcredits':
          result.extcredits = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UpvoteResultSerializer implements StructuredSerializer<UpvoteResult> {
  @override
  final Iterable<Type> types = const [UpvoteResult, _$UpvoteResult];
  @override
  final String wireName = 'UpvoteResult';

  @override
  Iterable serialize(Serializers serializers, UpvoteResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'ratelog',
      serializers.serialize(object.ratelog,
          specifiedType: const FullType(Ratelog)),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'pid',
      serializers.serialize(object.pid, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  UpvoteResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UpvoteResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'ratelog':
          result.ratelog.replace(serializers.deserialize(value,
              specifiedType: const FullType(Ratelog)) as Ratelog);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$PrivateMessageResultSerializer
    implements StructuredSerializer<PrivateMessageResult> {
  @override
  final Iterable<Type> types = const [
    PrivateMessageResult,
    _$PrivateMessageResult
  ];
  @override
  final String wireName = 'PrivateMessageResult';

  @override
  Iterable serialize(Serializers serializers, PrivateMessageResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'curtime',
      serializers.serialize(object.curtime, specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.messages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PrivateMessage)])),
      'nochecknew',
      serializers.serialize(object.nochecknew,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  PrivateMessageResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrivateMessageResultBuilder();

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
          result.messages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PrivateMessage)]))
              as BuiltList);
          break;
        case 'nochecknew':
          result.nochecknew = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$PrivateMessageSerializer
    implements StructuredSerializer<PrivateMessage> {
  @override
  final Iterable<Type> types = const [PrivateMessage, _$PrivateMessage];
  @override
  final String wireName = 'PrivateMessage';

  @override
  Iterable serialize(Serializers serializers, PrivateMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'typeid',
      serializers.serialize(object.typeid, specifiedType: const FullType(int)),
      'sortkey',
      serializers.serialize(object.sortkey, specifiedType: const FullType(int)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PrivateMessage deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PrivateMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'typeid':
          result.typeid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$NoticeResult extends NoticeResult {
  @override
  final String tmp;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<Notice> notices;
  @override
  final bool nochecknew;

  factory _$NoticeResult([void updates(NoticeResultBuilder b)]) =>
      (new NoticeResultBuilder()..update(updates)).build();

  _$NoticeResult._(
      {this.tmp, this.nexttime, this.curtime, this.notices, this.nochecknew})
      : super._() {
    if (tmp == null) {
      throw new BuiltValueNullFieldError('NoticeResult', 'tmp');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('NoticeResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('NoticeResult', 'curtime');
    }
    if (notices == null) {
      throw new BuiltValueNullFieldError('NoticeResult', 'notices');
    }
    if (nochecknew == null) {
      throw new BuiltValueNullFieldError('NoticeResult', 'nochecknew');
    }
  }

  @override
  NoticeResult rebuild(void updates(NoticeResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeResultBuilder toBuilder() => new NoticeResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoticeResult &&
        tmp == other.tmp &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        notices == other.notices &&
        nochecknew == other.nochecknew;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, tmp.hashCode), nexttime.hashCode), curtime.hashCode),
            notices.hashCode),
        nochecknew.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NoticeResult')
          ..add('tmp', tmp)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('notices', notices)
          ..add('nochecknew', nochecknew))
        .toString();
  }
}

class NoticeResultBuilder
    implements Builder<NoticeResult, NoticeResultBuilder> {
  _$NoticeResult _$v;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<Notice> _notices;
  ListBuilder<Notice> get notices =>
      _$this._notices ??= new ListBuilder<Notice>();
  set notices(ListBuilder<Notice> notices) => _$this._notices = notices;

  bool _nochecknew;
  bool get nochecknew => _$this._nochecknew;
  set nochecknew(bool nochecknew) => _$this._nochecknew = nochecknew;

  NoticeResultBuilder();

  NoticeResultBuilder get _$this {
    if (_$v != null) {
      _tmp = _$v.tmp;
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _notices = _$v.notices?.toBuilder();
      _nochecknew = _$v.nochecknew;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoticeResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NoticeResult;
  }

  @override
  void update(void updates(NoticeResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$NoticeResult build() {
    _$NoticeResult _$result;
    try {
      _$result = _$v ??
          new _$NoticeResult._(
              tmp: tmp,
              nexttime: nexttime,
              curtime: curtime,
              notices: notices.build(),
              nochecknew: nochecknew);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'notices';
        notices.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NoticeResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Notice extends Notice {
  @override
  final int uid;
  @override
  final String username;
  @override
  final String note;
  @override
  final String id;
  @override
  final int sortkey;
  @override
  final String dateline;

  factory _$Notice([void updates(NoticeBuilder b)]) =>
      (new NoticeBuilder()..update(updates)).build();

  _$Notice._(
      {this.uid,
      this.username,
      this.note,
      this.id,
      this.sortkey,
      this.dateline})
      : super._() {
    if (uid == null) {
      throw new BuiltValueNullFieldError('Notice', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Notice', 'username');
    }
    if (note == null) {
      throw new BuiltValueNullFieldError('Notice', 'note');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Notice', 'id');
    }
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Notice', 'sortkey');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Notice', 'dateline');
    }
  }

  @override
  Notice rebuild(void updates(NoticeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NoticeBuilder toBuilder() => new NoticeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Notice &&
        uid == other.uid &&
        username == other.username &&
        note == other.note &&
        id == other.id &&
        sortkey == other.sortkey &&
        dateline == other.dateline;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, uid.hashCode), username.hashCode),
                    note.hashCode),
                id.hashCode),
            sortkey.hashCode),
        dateline.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Notice')
          ..add('uid', uid)
          ..add('username', username)
          ..add('note', note)
          ..add('id', id)
          ..add('sortkey', sortkey)
          ..add('dateline', dateline))
        .toString();
  }
}

class NoticeBuilder implements Builder<Notice, NoticeBuilder> {
  _$Notice _$v;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _note;
  String get note => _$this._note;
  set note(String note) => _$this._note = note;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  NoticeBuilder();

  NoticeBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _username = _$v.username;
      _note = _$v.note;
      _id = _$v.id;
      _sortkey = _$v.sortkey;
      _dateline = _$v.dateline;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Notice other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Notice;
  }

  @override
  void update(void updates(NoticeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Notice build() {
    final _$result = _$v ??
        new _$Notice._(
            uid: uid,
            username: username,
            note: note,
            id: id,
            sortkey: sortkey,
            dateline: dateline);
    replace(_$result);
    return _$result;
  }
}

class _$RatelogResult extends RatelogResult {
  @override
  final String tmp;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<Ratelog> ratelogs;
  @override
  final bool nochecknew;

  factory _$RatelogResult([void updates(RatelogResultBuilder b)]) =>
      (new RatelogResultBuilder()..update(updates)).build();

  _$RatelogResult._(
      {this.tmp, this.nexttime, this.curtime, this.ratelogs, this.nochecknew})
      : super._() {
    if (tmp == null) {
      throw new BuiltValueNullFieldError('RatelogResult', 'tmp');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('RatelogResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('RatelogResult', 'curtime');
    }
    if (ratelogs == null) {
      throw new BuiltValueNullFieldError('RatelogResult', 'ratelogs');
    }
    if (nochecknew == null) {
      throw new BuiltValueNullFieldError('RatelogResult', 'nochecknew');
    }
  }

  @override
  RatelogResult rebuild(void updates(RatelogResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RatelogResultBuilder toBuilder() => new RatelogResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RatelogResult &&
        tmp == other.tmp &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        ratelogs == other.ratelogs &&
        nochecknew == other.nochecknew;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, tmp.hashCode), nexttime.hashCode), curtime.hashCode),
            ratelogs.hashCode),
        nochecknew.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RatelogResult')
          ..add('tmp', tmp)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('ratelogs', ratelogs)
          ..add('nochecknew', nochecknew))
        .toString();
  }
}

class RatelogResultBuilder
    implements Builder<RatelogResult, RatelogResultBuilder> {
  _$RatelogResult _$v;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<Ratelog> _ratelogs;
  ListBuilder<Ratelog> get ratelogs =>
      _$this._ratelogs ??= new ListBuilder<Ratelog>();
  set ratelogs(ListBuilder<Ratelog> ratelogs) => _$this._ratelogs = ratelogs;

  bool _nochecknew;
  bool get nochecknew => _$this._nochecknew;
  set nochecknew(bool nochecknew) => _$this._nochecknew = nochecknew;

  RatelogResultBuilder();

  RatelogResultBuilder get _$this {
    if (_$v != null) {
      _tmp = _$v.tmp;
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _ratelogs = _$v.ratelogs?.toBuilder();
      _nochecknew = _$v.nochecknew;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RatelogResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RatelogResult;
  }

  @override
  void update(void updates(RatelogResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$RatelogResult build() {
    _$RatelogResult _$result;
    try {
      _$result = _$v ??
          new _$RatelogResult._(
              tmp: tmp,
              nexttime: nexttime,
              curtime: curtime,
              ratelogs: ratelogs.build(),
              nochecknew: nochecknew);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ratelogs';
        ratelogs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RatelogResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Ratelog extends Ratelog {
  @override
  final int sortkey;
  @override
  final int uid;
  @override
  final String username;
  @override
  final String message;
  @override
  final int extcredits;
  @override
  final int score;
  @override
  final String reason;
  @override
  final String dateline;
  @override
  final int pid;

  factory _$Ratelog([void updates(RatelogBuilder b)]) =>
      (new RatelogBuilder()..update(updates)).build();

  _$Ratelog._(
      {this.sortkey,
      this.uid,
      this.username,
      this.message,
      this.extcredits,
      this.score,
      this.reason,
      this.dateline,
      this.pid})
      : super._() {
    if (uid == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'username');
    }
    if (extcredits == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'extcredits');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'score');
    }
    if (reason == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'reason');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'dateline');
    }
    if (pid == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'pid');
    }
  }

  @override
  Ratelog rebuild(void updates(RatelogBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RatelogBuilder toBuilder() => new RatelogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Ratelog &&
        sortkey == other.sortkey &&
        uid == other.uid &&
        username == other.username &&
        message == other.message &&
        extcredits == other.extcredits &&
        score == other.score &&
        reason == other.reason &&
        dateline == other.dateline &&
        pid == other.pid;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, sortkey.hashCode), uid.hashCode),
                                username.hashCode),
                            message.hashCode),
                        extcredits.hashCode),
                    score.hashCode),
                reason.hashCode),
            dateline.hashCode),
        pid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Ratelog')
          ..add('sortkey', sortkey)
          ..add('uid', uid)
          ..add('username', username)
          ..add('message', message)
          ..add('extcredits', extcredits)
          ..add('score', score)
          ..add('reason', reason)
          ..add('dateline', dateline)
          ..add('pid', pid))
        .toString();
  }
}

class RatelogBuilder implements Builder<Ratelog, RatelogBuilder> {
  _$Ratelog _$v;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  int _extcredits;
  int get extcredits => _$this._extcredits;
  set extcredits(int extcredits) => _$this._extcredits = extcredits;

  int _score;
  int get score => _$this._score;
  set score(int score) => _$this._score = score;

  String _reason;
  String get reason => _$this._reason;
  set reason(String reason) => _$this._reason = reason;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  RatelogBuilder();

  RatelogBuilder get _$this {
    if (_$v != null) {
      _sortkey = _$v.sortkey;
      _uid = _$v.uid;
      _username = _$v.username;
      _message = _$v.message;
      _extcredits = _$v.extcredits;
      _score = _$v.score;
      _reason = _$v.reason;
      _dateline = _$v.dateline;
      _pid = _$v.pid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Ratelog other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Ratelog;
  }

  @override
  void update(void updates(RatelogBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Ratelog build() {
    final _$result = _$v ??
        new _$Ratelog._(
            sortkey: sortkey,
            uid: uid,
            username: username,
            message: message,
            extcredits: extcredits,
            score: score,
            reason: reason,
            dateline: dateline,
            pid: pid);
    replace(_$result);
    return _$result;
  }
}

class _$UpvoteResult extends UpvoteResult {
  @override
  final Ratelog ratelog;
  @override
  final String type;
  @override
  final int pid;

  factory _$UpvoteResult([void updates(UpvoteResultBuilder b)]) =>
      (new UpvoteResultBuilder()..update(updates)).build();

  _$UpvoteResult._({this.ratelog, this.type, this.pid}) : super._() {
    if (ratelog == null) {
      throw new BuiltValueNullFieldError('UpvoteResult', 'ratelog');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('UpvoteResult', 'type');
    }
    if (pid == null) {
      throw new BuiltValueNullFieldError('UpvoteResult', 'pid');
    }
  }

  @override
  UpvoteResult rebuild(void updates(UpvoteResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UpvoteResultBuilder toBuilder() => new UpvoteResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpvoteResult &&
        ratelog == other.ratelog &&
        type == other.type &&
        pid == other.pid;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, ratelog.hashCode), type.hashCode), pid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UpvoteResult')
          ..add('ratelog', ratelog)
          ..add('type', type)
          ..add('pid', pid))
        .toString();
  }
}

class UpvoteResultBuilder
    implements Builder<UpvoteResult, UpvoteResultBuilder> {
  _$UpvoteResult _$v;

  RatelogBuilder _ratelog;
  RatelogBuilder get ratelog => _$this._ratelog ??= new RatelogBuilder();
  set ratelog(RatelogBuilder ratelog) => _$this._ratelog = ratelog;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  UpvoteResultBuilder();

  UpvoteResultBuilder get _$this {
    if (_$v != null) {
      _ratelog = _$v.ratelog?.toBuilder();
      _type = _$v.type;
      _pid = _$v.pid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpvoteResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UpvoteResult;
  }

  @override
  void update(void updates(UpvoteResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UpvoteResult build() {
    _$UpvoteResult _$result;
    try {
      _$result = _$v ??
          new _$UpvoteResult._(ratelog: ratelog.build(), type: type, pid: pid);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ratelog';
        ratelog.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UpvoteResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PrivateMessageResult extends PrivateMessageResult {
  @override
  final String tmp;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<PrivateMessage> messages;
  @override
  final bool nochecknew;

  factory _$PrivateMessageResult(
          [void updates(PrivateMessageResultBuilder b)]) =>
      (new PrivateMessageResultBuilder()..update(updates)).build();

  _$PrivateMessageResult._(
      {this.tmp, this.nexttime, this.curtime, this.messages, this.nochecknew})
      : super._() {
    if (tmp == null) {
      throw new BuiltValueNullFieldError('PrivateMessageResult', 'tmp');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('PrivateMessageResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('PrivateMessageResult', 'curtime');
    }
    if (messages == null) {
      throw new BuiltValueNullFieldError('PrivateMessageResult', 'messages');
    }
    if (nochecknew == null) {
      throw new BuiltValueNullFieldError('PrivateMessageResult', 'nochecknew');
    }
  }

  @override
  PrivateMessageResult rebuild(void updates(PrivateMessageResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivateMessageResultBuilder toBuilder() =>
      new PrivateMessageResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivateMessageResult &&
        tmp == other.tmp &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        messages == other.messages &&
        nochecknew == other.nochecknew;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, tmp.hashCode), nexttime.hashCode), curtime.hashCode),
            messages.hashCode),
        nochecknew.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PrivateMessageResult')
          ..add('tmp', tmp)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('messages', messages)
          ..add('nochecknew', nochecknew))
        .toString();
  }
}

class PrivateMessageResultBuilder
    implements Builder<PrivateMessageResult, PrivateMessageResultBuilder> {
  _$PrivateMessageResult _$v;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<PrivateMessage> _messages;
  ListBuilder<PrivateMessage> get messages =>
      _$this._messages ??= new ListBuilder<PrivateMessage>();
  set messages(ListBuilder<PrivateMessage> messages) =>
      _$this._messages = messages;

  bool _nochecknew;
  bool get nochecknew => _$this._nochecknew;
  set nochecknew(bool nochecknew) => _$this._nochecknew = nochecknew;

  PrivateMessageResultBuilder();

  PrivateMessageResultBuilder get _$this {
    if (_$v != null) {
      _tmp = _$v.tmp;
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _messages = _$v.messages?.toBuilder();
      _nochecknew = _$v.nochecknew;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivateMessageResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PrivateMessageResult;
  }

  @override
  void update(void updates(PrivateMessageResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PrivateMessageResult build() {
    _$PrivateMessageResult _$result;
    try {
      _$result = _$v ??
          new _$PrivateMessageResult._(
              tmp: tmp,
              nexttime: nexttime,
              curtime: curtime,
              messages: messages.build(),
              nochecknew: nochecknew);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PrivateMessageResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PrivateMessage extends PrivateMessage {
  @override
  final int uid;
  @override
  final String username;
  @override
  final int typeid;
  @override
  final int sortkey;
  @override
  final String dateline;
  @override
  final String message;
  @override
  final String id;

  factory _$PrivateMessage([void updates(PrivateMessageBuilder b)]) =>
      (new PrivateMessageBuilder()..update(updates)).build();

  _$PrivateMessage._(
      {this.uid,
      this.username,
      this.typeid,
      this.sortkey,
      this.dateline,
      this.message,
      this.id})
      : super._() {
    if (uid == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'username');
    }
    if (typeid == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'typeid');
    }
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'sortkey');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'dateline');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'message');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('PrivateMessage', 'id');
    }
  }

  @override
  PrivateMessage rebuild(void updates(PrivateMessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivateMessageBuilder toBuilder() =>
      new PrivateMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivateMessage &&
        uid == other.uid &&
        username == other.username &&
        typeid == other.typeid &&
        sortkey == other.sortkey &&
        dateline == other.dateline &&
        message == other.message &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, uid.hashCode), username.hashCode),
                        typeid.hashCode),
                    sortkey.hashCode),
                dateline.hashCode),
            message.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PrivateMessage')
          ..add('uid', uid)
          ..add('username', username)
          ..add('typeid', typeid)
          ..add('sortkey', sortkey)
          ..add('dateline', dateline)
          ..add('message', message)
          ..add('id', id))
        .toString();
  }
}

class PrivateMessageBuilder
    implements Builder<PrivateMessage, PrivateMessageBuilder> {
  _$PrivateMessage _$v;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _typeid;
  int get typeid => _$this._typeid;
  set typeid(int typeid) => _$this._typeid = typeid;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  PrivateMessageBuilder();

  PrivateMessageBuilder get _$this {
    if (_$v != null) {
      _uid = _$v.uid;
      _username = _$v.username;
      _typeid = _$v.typeid;
      _sortkey = _$v.sortkey;
      _dateline = _$v.dateline;
      _message = _$v.message;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivateMessage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PrivateMessage;
  }

  @override
  void update(void updates(PrivateMessageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$PrivateMessage build() {
    final _$result = _$v ??
        new _$PrivateMessage._(
            uid: uid,
            username: username,
            typeid: typeid,
            sortkey: sortkey,
            dateline: dateline,
            message: message,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
