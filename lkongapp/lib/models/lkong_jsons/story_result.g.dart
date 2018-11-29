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
Serializer<StoryInfoResult> _$storyInfoResultSerializer =
    new _$StoryInfoResultSerializer();
Serializer<StoryContentResult> _$storyContentResultSerializer =
    new _$StoryContentResultSerializer();
Serializer<Comment> _$commentSerializer = new _$CommentSerializer();
Serializer<Ratelog> _$ratelogSerializer = new _$RatelogSerializer();

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
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    if (object.digest != null) {
      result
        ..add('digest')
        ..add(serializers.serialize(object.digest,
            specifiedType: const FullType(int)));
    }
    if (object.closed != null) {
      result
        ..add('closed')
        ..add(serializers.serialize(object.closed,
            specifiedType: const FullType(int)));
    }
    if (object.fid != null) {
      result
        ..add('fid')
        ..add(serializers.serialize(object.fid,
            specifiedType: const FullType(int)));
    }
    if (object.isquote != null) {
      result
        ..add('isquote')
        ..add(serializers.serialize(object.isquote,
            specifiedType: const FullType(bool)));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
            specifiedType: const FullType(String)));
    }
    if (object.isthread != null) {
      result
        ..add('isthread')
        ..add(serializers.serialize(object.isthread,
            specifiedType: const FullType(bool)));
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fid':
          result.fid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isquote':
          result.isquote = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
        case 'replynum':
          result.replynum = serializers.deserialize(value,
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
                      const FullType(BuiltList, const [const FullType(Story)]))
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

class _$StoryContentResultSerializer
    implements StructuredSerializer<StoryContentResult> {
  @override
  final Iterable<Type> types = const [StoryContentResult, _$StoryContentResult];
  @override
  final String wireName = 'StoryContentResult';

  @override
  Iterable serialize(Serializers serializers, StoryContentResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'replies',
      serializers.serialize(object.replies, specifiedType: const FullType(int)),
      'page',
      serializers.serialize(object.page, specifiedType: const FullType(int)),
      'data',
      serializers.serialize(object.comments,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Comment)])),
      'isend',
      serializers.serialize(object.isend, specifiedType: const FullType(int)),
      'loadtime',
      serializers.serialize(object.loadtime,
          specifiedType: const FullType(int)),
      'tmp',
      serializers.serialize(object.tmp, specifiedType: const FullType(String)),
    ];
    if (object.isfull != null) {
      result
        ..add('isfull')
        ..add(serializers.serialize(object.isfull,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  StoryContentResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StoryContentResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'isfull':
          result.isfull = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'replies':
          result.replies = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'page':
          result.page = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'data':
          result.comments.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Comment)])) as BuiltList);
          break;
        case 'isend':
          result.isend = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'loadtime':
          result.loadtime = serializers.deserialize(value,
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

class _$CommentSerializer implements StructuredSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];
  @override
  final String wireName = 'Comment';

  @override
  Iterable serialize(Serializers serializers, Comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'fid',
      serializers.serialize(object.fid, specifiedType: const FullType(int)),
      'sortkey',
      serializers.serialize(object.sortkey, specifiedType: const FullType(int)),
      'warning',
      serializers.serialize(object.warning,
          specifiedType: const FullType(bool)),
      'warningreason',
      serializers.serialize(object.warningReason,
          specifiedType: const FullType(String)),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'authorid',
      serializers.serialize(object.authorid,
          specifiedType: const FullType(int)),
      'isme',
      serializers.serialize(object.isme, specifiedType: const FullType(int)),
      'notgroup',
      serializers.serialize(object.notgroup,
          specifiedType: const FullType(int)),
      'pid',
      serializers.serialize(object.pid, specifiedType: const FullType(int)),
      'first',
      serializers.serialize(object.first, specifiedType: const FullType(int)),
      'status',
      serializers.serialize(object.status, specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'tsadmin',
      serializers.serialize(object.tsadmin,
          specifiedType: const FullType(bool)),
      'isadmin',
      serializers.serialize(object.isadmin, specifiedType: const FullType(int)),
      'lou',
      serializers.serialize(object.lou, specifiedType: const FullType(int)),
    ];
    if (object.tid != null) {
      result
        ..add('tid')
        ..add(serializers.serialize(object.tid,
            specifiedType: const FullType(int)));
    }
    if (object.ratelog != null) {
      result
        ..add('ratelog')
        ..add(serializers.serialize(object.ratelog,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Ratelog)])));
    }

    return result;
  }

  @override
  Comment deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentBuilder();

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
        case 'sortkey':
          result.sortkey = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'warning':
          result.warning = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'warningreason':
          result.warningReason = serializers.deserialize(value,
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
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'authorid':
          result.authorid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isme':
          result.isme = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'notgroup':
          result.notgroup = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'first':
          result.first = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tsadmin':
          result.tsadmin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isadmin':
          result.isadmin = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lou':
          result.lou = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tid':
          result.tid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ratelog':
          result.ratelog.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Ratelog)])) as BuiltList);
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
      '_id',
      serializers.serialize(object.id,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'dateline',
      serializers.serialize(object.dateline,
          specifiedType: const FullType(String)),
      'extcredits',
      serializers.serialize(object.extcredits,
          specifiedType: const FullType(int)),
      'pid',
      serializers.serialize(object.pid, specifiedType: const FullType(int)),
      'reason',
      serializers.serialize(object.reason,
          specifiedType: const FullType(String)),
      'score',
      serializers.serialize(object.score, specifiedType: const FullType(int)),
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(int)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];

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
        case '_id':
          result.id.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap);
          break;
        case 'dateline':
          result.dateline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'extcredits':
          result.extcredits = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'reason':
          result.reason = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
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
  final String id;
  @override
  final int fid;
  @override
  final bool isquote;
  @override
  final String message;
  @override
  final bool isthread;
  @override
  final String tid;
  @override
  final String tAuthor;
  @override
  final int tAuthorid;
  @override
  final int tReplynum;
  @override
  final int replynum;

  factory _$Story([void updates(StoryBuilder b)]) =>
      (new StoryBuilder()..update(updates)).build();

  _$Story._(
      {this.sortkey,
      this.dateline,
      this.subject,
      this.username,
      this.digest,
      this.closed,
      this.uid,
      this.id,
      this.fid,
      this.isquote,
      this.message,
      this.isthread,
      this.tid,
      this.tAuthor,
      this.tAuthorid,
      this.tReplynum,
      this.replynum})
      : super._() {
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Story', 'sortkey');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Story', 'dateline');
    }
    if (subject == null) {
      throw new BuiltValueNullFieldError('Story', 'subject');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Story', 'username');
    }
    if (uid == null) {
      throw new BuiltValueNullFieldError('Story', 'uid');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Story', 'id');
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
        sortkey == other.sortkey &&
        dateline == other.dateline &&
        subject == other.subject &&
        username == other.username &&
        digest == other.digest &&
        closed == other.closed &&
        uid == other.uid &&
        id == other.id &&
        fid == other.fid &&
        isquote == other.isquote &&
        message == other.message &&
        isthread == other.isthread &&
        tid == other.tid &&
        tAuthor == other.tAuthor &&
        tAuthorid == other.tAuthorid &&
        tReplynum == other.tReplynum &&
        replynum == other.replynum;
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
                                                                        0,
                                                                        sortkey
                                                                            .hashCode),
                                                                    dateline
                                                                        .hashCode),
                                                                subject
                                                                    .hashCode),
                                                            username.hashCode),
                                                        digest.hashCode),
                                                    closed.hashCode),
                                                uid.hashCode),
                                            id.hashCode),
                                        fid.hashCode),
                                    isquote.hashCode),
                                message.hashCode),
                            isthread.hashCode),
                        tid.hashCode),
                    tAuthor.hashCode),
                tAuthorid.hashCode),
            tReplynum.hashCode),
        replynum.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Story')
          ..add('sortkey', sortkey)
          ..add('dateline', dateline)
          ..add('subject', subject)
          ..add('username', username)
          ..add('digest', digest)
          ..add('closed', closed)
          ..add('uid', uid)
          ..add('id', id)
          ..add('fid', fid)
          ..add('isquote', isquote)
          ..add('message', message)
          ..add('isthread', isthread)
          ..add('tid', tid)
          ..add('tAuthor', tAuthor)
          ..add('tAuthorid', tAuthorid)
          ..add('tReplynum', tReplynum)
          ..add('replynum', replynum))
        .toString();
  }
}

