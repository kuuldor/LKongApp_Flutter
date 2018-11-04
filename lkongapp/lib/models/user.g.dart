// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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

Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<UserInfo> _$userInfoSerializer = new _$UserInfoSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.identity != null) {
      result
        ..add('identity')
        ..add(serializers.serialize(object.identity,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.uid != null) {
      result
        ..add('userid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'identity':
          result.identity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$UserInfoSerializer implements StructuredSerializer<UserInfo> {
  @override
  final Iterable<Type> types = const [UserInfo, _$UserInfo];
  @override
  final String wireName = 'UserInfo';

  @override
  Iterable serialize(Serializers serializers, UserInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.blacklists != null) {
      result
        ..add('blacklists')
        ..add(serializers.serialize(object.blacklists,
            specifiedType: const FullType(String)));
    }
    if (object.customstatus != null) {
      result
        ..add('customstatus')
        ..add(serializers.serialize(object.customstatus,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(int)));
    }
    if (object.gender != null) {
      result
        ..add('gender')
        ..add(serializers.serialize(object.gender,
            specifiedType: const FullType(int)));
    }
    if (object.invite != null) {
      result
        ..add('invite')
        ..add(serializers.serialize(object.invite,
            specifiedType: const FullType(int)));
    }
    if (object.phonenum != null) {
      result
        ..add('phonenum')
        ..add(serializers.serialize(object.phonenum,
            specifiedType: const FullType(int)));
    }
    if (object.regdate != null) {
      result
        ..add('regdate')
        ..add(serializers.serialize(object.regdate,
            specifiedType: const FullType(String)));
    }
    if (object.sightml != null) {
      result
        ..add('sightml')
        ..add(serializers.serialize(object.sightml,
            specifiedType: const FullType(String)));
    }
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
    if (object.me != null) {
      result
        ..add('me')
        ..add(serializers.serialize(object.me,
            specifiedType: const FullType(int)));
    }
    if (object.fansnum != null) {
      result
        ..add('fansnum')
        ..add(serializers.serialize(object.fansnum,
            specifiedType: const FullType(int)));
    }
    if (object.followuidnum != null) {
      result
        ..add('followuidnum')
        ..add(serializers.serialize(object.followuidnum,
            specifiedType: const FullType(int)));
    }
    if (object.digestposts != null) {
      result
        ..add('digestposts')
        ..add(serializers.serialize(object.digestposts,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits1 != null) {
      result
        ..add('extcredits1')
        ..add(serializers.serialize(object.extcredits1,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits2 != null) {
      result
        ..add('extcredits2')
        ..add(serializers.serialize(object.extcredits2,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits3 != null) {
      result
        ..add('extcredits3')
        ..add(serializers.serialize(object.extcredits3,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits4 != null) {
      result
        ..add('extcredits4')
        ..add(serializers.serialize(object.extcredits4,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits5 != null) {
      result
        ..add('extcredits5')
        ..add(serializers.serialize(object.extcredits5,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits6 != null) {
      result
        ..add('extcredits6')
        ..add(serializers.serialize(object.extcredits6,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits7 != null) {
      result
        ..add('extcredits7')
        ..add(serializers.serialize(object.extcredits7,
            specifiedType: const FullType(int)));
    }
    if (object.extcredits8 != null) {
      result
        ..add('extcredits8')
        ..add(serializers.serialize(object.extcredits8,
            specifiedType: const FullType(int)));
    }
    if (object.followfidnum != null) {
      result
        ..add('followfidnum')
        ..add(serializers.serialize(object.followfidnum,
            specifiedType: const FullType(int)));
    }
    if (object.oltime != null) {
      result
        ..add('oltime')
        ..add(serializers.serialize(object.oltime,
            specifiedType: const FullType(int)));
    }
    if (object.posts != null) {
      result
        ..add('posts')
        ..add(serializers.serialize(object.posts,
            specifiedType: const FullType(int)));
    }
    if (object.punchallday != null) {
      result
        ..add('punchallday')
        ..add(serializers.serialize(object.punchallday,
            specifiedType: const FullType(int)));
    }
    if (object.punchday != null) {
      result
        ..add('punchday')
        ..add(serializers.serialize(object.punchday,
            specifiedType: const FullType(int)));
    }
    if (object.punchhighestday != null) {
      result
        ..add('punchhighestday')
        ..add(serializers.serialize(object.punchhighestday,
            specifiedType: const FullType(int)));
    }
    if (object.punchtime != null) {
      result
        ..add('punchtime')
        ..add(serializers.serialize(object.punchtime,
            specifiedType: const FullType(int)));
    }
    if (object.sendphonemessage != null) {
      result
        ..add('sendphonemessage')
        ..add(serializers.serialize(object.sendphonemessage,
            specifiedType: const FullType(String)));
    }
    if (object.threads != null) {
      result
        ..add('threads')
        ..add(serializers.serialize(object.threads,
            specifiedType: const FullType(int)));
    }
    if (object.todaypostnum != null) {
      result
        ..add('todaypostnum')
        ..add(serializers.serialize(object.todaypostnum,
            specifiedType: const FullType(String)));
    }
    if (object.isok != null) {
      result
        ..add('isok')
        ..add(serializers.serialize(object.isok,
            specifiedType: const FullType(bool)));
    }

    return result;
  }

  @override
  UserInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'blacklists':
          result.blacklists = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customstatus':
          result.customstatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'gender':
          result.gender = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'invite':
          result.invite = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'phonenum':
          result.phonenum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'regdate':
          result.regdate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sightml':
          result.sightml = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'me':
          result.me = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fansnum':
          result.fansnum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followuidnum':
          result.followuidnum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'digestposts':
          result.digestposts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits1':
          result.extcredits1 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits2':
          result.extcredits2 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits3':
          result.extcredits3 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits4':
          result.extcredits4 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits5':
          result.extcredits5 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits6':
          result.extcredits6 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits7':
          result.extcredits7 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'extcredits8':
          result.extcredits8 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followfidnum':
          result.followfidnum = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'oltime':
          result.oltime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'posts':
          result.posts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'punchallday':
          result.punchallday = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'punchday':
          result.punchday = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'punchhighestday':
          result.punchhighestday = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'punchtime':
          result.punchtime = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sendphonemessage':
          result.sendphonemessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'threads':
          result.threads = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'todaypostnum':
          result.todaypostnum = serializers.deserialize(value,
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

class _$User extends User {
  @override
  final String identity;
  @override
  final String password;
  @override
  final int uid;

  factory _$User([void updates(UserBuilder b)]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.identity, this.password, this.uid}) : super._();

  @override
  User rebuild(void updates(UserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        identity == other.identity &&
        password == other.password &&
        uid == other.uid;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, identity.hashCode), password.hashCode), uid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('identity', identity)
          ..add('password', password)
          ..add('uid', uid))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _identity;
  String get identity => _$this._identity;
  set identity(String identity) => _$this._identity = identity;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _identity = _$v.identity;
      _password = _$v.password;
      _uid = _$v.uid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void updates(UserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result =
        _$v ?? new _$User._(identity: identity, password: password, uid: uid);
    replace(_$result);
    return _$result;
  }
}

class _$UserInfo extends UserInfo {
  @override
  final String blacklists;
  @override
  final String customstatus;
  @override
  final int email;
  @override
  final int gender;
  @override
  final int invite;
  @override
  final int phonenum;
  @override
  final String regdate;
  @override
  final String sightml;
  @override
  final int uid;
  @override
  final String username;
  @override
  final int me;
  @override
  final int fansnum;
  @override
  final int followuidnum;
  @override
  final int digestposts;
  @override
  final int extcredits1;
  @override
  final int extcredits2;
  @override
  final int extcredits3;
  @override
  final int extcredits4;
  @override
  final int extcredits5;
  @override
  final int extcredits6;
  @override
  final int extcredits7;
  @override
  final int extcredits8;
  @override
  final int followfidnum;
  @override
  final int oltime;
  @override
  final int posts;
  @override
  final int punchallday;
  @override
  final int punchday;
  @override
  final int punchhighestday;
  @override
  final int punchtime;
  @override
  final String sendphonemessage;
  @override
  final int threads;
  @override
  final String todaypostnum;
  @override
  final bool isok;

  factory _$UserInfo([void updates(UserInfoBuilder b)]) =>
      (new UserInfoBuilder()..update(updates)).build();

  _$UserInfo._(
      {this.blacklists,
      this.customstatus,
      this.email,
      this.gender,
      this.invite,
      this.phonenum,
      this.regdate,
      this.sightml,
      this.uid,
      this.username,
      this.me,
      this.fansnum,
      this.followuidnum,
      this.digestposts,
      this.extcredits1,
      this.extcredits2,
      this.extcredits3,
      this.extcredits4,
      this.extcredits5,
      this.extcredits6,
      this.extcredits7,
      this.extcredits8,
      this.followfidnum,
      this.oltime,
      this.posts,
      this.punchallday,
      this.punchday,
      this.punchhighestday,
      this.punchtime,
      this.sendphonemessage,
      this.threads,
      this.todaypostnum,
      this.isok})
      : super._();

  @override
  UserInfo rebuild(void updates(UserInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserInfoBuilder toBuilder() => new UserInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserInfo &&
        blacklists == other.blacklists &&
        customstatus == other.customstatus &&
        email == other.email &&
        gender == other.gender &&
        invite == other.invite &&
        phonenum == other.phonenum &&
        regdate == other.regdate &&
        sightml == other.sightml &&
        uid == other.uid &&
        username == other.username &&
        me == other.me &&
        fansnum == other.fansnum &&
        followuidnum == other.followuidnum &&
        digestposts == other.digestposts &&
        extcredits1 == other.extcredits1 &&
        extcredits2 == other.extcredits2 &&
        extcredits3 == other.extcredits3 &&
        extcredits4 == other.extcredits4 &&
        extcredits5 == other.extcredits5 &&
        extcredits6 == other.extcredits6 &&
        extcredits7 == other.extcredits7 &&
        extcredits8 == other.extcredits8 &&
        followfidnum == other.followfidnum &&
        oltime == other.oltime &&
        posts == other.posts &&
        punchallday == other.punchallday &&
        punchday == other.punchday &&
        punchhighestday == other.punchhighestday &&
        punchtime == other.punchtime &&
        sendphonemessage == other.sendphonemessage &&
        threads == other.threads &&
        todaypostnum == other.todaypostnum &&
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
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, blacklists.hashCode), customstatus.hashCode), email.hashCode), gender.hashCode), invite.hashCode), phonenum.hashCode), regdate.hashCode), sightml.hashCode), uid.hashCode), username.hashCode), me.hashCode), fansnum.hashCode), followuidnum.hashCode), digestposts.hashCode),
                                                                                extcredits1.hashCode),
                                                                            extcredits2.hashCode),
                                                                        extcredits3.hashCode),
                                                                    extcredits4.hashCode),
                                                                extcredits5.hashCode),
                                                            extcredits6.hashCode),
                                                        extcredits7.hashCode),
                                                    extcredits8.hashCode),
                                                followfidnum.hashCode),
                                            oltime.hashCode),
                                        posts.hashCode),
                                    punchallday.hashCode),
                                punchday.hashCode),
                            punchhighestday.hashCode),
                        punchtime.hashCode),
                    sendphonemessage.hashCode),
                threads.hashCode),
            todaypostnum.hashCode),
        isok.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserInfo')
          ..add('blacklists', blacklists)
          ..add('customstatus', customstatus)
          ..add('email', email)
          ..add('gender', gender)
          ..add('invite', invite)
          ..add('phonenum', phonenum)
          ..add('regdate', regdate)
          ..add('sightml', sightml)
          ..add('uid', uid)
          ..add('username', username)
          ..add('me', me)
          ..add('fansnum', fansnum)
          ..add('followuidnum', followuidnum)
          ..add('digestposts', digestposts)
          ..add('extcredits1', extcredits1)
          ..add('extcredits2', extcredits2)
          ..add('extcredits3', extcredits3)
          ..add('extcredits4', extcredits4)
          ..add('extcredits5', extcredits5)
          ..add('extcredits6', extcredits6)
          ..add('extcredits7', extcredits7)
          ..add('extcredits8', extcredits8)
          ..add('followfidnum', followfidnum)
          ..add('oltime', oltime)
          ..add('posts', posts)
          ..add('punchallday', punchallday)
          ..add('punchday', punchday)
          ..add('punchhighestday', punchhighestday)
          ..add('punchtime', punchtime)
          ..add('sendphonemessage', sendphonemessage)
          ..add('threads', threads)
          ..add('todaypostnum', todaypostnum)
          ..add('isok', isok))
        .toString();
  }
}

