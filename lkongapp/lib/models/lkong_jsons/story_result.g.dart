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

Serializer<StoryResult> _$storyResultSerializer = new _$StoryResultSerializer();
Serializer<Thread> _$threadSerializer = new _$ThreadSerializer();

class _$StoryResultSerializer implements StructuredSerializer<StoryResult> {
  @override
  final Iterable<Type> types = const [StoryResult, _$StoryResult];
  @override
  final String wireName = 'StoryResult';

  @override
  Iterable serialize(Serializers serializers, StoryResult object,
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
              const FullType(BuiltList, const [const FullType(Thread)])),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  StoryResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StoryResultBuilder();

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
                      const FullType(BuiltList, const [const FullType(Thread)]))
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

class _$ThreadSerializer implements StructuredSerializer<Thread> {
  @override
  final Iterable<Type> types = const [Thread, _$Thread];
  @override
  final String wireName = 'Thread';

  @override
  Iterable serialize(Serializers serializers, Thread object,
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
    if (object.replyNum != null) {
      result
        ..add('replynum')
        ..add(serializers.serialize(object.replyNum,
            specifiedType: const FullType(int)));
    }
    if (object.fid != null) {
      result
        ..add('fid')
        ..add(serializers.serialize(object.fid,
            specifiedType: const FullType(int)));
    }
    if (object.forumName != null) {
      result
        ..add('forumname')
        ..add(serializers.serialize(object.forumName,
            specifiedType: const FullType(String)));
    }
    if (object.author != null) {
      result
        ..add('author')
        ..add(serializers.serialize(object.author,
            specifiedType: const FullType(String)));
    }
    if (object.authorid != null) {
      result
        ..add('authorid')
        ..add(serializers.serialize(object.authorid,
            specifiedType: const FullType(int)));
    }
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
        case 'replynum':
          result.replyNum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fid':
          result.fid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'forumname':
          result.forumName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authorid':
          result.authorid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tid':
          result.tid = serializers.deserialize(value,
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
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$StoryResult extends StoryResult {
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final BuiltList<Thread> data;
  @override
  final String tmp;

  factory _$StoryResult([void updates(StoryResultBuilder b)]) =>
      (new StoryResultBuilder()..update(updates)).build();

  _$StoryResult._({this.nexttime, this.curtime, this.data, this.tmp})
      : super._() {
    if (nexttime == null) {
      throw new BuiltValueNullFieldError('StoryResult', 'nexttime');
    }
    if (curtime == null) {
      throw new BuiltValueNullFieldError('StoryResult', 'curtime');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('StoryResult', 'data');
    }
    if (tmp == null) {
      throw new BuiltValueNullFieldError('StoryResult', 'tmp');
    }
  }

  @override
  StoryResult rebuild(void updates(StoryResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryResultBuilder toBuilder() => new StoryResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryResult &&
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
    return (newBuiltValueToStringHelper('StoryResult')
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('data', data)
          ..add('tmp', tmp))
        .toString();
  }
}

class StoryResultBuilder implements Builder<StoryResult, StoryResultBuilder> {
  _$StoryResult _$v;

  int _nexttime;
  int get nexttime => _$this._nexttime;
  set nexttime(int nexttime) => _$this._nexttime = nexttime;

  int _curtime;
  int get curtime => _$this._curtime;
  set curtime(int curtime) => _$this._curtime = curtime;

  ListBuilder<Thread> _data;
  ListBuilder<Thread> get data => _$this._data ??= new ListBuilder<Thread>();
  set data(ListBuilder<Thread> data) => _$this._data = data;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  StoryResultBuilder();

  StoryResultBuilder get _$this {
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
  void replace(StoryResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryResult;
  }

  @override
  void update(void updates(StoryResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryResult build() {
    _$StoryResult _$result;
    try {
      _$result = _$v ??
          new _$StoryResult._(
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
            'StoryResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Thread extends Thread {
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
  final int replyNum;
  @override
  final String subject;
  @override
  final int fid;
  @override
  final String forumName;
  @override
  final String author;
  @override
  final int authorid;
  @override
  final String tid;
  @override
  final String tAuthor;
  @override
  final int tAuthorid;
  @override
  final int tReplynum;
  @override
  final String id;
  @override
  final int sortkey;

  factory _$Thread([void updates(ThreadBuilder b)]) =>
      (new ThreadBuilder()..update(updates)).build();

  _$Thread._(
      {this.isquote,
      this.uid,
      this.username,
      this.dateline,
      this.message,
      this.isthread,
      this.replyNum,
      this.subject,
      this.fid,
      this.forumName,
      this.author,
      this.authorid,
      this.tid,
      this.tAuthor,
      this.tAuthorid,
      this.tReplynum,
      this.id,
      this.sortkey})
      : super._() {
    if (isquote == null) {
      throw new BuiltValueNullFieldError('Thread', 'isquote');
    }
    if (uid == null) {
      throw new BuiltValueNullFieldError('Thread', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Thread', 'username');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Thread', 'dateline');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Thread', 'message');
    }
    if (isthread == null) {
      throw new BuiltValueNullFieldError('Thread', 'isthread');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('Thread', 'subject');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Thread', 'id');
    }
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Thread', 'sortkey');
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
        isquote == other.isquote &&
        uid == other.uid &&
        username == other.username &&
        dateline == other.dateline &&
        message == other.message &&
        isthread == other.isthread &&
        replyNum == other.replyNum &&
        subject == other.subject &&
        fid == other.fid &&
        forumName == other.forumName &&
        author == other.author &&
        authorid == other.authorid &&
        tid == other.tid &&
        tAuthor == other.tAuthor &&
        tAuthorid == other.tAuthorid &&
        tReplynum == other.tReplynum &&
        id == other.id &&
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
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            0,
                                                                            isquote
                                                                                .hashCode),
                                                                        uid
                                                                            .hashCode),
                                                                    username
                                                                        .hashCode),
                                                                dateline
                                                                    .hashCode),
                                                            message.hashCode),
                                                        isthread.hashCode),
                                                    replyNum.hashCode),
                                                subject.hashCode),
                                            fid.hashCode),
                                        forumName.hashCode),
                                    author.hashCode),
                                authorid.hashCode),
                            tid.hashCode),
                        tAuthor.hashCode),
                    tAuthorid.hashCode),
                tReplynum.hashCode),
            id.hashCode),
        sortkey.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Thread')
          ..add('isquote', isquote)
          ..add('uid', uid)
          ..add('username', username)
          ..add('dateline', dateline)
          ..add('message', message)
          ..add('isthread', isthread)
          ..add('replyNum', replyNum)
          ..add('subject', subject)
          ..add('fid', fid)
          ..add('forumName', forumName)
          ..add('author', author)
          ..add('authorid', authorid)
          ..add('tid', tid)
          ..add('tAuthor', tAuthor)
          ..add('tAuthorid', tAuthorid)
          ..add('tReplynum', tReplynum)
          ..add('id', id)
          ..add('sortkey', sortkey))
        .toString();
  }
}