class StoryBuilder implements Builder<Story, StoryBuilder> {
  _$Story _$v;

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

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  bool _isquote;
  bool get isquote => _$this._isquote;
  set isquote(bool isquote) => _$this._isquote = isquote;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  bool _isthread;
  bool get isthread => _$this._isthread;
  set isthread(bool isthread) => _$this._isthread = isthread;

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

  int _replynum;
  int get replynum => _$this._replynum;
  set replynum(int replynum) => _$this._replynum = replynum;

  StoryBuilder();

  StoryBuilder get _$this {
    if (_$v != null) {
      _sortkey = _$v.sortkey;
      _dateline = _$v.dateline;
      _subject = _$v.subject;
      _username = _$v.username;
      _digest = _$v.digest;
      _closed = _$v.closed;
      _uid = _$v.uid;
      _id = _$v.id;
      _fid = _$v.fid;
      _isquote = _$v.isquote;
      _message = _$v.message;
      _isthread = _$v.isthread;
      _tid = _$v.tid;
      _tAuthor = _$v.tAuthor;
      _tAuthorid = _$v.tAuthorid;
      _tReplynum = _$v.tReplynum;
      _replynum = _$v.replynum;
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
            sortkey: sortkey,
            dateline: dateline,
            subject: subject,
            username: username,
            digest: digest,
            closed: closed,
            uid: uid,
            id: id,
            fid: fid,
            isquote: isquote,
            message: message,
            isthread: isthread,
            tid: tid,
            tAuthor: tAuthor,
            tAuthorid: tAuthorid,
            tReplynum: tReplynum,
            replynum: replynum);
    replace(_$result);
    return _$result;
  }
}

