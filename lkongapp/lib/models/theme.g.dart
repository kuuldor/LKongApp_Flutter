// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppTheme> _$appThemeSerializer = new _$AppThemeSerializer();

class _$AppThemeSerializer implements StructuredSerializer<AppTheme> {
  @override
  final Iterable<Type> types = const [AppTheme, _$AppTheme];
  @override
  final String wireName = 'AppTheme';

  @override
  Iterable serialize(Serializers serializers, AppTheme object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'colors',
      serializers.serialize(object.colors,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
    ];

    return result;
  }

  @override
  AppTheme deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppThemeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'colors':
          result.colors.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(String)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$AppTheme extends AppTheme {
  @override
  final String name;
  @override
  final BuiltMap<String, String> colors;

  factory _$AppTheme([void updates(AppThemeBuilder b)]) =>
      (new AppThemeBuilder()..update(updates)).build();

  _$AppTheme._({this.name, this.colors}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('AppTheme', 'name');
    }
    if (colors == null) {
      throw new BuiltValueNullFieldError('AppTheme', 'colors');
    }
  }

  @override
  AppTheme rebuild(void updates(AppThemeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppThemeBuilder toBuilder() => new AppThemeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppTheme && name == other.name && colors == other.colors;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), colors.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppTheme')
          ..add('name', name)
          ..add('colors', colors))
        .toString();
  }
}

class AppThemeBuilder implements Builder<AppTheme, AppThemeBuilder> {
  _$AppTheme _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  MapBuilder<String, String> _colors;
  MapBuilder<String, String> get colors =>
      _$this._colors ??= new MapBuilder<String, String>();
  set colors(MapBuilder<String, String> colors) => _$this._colors = colors;

  AppThemeBuilder();

  AppThemeBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _colors = _$v.colors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppTheme other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppTheme;
  }

  @override
  void update(void updates(AppThemeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppTheme build() {
    _$AppTheme _$result;
    try {
      _$result = _$v ?? new _$AppTheme._(name: name, colors: colors.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'colors';
        colors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppTheme', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