class ThreadBuilder implements Builder<Thread, ThreadBuilder> {
  _$Thread _$v;

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

  int _replyNum;
  int get replyNum => _$this._replyNum;
  set replyNum(int replyNum) => _$this._replyNum = replyNum;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  String _forumName;
  String get forumName => _$this._forumName;
  set forumName(String forumName) => _$this._forumName = forumName;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  int _authorid;
  int get authorid => _$this._authorid;
  set authorid(int authorid) => _$this._authorid = authorid;

  String _tid;
  String get tid => _$this._tid;
  set tid(String tid) => _$this._tid = tid;

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

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  ThreadBuilder();

  ThreadBuilder get _$this {
    if (_$v != null) {
      _isquote = _$v.isquote;
      _uid = _$v.uid;
      _username = _$v.username;
      _dateline = _$v.dateline;
      _message = _$v.message;
      _isthread = _$v.isthread;
      _replyNum = _$v.replyNum;
      _subject = _$v.subject;
      _fid = _$v.fid;
      _forumName = _$v.forumName;
      _author = _$v.author;
      _authorid = _$v.authorid;
      _tid = _$v.tid;
      _tAuthor = _$v.tAuthor;
      _tAuthorid = _$v.tAuthorid;
      _tReplynum = _$v.tReplynum;
      _id = _$v.id;
      _sortkey = _$v.sortkey;
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
            isquote: isquote,
            uid: uid,
            username: username,
            dateline: dateline,
            message: message,
            isthread: isthread,
            replyNum: replyNum,
            subject: subject,
            fid: fid,
            forumName: forumName,
            author: author,
            authorid: authorid,
            tid: tid,
            tAuthor: tAuthor,
            tAuthorid: tAuthorid,
            tReplynum: tReplynum,
            id: id,
            sortkey: sortkey);
    replace(_$result);
    return _$result;
  }
}