class _$ForumStoryResult extends ForumStoryResult {
  @override
  final BuiltList<Story> data;
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

  ListBuilder<Story> _data;
  ListBuilder<Story> get data => _$this._data ??= new ListBuilder<Story>();
  set data(ListBuilder<Story> data) => _$this._data = data;

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

class _$StoryContentResult extends StoryContentResult {
  @override
  final int isfull;
  @override
  final String model;
  @override
  final int replies;
  @override
  final int page;
  @override
  final BuiltList<Comment> comments;
  @override
  final int isend;
  @override
  final int loadtime;
  @override
  final String tmp;

  factory _$StoryContentResult([void updates(StoryContentResultBuilder b)]) =>
      (new StoryContentResultBuilder()..update(updates)).build();

  _$StoryContentResult._(
      {this.isfull,
      this.model,
      this.replies,
      this.page,
      this.comments,
      this.isend,
      this.loadtime,
      this.tmp})
      : super._() {
    if (model == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'model');
    }
    if (replies == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'replies');
    }
    if (page == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'page');
    }
    if (comments == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'comments');
    }
    if (isend == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'isend');
    }
    if (loadtime == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'loadtime');
    }
    if (tmp == null) {
      throw new BuiltValueNullFieldError('StoryContentResult', 'tmp');
    }
  }

  @override
  StoryContentResult rebuild(void updates(StoryContentResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  StoryContentResultBuilder toBuilder() =>
      new StoryContentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoryContentResult &&
        isfull == other.isfull &&
        model == other.model &&
        replies == other.replies &&
        page == other.page &&
        comments == other.comments &&
        isend == other.isend &&
        loadtime == other.loadtime &&
        tmp == other.tmp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, isfull.hashCode), model.hashCode),
                            replies.hashCode),
                        page.hashCode),
                    comments.hashCode),
                isend.hashCode),
            loadtime.hashCode),
        tmp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StoryContentResult')
          ..add('isfull', isfull)
          ..add('model', model)
          ..add('replies', replies)
          ..add('page', page)
          ..add('comments', comments)
          ..add('isend', isend)
          ..add('loadtime', loadtime)
          ..add('tmp', tmp))
        .toString();
  }
}

