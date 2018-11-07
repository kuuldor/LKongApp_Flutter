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
Serializer<ForumStoryResult> _$forumStoryResultSerializer =
    new _$ForumStoryResultSerializer();
Serializer<Thread> _$threadSerializer = new _$ThreadSerializer();
Serializer<StoryInfoResult> _$storyInfoResultSerializer =
    new _$StoryInfoResultSerializer();

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
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Story)])),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
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
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
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
              specifiedType: const FullType(int)) as int;
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

class _$ForumStoryResultSerializer
    implements StructuredSerializer<ForumStoryResult> {
  @override
  final Iterable<Type> types = const [ForumStoryResult, _$ForumStoryResult];
  @override
  final String wireName = 'ForumStoryResult';

  @override
  Iterable serialize(Serializers serializers, ForumStoryResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Thread)])),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
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
  ForumStoryResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ForumStoryResultBuilder();

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

class _$StoryInfoResultSerializer
    implements StructuredSerializer<StoryInfoResult> {
  @override
  final Iterable<Type> types = const [StoryInfoResult, _$StoryInfoResult];
  @override
  final String wireName = 'StoryInfoResult';

  @override
  Iterable serialize(Serializers serializers, StoryInfoResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'fid',
      serializers.serialize(object.fid, specifiedType: const FullType(int)),
      'tid',
      serializers.serialize(object.tid, specifiedType: const FullType(int)),
      'subject',
      serializers.serialize(object.subject,
          specifiedType: const FullType(String)),
      'views',
      serializers.serialize(object.views, specifiedType: const FullType(int)),
      'replies',
      serializers.serialize(object.replies, specifiedType: const FullType(int)),
      'forumname',
      serializers.serialize(object.forumname,
          specifiedType: const FullType(String)),
      'digest',
      serializers.serialize(object.digest, specifiedType: const FullType(bool)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)),
      'authorid',
      serializers.serialize(object.authorid,
          specifiedType: const FullType(int)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isok',
      serializers.serialize(object.isok, specifiedType: const FullType(bool)),
    ];
    if (object.uid != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(int)));
    }
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  StoryInfoResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StoryInfoResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'fid':
          result.fid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tid':
          result.tid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'subject':
          result.subject = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'views':
          result.views = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'replies':
          result.replies = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'forumname':
          result.forumname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'digest':
          result.digest = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
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
        case 'authorid':
          result.authorid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
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
  final int uid;
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

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

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

class _$ForumStoryResult extends ForumStoryResult {
  @override
  final BuiltList<Thread> data;
  @override
  final int nexttime;
  @override
  final int curtime;
  @override
  final String tmp;

  factory _$ForumStoryResult([void updates(ForumStoryResultBuilder b)]) =>
      (new ForumStoryResultBuilder()..update(updates)).build();

  _$ForumStoryResult._({this.data, this.nexttime, this.curtime, this.tmp})
      : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ForumStoryResult', 'data');
    }
    if (tmp == null) {
      throw new BuiltValueNullFieldError('ForumStoryResult', 'tmp');
    }
  }

  @override
  ForumStoryResult rebuild(void updates(ForumStoryResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumStoryResultBuilder toBuilder() =>
      new ForumStoryResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForumStoryResult &&
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
    return (newBuiltValueToStringHelper('ForumStoryResult')
          ..add('data', data)
          ..add('nexttime', nexttime)
          ..add('curtime', curtime)
          ..add('tmp', tmp))
        .toString();
  }
}

