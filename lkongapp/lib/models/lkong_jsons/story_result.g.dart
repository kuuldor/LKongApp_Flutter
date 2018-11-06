// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_result.dart';

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

Serializer<HomeListResult> _$homeListResultSerializer =
    new _$HomeListResultSerializer();
Serializer<Story> _$storySerializer = new _$StorySerializer();
Serializer<ForumListResult> _$forumListResultSerializer =
    new _$ForumListResultSerializer();
Serializer<Thread> _$threadSerializer = new _$ThreadSerializer();

class _$HomeListResultSerializer
    implements StructuredSerializer<HomeListResult> {
  @override
  final Iterable<Type> types = const [HomeListResult, _$HomeListResult];
  @override
  final String wireName = 'HomeListResult';

  @override
  Iterable serialize(Serializers serializers, HomeListResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'curtime',
      serializers.serialize(object.curtime, specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Story)])),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  HomeListResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HomeListResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'nexttime':
          result.nexttime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'curtime':
          result.curtime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Story)]))
              as BuiltList);
          break;
        case 'tmp':
          result.tmp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$StorySerializer implements StructuredSerializer<Story> {
  @override
  final Iterable<Type> types = const [Story, _$Story];
  @override
  final String wireName = 'Story';

  @override
  Iterable serialize(Serializers serializers, Story object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'isquote',
      serializers.serialize(object.isquote,
          specifiedType: const FullType(bool)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'isthread',
      serializers.serialize(object.isthread,
          specifiedType: const FullType(bool)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'sortkey',
      serializers.serialize(object.sortkey, specifiedType: const FullType(int)),
    ];
    if (object.tid != null) {
      result
        ..add('tid')
        ..add(serializers.serialize(object.tid,
            specifiedType: const FullType(String)));
    }
    if (object.tAuthor != null) {
      result
        ..add('t_author')
        ..add(serializers.serialize(object.tAuthor,
            specifiedType: const FullType(String)));
    }
    if (object.tAuthorid != null) {
      result
        ..add('t_authorid')
        ..add(serializers.serialize(object.tAuthorid,
            specifiedType: const FullType(int)));
    }
    if (object.tReplynum != null) {
      result
        ..add('t_replynum')
        ..add(serializers.serialize(object.tReplynum,
            specifiedType: const FullType(int)));
    }
    if (object.replynum != null) {
      result
        ..add('replynum')
        ..add(serializers.serialize(object.replynum,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  Story deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isquote':
          result.isquote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isthread':
          result.isthread = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'tid':
          result.tid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 't_author':
          result.tAuthor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 't_authorid':
          result.tAuthorid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 't_replynum':
          result.tReplynum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'replynum':
          result.replynum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ForumListResultSerializer
    implements StructuredSerializer<ForumListResult> {
  @override
  final Iterable<Type> types = const [ForumListResult, _$ForumListResult];
  @override
  final String wireName = 'ForumListResult';

  @override
  Iterable serialize(Serializers serializers, ForumListResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Thread)])),
      'nexttime',
      serializers.serialize(object.nexttime,
          specifiedType: const FullType(int)),
      'curtime',
      serializers.serialize(object.curtime, specifiedType: const FullType(int)),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ForumListResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ForumListResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Thread)]))
              as BuiltList);
          break;
        case 'nexttime':
          result.nexttime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'curtime':
          result.curtime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tmp':
          result.tmp = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
      'sortkey',
      serializers.serialize(object.sortkey, specifiedType: const FullType(int)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'digest',
      serializers.serialize(object.digest, specifiedType: const FullType(int)),
      'closed',
      serializers.serialize(object.closed, specifiedType: const FullType(int)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'replynum',
      serializers.serialize(object.replynum,
          specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'fid',
      serializers.serialize(object.fid, specifiedType: const FullType(int)),
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
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'digest':
          result.digest = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'closed':
          result.closed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'replynum':
          result.replynum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fid':
          result.fid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$HomeListResult extends HomeListResult {
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<Story> data;
  @override
  final String tmp;

  factory _$HomeListResult([void updates(HomeListResultBuilder b)]) =>
      (new HomeListResultBuilder()..update(updates)).build();

  _$HomeListResult._({this.nexttime, this.curtime, this.data, this.tmp})
      : super._() {
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('HomeListResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('HomeListResult', 'curtime');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('HomeListResult', 'data');
    }
    if (tmp == null) {
      throw new BuiltValueNullFieldError('HomeListResult', 'tmp');
    }
  }

  @override
  HomeListResult rebuild(void updates(HomeListResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeListResultBuilder toBuilder() =>
      new HomeListResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeListResult &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        data == other.data &&
        tmp == other.tmp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, nexttime.hashCode), curtime.hashCode), data.hashCode),
        tmp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeListResult')
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('data', data)
          ..add('tmp', tmp))
        .toString();
  }
}

