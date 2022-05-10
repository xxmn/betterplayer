// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'np_create_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateStatus {
  int? get textureId => throw _privateConstructorUsedError;
  bool get isCreated => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateStatusCopyWith<CreateStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateStatusCopyWith<$Res> {
  factory $CreateStatusCopyWith(
          CreateStatus value, $Res Function(CreateStatus) then) =
      _$CreateStatusCopyWithImpl<$Res>;
  $Res call({int? textureId, bool isCreated});
}

/// @nodoc
class _$CreateStatusCopyWithImpl<$Res> implements $CreateStatusCopyWith<$Res> {
  _$CreateStatusCopyWithImpl(this._value, this._then);

  final CreateStatus _value;
  // ignore: unused_field
  final $Res Function(CreateStatus) _then;

  @override
  $Res call({
    Object? textureId = freezed,
    Object? isCreated = freezed,
  }) {
    return _then(_value.copyWith(
      textureId: textureId == freezed
          ? _value.textureId
          : textureId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCreated: isCreated == freezed
          ? _value.isCreated
          : isCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CreateStatusCopyWith<$Res>
    implements $CreateStatusCopyWith<$Res> {
  factory _$$_CreateStatusCopyWith(
          _$_CreateStatus value, $Res Function(_$_CreateStatus) then) =
      __$$_CreateStatusCopyWithImpl<$Res>;
  @override
  $Res call({int? textureId, bool isCreated});
}

/// @nodoc
class __$$_CreateStatusCopyWithImpl<$Res>
    extends _$CreateStatusCopyWithImpl<$Res>
    implements _$$_CreateStatusCopyWith<$Res> {
  __$$_CreateStatusCopyWithImpl(
      _$_CreateStatus _value, $Res Function(_$_CreateStatus) _then)
      : super(_value, (v) => _then(v as _$_CreateStatus));

  @override
  _$_CreateStatus get _value => super._value as _$_CreateStatus;

  @override
  $Res call({
    Object? textureId = freezed,
    Object? isCreated = freezed,
  }) {
    return _then(_$_CreateStatus(
      textureId: textureId == freezed
          ? _value.textureId
          : textureId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCreated: isCreated == freezed
          ? _value.isCreated
          : isCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CreateStatus implements _CreateStatus {
  const _$_CreateStatus({this.textureId, this.isCreated = false});

  @override
  final int? textureId;
  @override
  @JsonKey()
  final bool isCreated;

  @override
  String toString() {
    return 'CreateStatus(textureId: $textureId, isCreated: $isCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateStatus &&
            const DeepCollectionEquality().equals(other.textureId, textureId) &&
            const DeepCollectionEquality().equals(other.isCreated, isCreated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textureId),
      const DeepCollectionEquality().hash(isCreated));

  @JsonKey(ignore: true)
  @override
  _$$_CreateStatusCopyWith<_$_CreateStatus> get copyWith =>
      __$$_CreateStatusCopyWithImpl<_$_CreateStatus>(this, _$identity);
}

abstract class _CreateStatus implements CreateStatus {
  const factory _CreateStatus({final int? textureId, final bool isCreated}) =
      _$_CreateStatus;

  @override
  int? get textureId => throw _privateConstructorUsedError;
  @override
  bool get isCreated => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CreateStatusCopyWith<_$_CreateStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
