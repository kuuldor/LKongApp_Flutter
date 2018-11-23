// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

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

Serializer<AuthState> _$authStateSerializer = new _$AuthStateSerializer();

class _$AuthStateSerializer implements StructuredSerializer<AuthState> {
  @override
  final Iterable<Type> types = const [AuthState, _$AuthState];
  @override
  final String wireName = 'AuthState';

  @override
  Iterable serialize(Serializers serializers, AuthState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'authed',
      serializers.serialize(object.isAuthed,
          specifiedType: const FullType(bool)),
      'currentUser',
      serializers.serialize(object.currentUser,
          specifiedType: const FullType(User)),
    ];
    if (object.userInfo != null) {
      result
        ..add('userInfo')
        ..add(serializers.serialize(object.userInfo,
            specifiedType: const FullType(UserInfo)));
    }
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  AuthState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'authed':
          result.isAuthed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'currentUser':
          result.currentUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'userInfo':
          result.userInfo.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserInfo)) as UserInfo);
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthState extends AuthState {
  @override
  final bool isAuthed;
  @override
  final User currentUser;
  @override
  final UserInfo userInfo;
  @override
  final String error;

  factory _$AuthState([void updates(AuthStateBuilder b)]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._({this.isAuthed, this.currentUser, this.userInfo, this.error})
      : super._() {
    if (isAuthed == null) {
      throw new BuiltValueNullFieldError('AuthState', 'isAuthed');
    }
    if (currentUser == null) {
      throw new BuiltValueNullFieldError('AuthState', 'currentUser');
    }
  }

  @override
  AuthState rebuild(void updates(AuthStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthStateBuilder toBuilder() => new AuthStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthState &&
        isAuthed == other.isAuthed &&
        currentUser == other.currentUser &&
        userInfo == other.userInfo &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, isAuthed.hashCode), currentUser.hashCode),
            userInfo.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')
          ..add('isAuthed', isAuthed)
          ..add('currentUser', currentUser)
          ..add('userInfo', userInfo)
          ..add('error', error))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  bool _isAuthed;
  bool get isAuthed => _$this._isAuthed;
  set isAuthed(bool isAuthed) => _$this._isAuthed = isAuthed;

  UserBuilder _currentUser;
  UserBuilder get currentUser => _$this._currentUser ??= new UserBuilder();
  set currentUser(UserBuilder currentUser) => _$this._currentUser = currentUser;

  UserInfoBuilder _userInfo;
  UserInfoBuilder get userInfo => _$this._userInfo ??= new UserInfoBuilder();
  set userInfo(UserInfoBuilder userInfo) => _$this._userInfo = userInfo;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  AuthStateBuilder();

  AuthStateBuilder get _$this {
    if (_$v != null) {
      _isAuthed = _$v.isAuthed;
      _currentUser = _$v.currentUser?.toBuilder();
      _userInfo = _$v.userInfo?.toBuilder();
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AuthState;
  }

  @override
  void update(void updates(AuthStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthState build() {
    _$AuthState _$result;
    try {
      _$result = _$v ??
          new _$AuthState._(
              isAuthed: isAuthed,
              currentUser: currentUser.build(),
              userInfo: _userInfo?.build(),
              error: error);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentUser';
        currentUser.build();
        _$failedField = 'userInfo';
        _userInfo?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AuthState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