class HomeListResultBuilder
    implements Builder<HomeListResult, HomeListResultBuilder> {
  _$HomeListResult _$v;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<Story> _data;
  ListBuilder<Story> get data => _$this._data ??= new ListBuilder<Story>();
  set data(ListBuilder<Story> data) => _$this._data = data;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  HomeListResultBuilder();

  HomeListResultBuilder get _$this {
    if (_$v != null) {
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _data = _$v.data?.toBuilder();
      _tmp = _$v.tmp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeListResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomeListResult;
  }

  @override
  void update(void updates(HomeListResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeListResult build() {
    _$HomeListResult _$result;
    try {
      _$result = _$v ??
          new _$HomeListResult._(
              nexttime: nexttime,
              curtime: curtime,
              data: data.build(),
              tmp: tmp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomeListResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Story extends Story {
  @override
  final bool isquote;
  @override
  final String uid;
  @override
  final String username;
  @override
  final String dateline;
  @override
  final String message;
  @override
  final bool isthread;
  @override
  final String tid;
  @override
  final String subject;
  @override
  final String tAuthor;
  @override
  final int tAuthorid;
  @override
  final int tReplynum;
  @override
  final String id;
  @override
  final int replynum;
  @override
  final int sortkey;

  factory _$Story([void updates(StoryBuilder b)]) =>
      (new StoryBuilder()..update(updates)).build();

  _$Story._(
      {this.isquote,
      this.uid,
      this.username,
      this.dateline,
      this.message,
      this.isthread,
      this.tid,
      this.subject,
      this.tAuthor,
      this.tAuthorid,
      this.tReplynum,
      this.id,
      this.replynum,
      this.sortkey})
      : super._() {
    if (isquote == null) {
      throw new BuiltValueNullFieldError('Story', 'isquote');
    }
    if (uid == null) {
      throw new BuiltValueNullFieldError('Story', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Story', 'username');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Story', 'dateline');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Story', 'message');
    }
    if (isthread == null) {
      throw new BuiltValueNullFieldError('Story', 'isthread');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('Story', 'subject');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Story', 'id');
    }
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Story', 'sortkey');
    }
  }

  @override
  Story rebuild(void updates(StoryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryBuilder toBuilder() => new StoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Story &&
        isquote == other.isquote &&
        uid == other.uid &&
        username == other.username &&
        dateline == other.dateline &&
        message == other.message &&
        isthread == other.isthread &&
        tid == other.tid &&
        subject == other.subject &&
        tAuthor == other.tAuthor &&
        tAuthorid == other.tAuthorid &&
        tReplynum == other.tReplynum &&
        id == other.id &&
        replynum == other.replynum &&
        sortkey == other.sortkey;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(0,
                                                            isquote.hashCode),
                                                        uid.hashCode),
                                                    username.hashCode),
                                                dateline.hashCode),
                                            message.hashCode),
                                        isthread.hashCode),
                                    tid.hashCode),
                                subject.hashCode),
                            tAuthor.hashCode),
                        tAuthorid.hashCode),
                    tReplynum.hashCode),
                id.hashCode),
            replynum.hashCode),
        sortkey.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Story')
          ..add('isquote', isquote)
          ..add('uid', uid)
          ..add('username', username)
          ..add('dateline', dateline)
          ..add('message', message)
          ..add('isthread', isthread)
          ..add('tid', tid)
          ..add('subject', subject)
          ..add('tAuthor', tAuthor)
          ..add('tAuthorid', tAuthorid)
          ..add('tReplynum', tReplynum)
          ..add('id', id)
          ..add('replynum', replynum)
          ..add('sortkey', sortkey))
        .toString();
  }
}