class UserInfoBuilder implements Builder<UserInfo, UserInfoBuilder> {
  _$UserInfo _$v;

  String _blacklists;
  String get blacklists => _$this._blacklists;
  set blacklists(String blacklists) => _$this._blacklists = blacklists;

  String _customstatus;
  String get customstatus => _$this._customstatus;
  set customstatus(String customstatus) => _$this._customstatus = customstatus;

  int _email;
  int get email => _$this._email;
  set email(int email) => _$this._email = email;

  int _gender;
  int get gender => _$this._gender;
  set gender(int gender) => _$this._gender = gender;

  int _invite;
  int get invite => _$this._invite;
  set invite(int invite) => _$this._invite = invite;

  int _phonenum;
  int get phonenum => _$this._phonenum;
  set phonenum(int phonenum) => _$this._phonenum = phonenum;

  String _regdate;
  String get regdate => _$this._regdate;
  set regdate(String regdate) => _$this._regdate = regdate;

  String _sightml;
  String get sightml => _$this._sightml;
  set sightml(String sightml) => _$this._sightml = sightml;

  int _uid;
  int get uid => _$this._uid;
  set uid(int uid) => _$this._uid = uid;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  int _me;
  int get me => _$this._me;
  set me(int me) => _$this._me = me;

  int _fansnum;
  int get fansnum => _$this._fansnum;
  set fansnum(int fansnum) => _$this._fansnum = fansnum;

