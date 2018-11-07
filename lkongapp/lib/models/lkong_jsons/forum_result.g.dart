// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_result.dart';

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

Serializer<ForumListResult> _$forumListResultSerializer =
    new _$ForumListResultSerializer();
Serializer<Forum> _$forumSerializer = new _$ForumSerializer();
Serializer<ForumInfoResult> _$forumInfoResultSerializer =
    new _$ForumInfoResultSerializer();

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
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isok',
      serializers.serialize(object.isok, specifiedType: const FullType(bool)),
      'forumlist',
      serializers.serialize(object.forumList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Forum)])),
      'sysweimian',
      serializers.serialize(object.sysweimian,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Forum)])),
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isok':
          result.isok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'forumlist':
          result.forumList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Forum)]))
              as BuiltList);
          break;
        case 'sysweimian':
          result.sysweimian.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Forum)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ForumSerializer implements StructuredSerializer<Forum> {
  @override
  final Iterable<Type> types = const [Forum, _$Forum];
  @override
  final String wireName = 'Forum';

  @override
  Iterable serialize(Serializers serializers, Forum object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'fid',
      serializers.serialize(object.fid, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.pos != null) {
      result
        ..add('pos')
        ..add(serializers.serialize(object.pos,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  Forum deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ForumBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pos':
          result.pos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ForumInfoResultSerializer
    implements StructuredSerializer<ForumInfoResult> {
  @override
  final Iterable<Type> types = const [ForumInfoResult, _$ForumInfoResult];
  @override
  final String wireName = 'ForumInfoResult';

  @override
  Iterable serialize(Serializers serializers, ForumInfoResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'fid',
      serializers.serialize(object.fid, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'sortbydateline',
      serializers.serialize(object.sortbydateline,
          specifiedType: const FullType(int)),
      'threads',
      serializers.serialize(object.threads,
          specifiedType: const FullType(String)),
      'todayposts',
      serializers.serialize(object.todayposts,
          specifiedType: const FullType(int)),
      'fansnum',
      serializers.serialize(object.fansnum, specifiedType: const FullType(int)),
      'blackboard',
      serializers.serialize(object.blackboard,
          specifiedType: const FullType(String)),
      'moderators',
      serializers.serialize(object.moderators,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'isadmin',
      serializers.serialize(object.isadmin, specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isok',
      serializers.serialize(object.isok, specifiedType: const FullType(bool)),
    ];
    if (object.verify != null) {
      result
        ..add('verify')
        ..add(serializers.serialize(object.verify,
            specifiedType: const FullType(bool)));
    }
    if (object.verifymessage != null) {
      result
        ..add('verifymessage')
        ..add(serializers.serialize(object.verifymessage,
            specifiedType: const FullType(String)));
    }
    if (object.linktitle != null) {
      result
        ..add('linktitle')
        ..add(serializers.serialize(object.linktitle,
            specifiedType: const FullType(String)));
    }
    if (object.links != null) {
      result
        ..add('links')
        ..add(serializers.serialize(object.links,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(Forum)])));
    }
    if (object.jointype != null) {
      result
        ..add('jointype')
        ..add(serializers.serialize(object.jointype,
            specifiedType: const FullType(String)));
    }
    if (object.membernum != null) {
      result
        ..add('membernum')
        ..add(serializers.serialize(object.membernum,
            specifiedType: const FullType(int)));
    }
    if (object.ismem != null) {
      result
        ..add('ismem')
        ..add(serializers.serialize(object.ismem,
            specifiedType: const FullType(int)));
    }
    if (object.isgroup != null) {
      result
        ..add('isgroup')
        ..add(serializers.serialize(object.isgroup,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  ForumInfoResult deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ForumInfoResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fid':
          result.fid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sortbydateline':
          result.sortbydateline = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'threads':
          result.threads = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'todayposts':
          result.todayposts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fansnum':
          result.fansnum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'blackboard':
          result.blackboard = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'moderators':
          result.moderators.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList);
          break;
        case 'verify':
          result.verify = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'verifymessage':
          result.verifymessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isadmin':
          result.isadmin = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'linktitle':
          result.linktitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'links':
          result.links.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(Forum)
              ])) as BuiltMap);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isok':
          result.isok = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'jointype':
          result.jointype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'membernum':
          result.membernum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ismem':
          result.ismem = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isgroup':
          result.isgroup = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ForumListResult extends ForumListResult {
  @override
  final String id;
  @override
  final bool isok;
  @override
  final BuiltList<Forum> forumList;
  @override
  final BuiltList<Forum> sysweimian;

  factory _$ForumListResult([void updates(ForumListResultBuilder b)]) =>
      (new ForumListResultBuilder()..update(updates)).build();

  _$ForumListResult._({this.id, this.isok, this.forumList, this.sysweimian})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'id');
    }
    if (isok == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'isok');
    }
    if (forumList == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'forumList');
    }
    if (sysweimian == null) {
      throw new BuiltValueNullFieldError('ForumListResult', 'sysweimian');
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
        id == other.id &&
        isok == other.isok &&
        forumList == other.forumList &&
        sysweimian == other.sysweimian;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), isok.hashCode), forumList.hashCode),
        sysweimian.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForumListResult')
          ..add('id', id)
          ..add('isok', isok)
          ..add('forumList', forumList)
          ..add('sysweimian', sysweimian))
        .toString();
  }
}