class StoryContentResultBuilder
    implements Builder<StoryContentResult, StoryContentResultBuilder> {
  _$StoryContentResult _$v;

  int _isfull;
  int get isfull => _$this._isfull;
  set isfull(int isfull) => _$this._isfull = isfull;

  String _model;
  String get model => _$this._model;
  set model(String model) => _$this._model = model;

  int _replies;
  int get replies => _$this._replies;
  set replies(int replies) => _$this._replies = replies;

  int _page;
  int get page => _$this._page;
  set page(int page) => _$this._page = page;

  ListBuilder<Comment> _comments;
  ListBuilder<Comment> get comments =>
      _$this._comments ??= new ListBuilder<Comment>();
  set comments(ListBuilder<Comment> comments) => _$this._comments = comments;

  int _isend;
  int get isend => _$this._isend;
  set isend(int isend) => _$this._isend = isend;

  int _loadtime;
  int get loadtime => _$this._loadtime;
  set loadtime(int loadtime) => _$this._loadtime = loadtime;

  String _tmp;
  String get tmp => _$this._tmp;
  set tmp(String tmp) => _$this._tmp = tmp;

  StoryContentResultBuilder();

  StoryContentResultBuilder get _$this {
    if (_$v != null) {
      _isfull = _$v.isfull;
      _model = _$v.model;
      _replies = _$v.replies;
      _page = _$v.page;
      _comments = _$v.comments?.toBuilder();
      _isend = _$v.isend;
      _loadtime = _$v.loadtime;
      _tmp = _$v.tmp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StoryContentResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StoryContentResult;
  }

  @override
  void update(void updates(StoryContentResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$StoryContentResult build() {
    _$StoryContentResult _$result;
    try {
      _$result = _$v ??
          new _$StoryContentResult._(
              isfull: isfull,
              model: model,
              replies: replies,
              page: page,
              comments: comments.build(),
              isend: isend,
              loadtime: loadtime,
              tmp: tmp);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'comments';
        comments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'StoryContentResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Comment extends Comment {
  @override
  final int fid;
  @override
  final int sortkey;
  @override
  final bool warning;
  @override
  final String warningReason;
  @override
  final String dateline;
  @override
  final String message;
  @override
  final String author;
  @override
  final int authorid;
  @override
  final int isme;
  @override
  final int notgroup;
  @override
  final int pid;
  @override
  final int first;
  @override
  final int status;
  @override
  final int id;
  @override
  final bool tsadmin;
  @override
  final int isadmin;
  @override
  final int lou;
  @override
  final int tid;
  @override
  final BuiltList<Ratelog> ratelog;

  factory _$Comment([void updates(CommentBuilder b)]) =>
      (new CommentBuilder()..update(updates)).build();

  _$Comment._(
      {this.fid,
      this.sortkey,
      this.warning,
      this.warningReason,
      this.dateline,
      this.message,
      this.author,
      this.authorid,
      this.isme,
      this.notgroup,
      this.pid,
      this.first,
      this.status,
      this.id,
      this.tsadmin,
      this.isadmin,
      this.lou,
      this.tid,
      this.ratelog})
      : super._() {
    if (fid == null) {
      throw new BuiltValueNullFieldError('Comment', 'fid');
    }
    if (sortkey == null) {
      throw new BuiltValueNullFieldError('Comment', 'sortkey');
    }
    if (warning == null) {
      throw new BuiltValueNullFieldError('Comment', 'warning');
    }
    if (warningReason == null) {
      throw new BuiltValueNullFieldError('Comment', 'warningReason');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Comment', 'dateline');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('Comment', 'message');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('Comment', 'author');
    }
    if (authorid == null) {
      throw new BuiltValueNullFieldError('Comment', 'authorid');
    }
    if (isme == null) {
      throw new BuiltValueNullFieldError('Comment', 'isme');
    }
    if (notgroup == null) {
      throw new BuiltValueNullFieldError('Comment', 'notgroup');
    }
    if (pid == null) {
      throw new BuiltValueNullFieldError('Comment', 'pid');
    }
    if (first == null) {
      throw new BuiltValueNullFieldError('Comment', 'first');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('Comment', 'status');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('Comment', 'id');
    }
    if (tsadmin == null) {
      throw new BuiltValueNullFieldError('Comment', 'tsadmin');
    }
    if (isadmin == null) {
      throw new BuiltValueNullFieldError('Comment', 'isadmin');
    }
    if (lou == null) {
      throw new BuiltValueNullFieldError('Comment', 'lou');
    }
  }

  @override
  Comment rebuild(void updates(CommentBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        fid == other.fid &&
        sortkey == other.sortkey &&
        warning == other.warning &&
        warningReason == other.warningReason &&
        dateline == other.dateline &&
        message == other.message &&
        author == other.author &&
        authorid == other.authorid &&
        isme == other.isme &&
        notgroup == other.notgroup &&
        pid == other.pid &&
        first == other.first &&
        status == other.status &&
        id == other.id &&
        tsadmin == other.tsadmin &&
        isadmin == other.isadmin &&
        lou == other.lou &&
        tid == other.tid &&
        ratelog == other.ratelog;
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
                                                                            $jc(
                                                                                0,
                                                                                fid
                                                                                    .hashCode),
                                                                            sortkey
                                                                                .hashCode),
                                                                        warning
                                                                            .hashCode),
                                                                    warningReason
                                                                        .hashCode),
                                                                dateline
                                                                    .hashCode),
                                                            message.hashCode),
                                                        author.hashCode),
                                                    authorid.hashCode),
                                                isme.hashCode),
                                            notgroup.hashCode),
                                        pid.hashCode),
                                    first.hashCode),
                                status.hashCode),
                            id.hashCode),
                        tsadmin.hashCode),
                    isadmin.hashCode),
                lou.hashCode),
            tid.hashCode),
        ratelog.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Comment')
          ..add('fid', fid)
          ..add('sortkey', sortkey)
          ..add('warning', warning)
          ..add('warningReason', warningReason)
          ..add('dateline', dateline)
          ..add('message', message)
          ..add('author', author)
          ..add('authorid', authorid)
          ..add('isme', isme)
          ..add('notgroup', notgroup)
          ..add('pid', pid)
          ..add('first', first)
          ..add('status', status)
          ..add('id', id)
          ..add('tsadmin', tsadmin)
          ..add('isadmin', isadmin)
          ..add('lou', lou)
          ..add('tid', tid)
          ..add('ratelog', ratelog))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment _$v;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  int _sortkey;
  int get sortkey => _$this._sortkey;
  set sortkey(int sortkey) => _$this._sortkey = sortkey;

  bool _warning;
  bool get warning => _$this._warning;
  set warning(bool warning) => _$this._warning = warning;

  String _warningReason;
  String get warningReason => _$this._warningReason;
  set warningReason(String warningReason) =>
      _$this._warningReason = warningReason;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  int _authorid;
  int get authorid => _$this._authorid;
  set authorid(int authorid) => _$this._authorid = authorid;

  int _isme;
  int get isme => _$this._isme;
  set isme(int isme) => _$this._isme = isme;

  int _notgroup;
  int get notgroup => _$this._notgroup;
  set notgroup(int notgroup) => _$this._notgroup = notgroup;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  int _first;
  int get first => _$this._first;
  set first(int first) => _$this._first = first;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  bool _tsadmin;
  bool get tsadmin => _$this._tsadmin;
  set tsadmin(bool tsadmin) => _$this._tsadmin = tsadmin;

  int _isadmin;
  int get isadmin => _$this._isadmin;
  set isadmin(int isadmin) => _$this._isadmin = isadmin;

  int _lou;
  int get lou => _$this._lou;
  set lou(int lou) => _$this._lou = lou;

  int _tid;
  int get tid => _$this._tid;
  set tid(int tid) => _$this._tid = tid;

  ListBuilder<Ratelog> _ratelog;
  ListBuilder<Ratelog> get ratelog =>
      _$this._ratelog ??= new ListBuilder<Ratelog>();
  set ratelog(ListBuilder<Ratelog> ratelog) => _$this._ratelog = ratelog;

  CommentBuilder();

  CommentBuilder get _$this {
    if (_$v != null) {
      _fid = _$v.fid;
      _sortkey = _$v.sortkey;
      _warning = _$v.warning;
      _warningReason = _$v.warningReason;
      _dateline = _$v.dateline;
      _message = _$v.message;
      _author = _$v.author;
      _authorid = _$v.authorid;
      _isme = _$v.isme;
      _notgroup = _$v.notgroup;
      _pid = _$v.pid;
      _first = _$v.first;
      _status = _$v.status;
      _id = _$v.id;
      _tsadmin = _$v.tsadmin;
      _isadmin = _$v.isadmin;
      _lou = _$v.lou;
      _tid = _$v.tid;
      _ratelog = _$v.ratelog?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Comment;
  }

  @override
  void update(void updates(CommentBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Comment build() {
    _$Comment _$result;
    try {
      _$result = _$v ??
          new _$Comment._(
              fid: fid,
              sortkey: sortkey,
              warning: warning,
              warningReason: warningReason,
              dateline: dateline,
              message: message,
              author: author,
              authorid: authorid,
              isme: isme,
              notgroup: notgroup,
              pid: pid,
              first: first,
              status: status,
              id: id,
              tsadmin: tsadmin,
              isadmin: isadmin,
              lou: lou,
              tid: tid,
              ratelog: _ratelog?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'ratelog';
        _ratelog?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Comment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Ratelog extends Ratelog {
  @override
  final BuiltMap<String, String> id;
  @override
  final String dateline;
  @override
  final int extcredits;
  @override
  final int pid;
  @override
  final String reason;
  @override
  final int score;
  @override
  final int uid;
  @override
  final String username;

  factory _$Ratelog([void updates(RatelogBuilder b)]) =>
      (new RatelogBuilder()..update(updates)).build();

  _$Ratelog._(
      {this.id,
      this.dateline,
      this.extcredits,
      this.pid,
      this.reason,
      this.score,
      this.uid,
      this.username})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'id');
    }
    if (dateline == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'dateline');
    }
    if (extcredits == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'extcredits');
    }
    if (pid == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'pid');
    }
    if (reason == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'reason');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'score');
    }
    if (uid == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'uid');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('Ratelog', 'username');
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
        id == other.id &&
        dateline == other.dateline &&
        extcredits == other.extcredits &&
        pid == other.pid &&
        reason == other.reason &&
        score == other.score &&
        uid == other.uid &&
        username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), dateline.hashCode),
                            extcredits.hashCode),
                        pid.hashCode),
                    reason.hashCode),
                score.hashCode),
            uid.hashCode),
        username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Ratelog')
          ..add('id', id)
          ..add('dateline', dateline)
          ..add('extcredits', extcredits)
          ..add('pid', pid)
          ..add('reason', reason)
          ..add('score', score)
          ..add('uid', uid)
          ..add('username', username))
        .toString();
  }
}