  int _followuidnum;
  int get followuidnum => _$this._followuidnum;
  set followuidnum(int followuidnum) => _$this._followuidnum = followuidnum;

  int _digestposts;
  int get digestposts => _$this._digestposts;
  set digestposts(int digestposts) => _$this._digestposts = digestposts;

  int _extcredits1;
  int get extcredits1 => _$this._extcredits1;
  set extcredits1(int extcredits1) => _$this._extcredits1 = extcredits1;

  int _extcredits2;
  int get extcredits2 => _$this._extcredits2;
  set extcredits2(int extcredits2) => _$this._extcredits2 = extcredits2;

  int _extcredits3;
  int get extcredits3 => _$this._extcredits3;
  set extcredits3(int extcredits3) => _$this._extcredits3 = extcredits3;

  int _extcredits4;
  int get extcredits4 => _$this._extcredits4;
  set extcredits4(int extcredits4) => _$this._extcredits4 = extcredits4;

  int _extcredits5;
  int get extcredits5 => _$this._extcredits5;
  set extcredits5(int extcredits5) => _$this._extcredits5 = extcredits5;

  int _extcredits6;
  int get extcredits6 => _$this._extcredits6;
  set extcredits6(int extcredits6) => _$this._extcredits6 = extcredits6;

  int _extcredits7;
  int get extcredits7 => _$this._extcredits7;
  set extcredits7(int extcredits7) => _$this._extcredits7 = extcredits7;