class StoryBuilder implements Builder<Story, StoryBuilder> {
  _$Story _$v;

  bool _isquote;
  bool get isquote => _$this._isquote;
  set isquote(bool isquote) => _$this._isquote = isquote;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  bool _isthread;
  bool get isthread => _$this._isthread;
  set isthread(bool isthread) => _$this._isthread = isthread;

  String _tid;
  String get tid => _$this._tid;
  set tid(String tid) => _$this._tid = tid;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  String _tAuthor;
  String get tAuthor => _$this._tAuthor;
  set tAuthor(String tAuthor) => _$this._tAuthor = tAuthor;

  int _tAuthorid;
  int get tAuthorid => _$this._tAuthorid;
  set tAuthorid(int tAuthorid) => _$this._tAuthorid = tAuthorid;

  int _tReplynum;
  int get tReplynum => _$this._tReplynum;
  set tReplynum(int tReplynum) => _$this._tReplynum = tReplynum;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _replynum;
  int get replynum => _$this._replynum;
  set replynum(int replynum) => _$this._replynum = replynum;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  StoryBuilder();

  StoryBuilder get _$this {
    if (_$v != null) {
      _isquote = _$v.isquote;
      _uid = _$v.uid;
      _username = _$v.username;
      _dateline = _$v.dateline;
      _message = _$v.message;
      _isthread = _$v.isthread;
      _tid = _$v.tid;
      _subject = _$v.subject;
      _tAuthor = _$v.tAuthor;
      _tAuthorid = _$v.tAuthorid;
      _tReplynum = _$v.tReplynum;
      _id = _$v.id;
      _replynum = _$v.replynum;
      _sortkey = _$v.sortkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Story other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Story;
  }

  @override
  void update(void updates(StoryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Story build() {
    final _$result = _$v ??
        new _$Story._(
            isquote: isquote,
            uid: uid,
            username: username,
            dateline: dateline,
            message: message,
            isthread: isthread,
            tid: tid,
            subject: subject,
            tAuthor: tAuthor,
            tAuthorid: tAuthorid,
            tReplynum: tReplynum,
            id: id,
            replynum: replynum,
            sortkey: sortkey);
    replace(_$result);
    return _$result;
  }
}

class _$ForumListResult extends ForumListResult {
  @override
  final BuiltList<Thread> data;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final String tmp;

  factory _$ForumListResult([void updates(ForumListResultBuilder b)]) =>
      (new ForumListResultBuilder()..update(updates)).build();

  _$ForumListResult._({this.data, this.nexttime, this.curtime, this.tmp})
      : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'data');
    }
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'curtime');
    }
    if (tmp == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'tmp');
    }
  }

  @override
  ForumListResult rebuild(void updates(ForumListResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumListResultBuilder toBuilder() =>
      new ForumListResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForumListResult &&
        data == other.data &&
        nexttime == other.nexttime &&
        curtime == other.curtime &&
        tmp == other.tmp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, data.hashCode), nexttime.hashCode), curtime.hashCode),
        tmp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForumListResult')
          ..add('data', data)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('tmp', tmp))
        .toString();
  }
}