class RatelogBuilder implements Builder<Ratelog, RatelogBuilder> {
  _$Ratelog _$v;

  MapBuilder<String, String> _id;
  MapBuilder<String, String> get id =>
      _$this._id ??= new MapBuilder<String, String>();
  set id(MapBuilder<String, String> id) => _$this._id = id;

  String _dateline;
  String get dateline => _$this._dateline;
  set dateline(String dateline) => _$this._dateline = dateline;

  int _extcredits;
  int get extcredits => _$this._extcredits;
  set extcredits(int extcredits) => _$this._extcredits = extcredits;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  String _reason;
  String get reason => _$this._reason;
  set reason(String reason) => _$this._reason = reason;

  int _score;
  int get score => _$this._score;
  set score(int score) => _$this._score = score;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  RatelogBuilder();

  RatelogBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id?.toBuilder();
      _dateline = _$v.dateline;
      _extcredits = _$v.extcredits;
      _pid = _$v.pid;
      _reason = _$v.reason;
      _score = _$v.score;
      _uid = _$v.uid;
      _username = _$v.username;
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
    _$Ratelog _$result;
    try {
      _$result = _$v ??
          new _$Ratelog._(
              id: id.build(),
              dateline: dateline,
              extcredits: extcredits,
              pid: pid,
              reason: reason,
              score: score,
              uid: uid,
              username: username);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'id';
        id.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Ratelog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