  int _extcredits8;
  int get extcredits8 => _$this._extcredits8;
  set extcredits8(int extcredits8) => _$this._extcredits8 = extcredits8;

  int _followfidnum;
  int get followfidnum => _$this._followfidnum;
  set followfidnum(int followfidnum) => _$this._followfidnum = followfidnum;

  int _oltime;
  int get oltime => _$this._oltime;
  set oltime(int oltime) => _$this._oltime = oltime;

  int _posts;
  int get posts => _$this._posts;
  set posts(int posts) => _$this._posts = posts;

  int _punchallday;
  int get punchallday => _$this._punchallday;
  set punchallday(int punchallday) => _$this._punchallday = punchallday;

  int _punchday;
  int get punchday => _$this._punchday;
  set punchday(int punchday) => _$this._punchday = punchday;

  int _punchhighestday;
  int get punchhighestday => _$this._punchhighestday;
  set punchhighestday(int punchhighestday) =>
      _$this._punchhighestday = punchhighestday;

  int _punchtime;
  int get punchtime => _$this._punchtime;
  set punchtime(int punchtime) => _$this._punchtime = punchtime;

  String _sendphonemessage;
  String get sendphonemessage => _$this._sendphonemessage;
  set sendphonemessage(String sendphonemessage) =>
      _$this._sendphonemessage = sendphonemessage;