class ForumListResultBuilder
    implements Builder<ForumListResult, ForumListResultBuilder> {
  _$ForumListResult _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _isok;
  bool get isok => _$this._isok;
  set isok(bool isok) => _$this._isok = isok;

  ListBuilder<Forum> _forumList;
  ListBuilder<Forum> get forumList =>
      _$this._forumList ??= new ListBuilder<Forum>();
  set forumList(ListBuilder<Forum> forumList) => _$this._forumList = forumList;

  ListBuilder<Forum> _sysweimian;
  ListBuilder<Forum> get sysweimian =>
      _$this._sysweimian ??= new ListBuilder<Forum>();
  set sysweimian(ListBuilder<Forum> sysweimian) =>
      _$this._sysweimian = sysweimian;

  ForumListResultBuilder();

  ForumListResultBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _isok = _$v.isok;
      _forumList = _$v.forumList?.toBuilder();
      _sysweimian = _$v.sysweimian?.toBuilder();
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
              id: id,
              isok: isok,
              forumList: forumList.build(),
              sysweimian: sysweimian.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'forumList';
        forumList.build();
        _$failedField = 'sysweimian';
        sysweimian.build();
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

class _$Forum extends Forum {
  @override
  final int fid;
  @override
  final String name;
  @override
  final int pos;

  factory _$Forum([void updates(ForumBuilder b)]) =>
      (new ForumBuilder()..update(updates)).build();

  _$Forum._({this.fid, this.name, this.pos}) : super._() {
    if (fid == null) {
      throw new BuiltValueNullFieldError('Forum', 'fid');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Forum', 'name');
    }
  }

  @override
  Forum rebuild(void updates(ForumBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumBuilder toBuilder() => new ForumBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Forum &&
        fid == other.fid &&
        name == other.name &&
        pos == other.pos;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, fid.hashCode), name.hashCode), pos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Forum')
          ..add('fid', fid)
          ..add('name', name)
          ..add('pos', pos))
        .toString();
  }
}

class ForumBuilder implements Builder<Forum, ForumBuilder> {
  _$Forum _$v;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _pos;
  int get pos => _$this._pos;
  set pos(int pos) => _$this._pos = pos;

  ForumBuilder();

