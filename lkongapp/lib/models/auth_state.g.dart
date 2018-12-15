// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
          specifiedType: const FullType(int)),
      'lastUser',
      serializers.serialize(object.lastUser,
          specifiedType: const FullType(int)),
      'userRepo',
      serializers.serialize(object.userRepo,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(int), const FullType(User)])),
    ];
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
          result.currentUser = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lastUser':
          result.lastUser = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userRepo':
          result.userRepo.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(User)
              ])) as BuiltMap);
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
  final int currentUser;
  @override
  final int lastUser;
  @override
  final BuiltMap<int, User> userRepo;
  @override
  final String error;

  factory _$AuthState([void updates(AuthStateBuilder b)]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._(
      {this.isAuthed,
      this.currentUser,
      this.lastUser,
      this.userRepo,
      this.error})
      : super._() {
    if (isAuthed == null) {
      throw new BuiltValueNullFieldError('AuthState', 'isAuthed');
    }
    if (currentUser == null) {
      throw new BuiltValueNullFieldError('AuthState', 'currentUser');
    }
    if (lastUser == null) {
      throw new BuiltValueNullFieldError('AuthState', 'lastUser');
    }
    if (userRepo == null) {
      throw new BuiltValueNullFieldError('AuthState', 'userRepo');
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
        lastUser == other.lastUser &&
        userRepo == other.userRepo &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, isAuthed.hashCode), currentUser.hashCode),
                lastUser.hashCode),
            userRepo.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')
          ..add('isAuthed', isAuthed)
          ..add('currentUser', currentUser)
          ..add('lastUser', lastUser)
          ..add('userRepo', userRepo)
          ..add('error', error))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  bool _isAuthed;
  bool get isAuthed => _$this._isAuthed;
  set isAuthed(bool isAuthed) => _$this._isAuthed = isAuthed;

  int _currentUser;
  int get currentUser => _$this._currentUser;
  set currentUser(int currentUser) => _$this._currentUser = currentUser;

  int _lastUser;
  int get lastUser => _$this._lastUser;
  set lastUser(int lastUser) => _$this._lastUser = lastUser;

  MapBuilder<int, User> _userRepo;
  MapBuilder<int, User> get userRepo =>
      _$this._userRepo ??= new MapBuilder<int, User>();
  set userRepo(MapBuilder<int, User> userRepo) => _$this._userRepo = userRepo;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  AuthStateBuilder();

  AuthStateBuilder get _$this {
    if (_$v != null) {
      _isAuthed = _$v.isAuthed;
      _currentUser = _$v.currentUser;
      _lastUser = _$v.lastUser;
      _userRepo = _$v.userRepo?.toBuilder();
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
              currentUser: currentUser,
              lastUser: lastUser,
              userRepo: userRepo.build(),
              error: error);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userRepo';
        userRepo.build();
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

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