  int _threads;
  int get threads => _$this._threads;
  set threads(int threads) => _$this._threads = threads;

  String _todaypostnum;
  String get todaypostnum => _$this._todaypostnum;
  set todaypostnum(String todaypostnum) => _$this._todaypostnum = todaypostnum;

  bool _isok;
  bool get isok => _$this._isok;
  set isok(bool isok) => _$this._isok = isok;

  UserInfoBuilder();

  UserInfoBuilder get _$this {
    if (_$v != null) {
      _blacklists = _$v.blacklists;
      _customstatus = _$v.customstatus;
      _email = _$v.email;
      _gender = _$v.gender;
      _invite = _$v.invite;
      _phonenum = _$v.phonenum;
      _regdate = _$v.regdate;
      _sightml = _$v.sightml;
      _uid = _$v.uid;
      _username = _$v.username;
      _me = _$v.me;
      _fansnum = _$v.fansnum;
      _followuidnum = _$v.followuidnum;
      _digestposts = _$v.digestposts;
      _extcredits1 = _$v.extcredits1;
      _extcredits2 = _$v.extcredits2;
      _extcredits3 = _$v.extcredits3;
      _extcredits4 = _$v.extcredits4;
      _extcredits5 = _$v.extcredits5;
      _extcredits6 = _$v.extcredits6;
      _extcredits7 = _$v.extcredits7;
      _extcredits8 = _$v.extcredits8;
      _followfidnum = _$v.followfidnum;
      _oltime = _$v.oltime;
      _posts = _$v.posts;
      _punchallday = _$v.punchallday;
      _punchday = _$v.punchday;
      _punchhighestday = _$v.punchhighestday;
      _punchtime = _$v.punchtime;
      _sendphonemessage = _$v.sendphonemessage;
      _threads = _$v.threads;
      _todaypostnum = _$v.todaypostnum;
      _isok = _$v.isok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserInfo;
  }

  @override
  void update(void updates(UserInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$UserInfo build() {
    final _$result = _$v ??
        new _$UserInfo._(
            blacklists: blacklists,
            customstatus: customstatus,
            email: email,
            gender: gender,
            invite: invite,
            phonenum: phonenum,
            regdate: regdate,
            sightml: sightml,
            uid: uid,
            username: username,
            me: me,
            fansnum: fansnum,
            followuidnum: followuidnum,
            digestposts: digestposts,
            extcredits1: extcredits1,
            extcredits2: extcredits2,
            extcredits3: extcredits3,
            extcredits4: extcredits4,
            extcredits5: extcredits5,
            extcredits6: extcredits6,
            extcredits7: extcredits7,
            extcredits8: extcredits8,
            followfidnum: followfidnum,
            oltime: oltime,
            posts: posts,
            punchallday: punchallday,
            punchday: punchday,
            punchhighestday: punchhighestday,
            punchtime: punchtime,
            sendphonemessage: sendphonemessage,
            threads: threads,
            todaypostnum: todaypostnum,
            isok: isok);
    replace(_$result);
    return _$result;
  }
}