  ForumBuilder get _$this {
    if (_$v != null) {
      _fid = _$v.fid;
      _name = _$v.name;
      _pos = _$v.pos;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Forum other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Forum;
  }

  @override
  void update(void updates(ForumBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Forum build() {
    final _$result = _$v ?? new _$Forum._(fid: fid, name: name, pos: pos);
    replace(_$result);
    return _$result;
  }
}

class _$ForumInfoResult extends ForumInfoResult {
  @override
  final String type;
  @override
  final int fid;
  @override
  final String name;
  @override
  final String description;
  @override
  final String status;
  @override
  final int sortbydateline;
  @override
  final String threads;
  @override
  final int todayposts;
  @override
  final int fansnum;
  @override
  final String blackboard;
  @override
  final BuiltList<String> moderators;
  @override
  final bool verify;
  @override
  final String verifymessage;
  @override
  final int isadmin;
  @override
  final String linktitle;
  @override
  final BuiltMap<String, Forum> links;
  @override
  final String id;
  @override
  final bool isok;
  @override
  final String jointype;
  @override
  final int membernum;
  @override
  final int ismem;
  @override
  final bool isgroup;

  factory _$ForumInfoResult([void updates(ForumInfoResultBuilder b)]) =>
      (new ForumInfoResultBuilder()..update(updates)).build();

  _$ForumInfoResult._(
      {this.type,
      this.fid,
      this.name,
      this.description,
      this.status,
      this.sortbydateline,
      this.threads,
      this.todayposts,
      this.fansnum,
      this.blackboard,
      this.moderators,
      this.verify,
      this.verifymessage,
      this.isadmin,
      this.linktitle,
      this.links,
      this.id,
      this.isok,
      this.jointype,
      this.membernum,
      this.ismem,
      this.isgroup})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'type');
    }
    if (fid == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'fid');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'description');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'status');
    }
    if (sortbydateline == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'sortbydateline');
    }
    if (threads == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'threads');
    }
    if (todayposts == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'todayposts');
    }
    if (fansnum == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'fansnum');
    }
    if (blackboard == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'blackboard');
    }
    if (moderators == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'moderators');
    }
    if (isadmin == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'isadmin');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'id');
    }
    if (isok == null) {
      throw new BuiltValueNullFieldError('ForumInfoResult', 'isok');
    }
  }

  @override
  ForumInfoResult rebuild(void updates(ForumInfoResultBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ForumInfoResultBuilder toBuilder() =>
      new ForumInfoResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForumInfoResult &&
        type == other.type &&
        fid == other.fid &&
        name == other.name &&
        description == other.description &&
        status == other.status &&
        sortbydateline == other.sortbydateline &&
        threads == other.threads &&
        todayposts == other.todayposts &&
        fansnum == other.fansnum &&
        blackboard == other.blackboard &&
        moderators == other.moderators &&
        verify == other.verify &&
        verifymessage == other.verifymessage &&
        isadmin == other.isadmin &&
        linktitle == other.linktitle &&
        links == other.links &&
        id == other.id &&
        isok == other.isok &&
        jointype == other.jointype &&
        membernum == other.membernum &&
        ismem == other.ismem &&
        isgroup == other.isgroup;
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
                                                                            $jc($jc($jc($jc(0, type.hashCode), fid.hashCode), name.hashCode),
                                                                                description.hashCode),
                                                                            status.hashCode),
                                                                        sortbydateline.hashCode),
                                                                    threads.hashCode),
                                                                todayposts.hashCode),
                                                            fansnum.hashCode),
                                                        blackboard.hashCode),
                                                    moderators.hashCode),
                                                verify.hashCode),
                                            verifymessage.hashCode),
                                        isadmin.hashCode),
                                    linktitle.hashCode),
                                links.hashCode),
                            id.hashCode),
                        isok.hashCode),
                    jointype.hashCode),
                membernum.hashCode),
            ismem.hashCode),
        isgroup.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ForumInfoResult')
          ..add('type', type)
          ..add('fid', fid)
          ..add('name', name)
          ..add('description', description)
          ..add('status', status)
          ..add('sortbydateline', sortbydateline)
          ..add('threads', threads)
          ..add('todayposts', todayposts)
          ..add('fansnum', fansnum)
          ..add('blackboard', blackboard)
          ..add('moderators', moderators)
          ..add('verify', verify)
          ..add('verifymessage', verifymessage)
          ..add('isadmin', isadmin)
          ..add('linktitle', linktitle)
          ..add('links', links)
          ..add('id', id)
          ..add('isok', isok)
          ..add('jointype', jointype)
          ..add('membernum', membernum)
          ..add('ismem', ismem)
          ..add('isgroup', isgroup))
        .toString();
  }
}