class ForumListResultBuilder
    implements Builder<ForumListResult, ForumListResultBuilder> {
  _$ForumListResult _$v;

  ListBuilder<Thread> _data;
  ListBuilder<Thread> get data => _$this._data ??= new ListBuilder<Thread>();
  set data(ListBuilder<Thread> data) => _$this._data = data;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  ForumListResultBuilder();

  ForumListResultBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _nexttime = _$v.nexttime;
      _curtime = _$v.curtime;
      _tmp = _$v.tmp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForumListResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ForumListResult;
  }

  @override
  void update(void updates(ForumListResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ForumListResult build() {
    _$ForumListResult _$result;
    try {
      _$result = _$v ??
          new _$ForumListResult._(
              data: data.build(),
              nexttime: nexttime,
              curtime: curtime,
              tmp: tmp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ForumListResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Thread extends Thread {
  @override
  final int sortkey;
  @override
  final String dateline;
  @override
  final String subject;
  @override
  final String username;
  @override
  final int digest;
  @override
  final int closed;
  @override
  final int uid;
  @override
  final int replynum;
  @override
  final String id;
  @override
  final int fid;

  factory _$Thread([void updates(ThreadBuilder b)]) =>
      (new ThreadBuilder()..update(updates)).build();

  _$Thread._(
      {this.sortkey,
      this.dateline,
      this.subject,
      this.username,
      this.digest,
      this.closed,
      this.uid,
      this.replynum,
      this.id,
      this.fid})
      : super._() {
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Thread', 'sortkey');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Thread', 'dateline');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('Thread', 'subject');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Thread', 'username');
    }
    if (digest == null) {
      throw new BuiltValueNullFieldError('Thread', 'digest');
    }
    if (closed == null) {
      throw new BuiltValueNullFieldError('Thread', 'closed');
    }
    if (uid == null) {
      throw new BuiltValueNullFieldError('Thread', 'uid');
    }
    if (replynum == null) {
      throw new BuiltValueNullFieldError('Thread', 'replynum');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Thread', 'id');
    }
    if (fid == null) {
      throw new BuiltValueNullFieldError('Thread', 'fid');
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
    return other is Thread &&
        sortkey == other.sortkey &&
        dateline == other.dateline &&
        subject == other.subject &&
        username == other.username &&
        digest == other.digest &&
        closed == other.closed &&
        uid == other.uid &&
        replynum == other.replynum &&
        id == other.id &&
        fid == other.fid;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, sortkey.hashCode),
                                        dateline.hashCode),
                                    subject.hashCode),
                                username.hashCode),
                            digest.hashCode),
                        closed.hashCode),
                    uid.hashCode),
                replynum.hashCode),
            id.hashCode),
        fid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Thread')
          ..add('sortkey', sortkey)
          ..add('dateline', dateline)
          ..add('subject', subject)
          ..add('username', username)
          ..add('digest', digest)
          ..add('closed', closed)
          ..add('uid', uid)
          ..add('replynum', replynum)
          ..add('id', id)
          ..add('fid', fid))
        .toString();
  }
}

class ThreadBuilder implements Builder<Thread, ThreadBuilder> {
  _$Thread _$v;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _digest;
  int get digest => _$this._digest;
  set digest(int digest) => _$this._digest = digest;

  int _closed;
  int get closed => _$this._closed;
  set closed(int closed) => _$this._closed = closed;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  int _replynum;
  int get replynum => _$this._replynum;
  set replynum(int replynum) => _$this._replynum = replynum;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  ThreadBuilder();

  ThreadBuilder get _$this {
    if (_$v != null) {
      _sortkey = _$v.sortkey;
      _dateline = _$v.dateline;
      _subject = _$v.subject;
      _username = _$v.username;
      _digest = _$v.digest;
      _closed = _$v.closed;
      _uid = _$v.uid;
      _replynum = _$v.replynum;
      _id = _$v.id;
      _fid = _$v.fid;
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
    final _$result = _$v ??
        new _$Thread._(
            sortkey: sortkey,
            dateline: dateline,
            subject: subject,
            username: username,
            digest: digest,
            closed: closed,
            uid: uid,
            replynum: replynum,
            id: id,
            fid: fid);
    replace(_$result);
    return _$result;
  }
}