class ForumStoryResultBuilder
    implements Builder<ForumStoryResult, ForumStoryResultBuilder> {
  _$ForumStoryResult _$v;

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

  ForumStoryResultBuilder();

  ForumStoryResultBuilder get _$this {
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
  void replace(ForumStoryResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ForumStoryResult;
  }

  @override
  void update(void updates(ForumStoryResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ForumStoryResult build() {
    _$ForumStoryResult _$result;
    try {
      _$result = _$v ??
          new _$ForumStoryResult._(
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
            'ForumStoryResult', _$failedField, e.toString());
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

class _$StoryInfoResult extends StoryInfoResult {
  @override
  final int fid;
  @override
  final int tid;
  @override
  final String subject;
  @override
  final int views;
  @override
  final int replies;
  @override
  final String forumname;
  @override
  final bool digest;
  @override
  final int timestamp;
  @override
  final int uid;
  @override
  final String username;
  @override
  final int authorid;
  @override
  final String author;
  @override
  final String dateline;
  @override
  final String id;
  @override
  final bool isok;

  factory _$StoryInfoResult([void updates(StoryInfoResultBuilder b)]) =>
      (new StoryInfoResultBuilder()..update(updates)).build();

  _$StoryInfoResult._(
      {this.fid,
      this.tid,
      this.subject,
      this.views,
      this.replies,
      this.forumname,
      this.digest,
      this.timestamp,
      this.uid,
      this.username,
      this.authorid,
      this.author,
      this.dateline,
      this.id,
      this.isok})
      : super._() {
    if (fid == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'fid');
    }
    if (tid == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'tid');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'subject');
    }
    if (views == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'views');
    }
    if (replies == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'replies');
    }
    if (forumname == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'forumname');
    }
    if (digest == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'digest');
    }
    if (timestamp == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'timestamp');
    }
    if (authorid == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'authorid');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'author');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'dateline');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'id');
    }
    if (isok == null) {
      throw new BuiltValueNullFieldError('StoryInfoResult', 'isok');
    }
  }

  @override
  StoryInfoResult rebuild(void updates(StoryInfoResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryInfoResultBuilder toBuilder() =>
      new StoryInfoResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryInfoResult &&
        fid == other.fid &&
        tid == other.tid &&
        subject == other.subject &&
        views == other.views &&
        replies == other.replies &&
        forumname == other.forumname &&
        digest == other.digest &&
        timestamp == other.timestamp &&
        uid == other.uid &&
        username == other.username &&
        authorid == other.authorid &&
        author == other.author &&
        dateline == other.dateline &&
        id == other.id &&
        isok == other.isok;
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
                                                            $jc(0,
                                                                fid.hashCode),
                                                            tid.hashCode),
                                                        subject.hashCode),
                                                    views.hashCode),
                                                replies.hashCode),
                                            forumname.hashCode),
                                        digest.hashCode),
                                    timestamp.hashCode),
                                uid.hashCode),
                            username.hashCode),
                        authorid.hashCode),
                    author.hashCode),
                dateline.hashCode),
            id.hashCode),
        isok.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryInfoResult')
          ..add('fid', fid)
          ..add('tid', tid)
          ..add('subject', subject)
          ..add('views', views)
          ..add('replies', replies)
          ..add('forumname', forumname)
          ..add('digest', digest)
          ..add('timestamp', timestamp)
          ..add('uid', uid)
          ..add('username', username)
          ..add('authorid', authorid)
          ..add('author', author)
          ..add('dateline', dateline)
          ..add('id', id)
          ..add('isok', isok))
        .toString();
  }
}

class StoryInfoResultBuilder
    implements Builder<StoryInfoResult, StoryInfoResultBuilder> {
  _$StoryInfoResult _$v;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  int _tid;
  int get tid => _$this._tid;
  set tid(int tid) => _$this._tid = tid;

  String _subject;
  String get subject => _$this._subject;
  set subject(String subject) => _$this._subject = subject;

  int _views;
  int get views => _$this._views;
  set views(int views) => _$this._views = views;

  int _replies;
  int get replies => _$this._replies;
  set replies(int replies) => _$this._replies = replies;

  String _forumname;
  String get forumname => _$this._forumname;
  set forumname(String forumname) => _$this._forumname = forumname;

  bool _digest;
  bool get digest => _$this._digest;
  set digest(bool digest) => _$this._digest = digest;

  int _timestamp;
  int get timestamp => _$this._timestamp;
  set timestamp(int timestamp) => _$this._timestamp = timestamp;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _authorid;
  int get authorid => _$this._authorid;
  set authorid(int authorid) => _$this._authorid = authorid;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _isok;
  bool get isok => _$this._isok;
  set isok(bool isok) => _$this._isok = isok;

  StoryInfoResultBuilder();

  StoryInfoResultBuilder get _$this {
    if (_$v != null) {
      _fid = _$v.fid;
      _tid = _$v.tid;
      _subject = _$v.subject;
      _views = _$v.views;
      _replies = _$v.replies;
      _forumname = _$v.forumname;
      _digest = _$v.digest;
      _timestamp = _$v.timestamp;
      _uid = _$v.uid;
      _username = _$v.username;
      _authorid = _$v.authorid;
      _author = _$v.author;
      _dateline = _$v.dateline;
      _id = _$v.id;
      _isok = _$v.isok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryInfoResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryInfoResult;
  }

  @override
  void update(void updates(StoryInfoResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryInfoResult build() {
    final _$result = _$v ??
        new _$StoryInfoResult._(
            fid: fid,
            tid: tid,
            subject: subject,
            views: views,
            replies: replies,
            forumname: forumname,
            digest: digest,
            timestamp: timestamp,
            uid: uid,
            username: username,
            authorid: authorid,
            author: author,
            dateline: dateline,
            id: id,
            isok: isok);
    replace(_$result);
    return _$result;
  }
}