class ForumInfoResultBuilder
    implements Builder<ForumInfoResult, ForumInfoResultBuilder> {
  _$ForumInfoResult _$v;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _fid;
  int get fid => _$this._fid;
  set fid(int fid) => _$this._fid = fid;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  int _sortbydateline;
  int get sortbydateline => _$this._sortbydateline;
  set sortbydateline(int sortbydateline) =>
      _$this._sortbydateline = sortbydateline;

  String _threads;
  String get threads => _$this._threads;
  set threads(String threads) => _$this._threads = threads;

  int _todayposts;
  int get todayposts => _$this._todayposts;
  set todayposts(int todayposts) => _$this._todayposts = todayposts;

  int _fansnum;
  int get fansnum => _$this._fansnum;
  set fansnum(int fansnum) => _$this._fansnum = fansnum;

  String _blackboard;
  String get blackboard => _$this._blackboard;
  set blackboard(String blackboard) => _$this._blackboard = blackboard;

  ListBuilder<String> _moderators;
  ListBuilder<String> get moderators =>
      _$this._moderators ??= new ListBuilder<String>();
  set moderators(ListBuilder<String> moderators) =>
      _$this._moderators = moderators;

  bool _verify;
  bool get verify => _$this._verify;
  set verify(bool verify) => _$this._verify = verify;

  String _verifymessage;
  String get verifymessage => _$this._verifymessage;
  set verifymessage(String verifymessage) =>
      _$this._verifymessage = verifymessage;

  int _isadmin;
  int get isadmin => _$this._isadmin;
  set isadmin(int isadmin) => _$this._isadmin = isadmin;

  String _linktitle;
  String get linktitle => _$this._linktitle;
  set linktitle(String linktitle) => _$this._linktitle = linktitle;

  MapBuilder<String, Forum> _links;
  MapBuilder<String, Forum> get links =>
      _$this._links ??= new MapBuilder<String, Forum>();
  set links(MapBuilder<String, Forum> links) => _$this._links = links;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  bool _isok;
  bool get isok => _$this._isok;
  set isok(bool isok) => _$this._isok = isok;

  String _jointype;
  String get jointype => _$this._jointype;
  set jointype(String jointype) => _$this._jointype = jointype;

  int _membernum;
  int get membernum => _$this._membernum;
  set membernum(int membernum) => _$this._membernum = membernum;

  int _ismem;
  int get ismem => _$this._ismem;
  set ismem(int ismem) => _$this._ismem = ismem;

  bool _isgroup;
  bool get isgroup => _$this._isgroup;
  set isgroup(bool isgroup) => _$this._isgroup = isgroup;

  ForumInfoResultBuilder();

  ForumInfoResultBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _fid = _$v.fid;
      _name = _$v.name;
      _description = _$v.description;
      _status = _$v.status;
      _sortbydateline = _$v.sortbydateline;
      _threads = _$v.threads;
      _todayposts = _$v.todayposts;
      _fansnum = _$v.fansnum;
      _blackboard = _$v.blackboard;
      _moderators = _$v.moderators?.toBuilder();
      _verify = _$v.verify;
      _verifymessage = _$v.verifymessage;
      _isadmin = _$v.isadmin;
      _linktitle = _$v.linktitle;
      _links = _$v.links?.toBuilder();
      _id = _$v.id;
      _isok = _$v.isok;
      _jointype = _$v.jointype;
      _membernum = _$v.membernum;
      _ismem = _$v.ismem;
      _isgroup = _$v.isgroup;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForumInfoResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ForumInfoResult;
  }

  @override
  void update(void updates(ForumInfoResultBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ForumInfoResult build() {
    _$ForumInfoResult _$result;
    try {
      _$result = _$v ??
          new _$ForumInfoResult._(
              type: type,
              fid: fid,
              name: name,
              description: description,
              status: status,
              sortbydateline: sortbydateline,
              threads: threads,
              todayposts: todayposts,
              fansnum: fansnum,
              blackboard: blackboard,
              moderators: moderators.build(),
              verify: verify,
              verifymessage: verifymessage,
              isadmin: isadmin,
              linktitle: linktitle,
              links: _links?.build(),
              id: id,
              isok: isok,
              jointype: jointype,
              membernum: membernum,
              ismem: ismem,
              isgroup: isgroup);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'moderators';
        moderators.build();

        _$failedField = 'links';
        _links?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ForumInfoResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
