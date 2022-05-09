// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_video_sction_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$_BPVideoSctionConfig {
  int get length => throw _privateConstructorUsedError;
  bool? get isShow => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$BPVideoSctionConfigCopyWith<_BPVideoSctionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BPVideoSctionConfigCopyWith<$Res> {
  factory _$BPVideoSctionConfigCopyWith(_BPVideoSctionConfig value,
          $Res Function(_BPVideoSctionConfig) then) =
      __$BPVideoSctionConfigCopyWithImpl<$Res>;
  $Res call({int length, bool? isShow, int index});
}

/// @nodoc
class __$BPVideoSctionConfigCopyWithImpl<$Res>
    implements _$BPVideoSctionConfigCopyWith<$Res> {
  __$BPVideoSctionConfigCopyWithImpl(this._value, this._then);

  final _BPVideoSctionConfig _value;
  // ignore: unused_field
  final $Res Function(_BPVideoSctionConfig) _then;

  @override
  $Res call({
    Object? length = freezed,
    Object? isShow = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      isShow: isShow == freezed
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$_BPVideoSctionConfigCopyWith<$Res>
    implements _$BPVideoSctionConfigCopyWith<$Res> {
  factory _$_BPVideoSctionConfigCopyWith(__BPVideoSctionConfig value,
          $Res Function(__BPVideoSctionConfig) then) =
      __$_BPVideoSctionConfigCopyWithImpl<$Res>;
  @override
  $Res call({int length, bool? isShow, int index});
}

/// @nodoc
class __$_BPVideoSctionConfigCopyWithImpl<$Res>
    extends __$BPVideoSctionConfigCopyWithImpl<$Res>
    implements _$_BPVideoSctionConfigCopyWith<$Res> {
  __$_BPVideoSctionConfigCopyWithImpl(
      __BPVideoSctionConfig _value, $Res Function(__BPVideoSctionConfig) _then)
      : super(_value, (v) => _then(v as __BPVideoSctionConfig));

  @override
  __BPVideoSctionConfig get _value => super._value as __BPVideoSctionConfig;

  @override
  $Res call({
    Object? length = freezed,
    Object? isShow = freezed,
    Object? index = freezed,
  }) {
    return _then(__BPVideoSctionConfig(
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      isShow: isShow == freezed
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$__BPVideoSctionConfig
    with DiagnosticableTreeMixin
    implements __BPVideoSctionConfig {
  const _$__BPVideoSctionConfig(
      {required this.length, this.isShow = true, this.index = 0});

  @override
  final int length;
  @override
  @JsonKey()
  final bool? isShow;
  @override
  @JsonKey()
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_BPVideoSctionConfig(length: $length, isShow: $isShow, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_BPVideoSctionConfig'))
      ..add(DiagnosticsProperty('length', length))
      ..add(DiagnosticsProperty('isShow', isShow))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __BPVideoSctionConfig &&
            const DeepCollectionEquality().equals(other.length, length) &&
            const DeepCollectionEquality().equals(other.isShow, isShow) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(length),
      const DeepCollectionEquality().hash(isShow),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$_BPVideoSctionConfigCopyWith<__BPVideoSctionConfig> get copyWith =>
      __$_BPVideoSctionConfigCopyWithImpl<__BPVideoSctionConfig>(
          this, _$identity);
}

abstract class __BPVideoSctionConfig implements _BPVideoSctionConfig {
  const factory __BPVideoSctionConfig(
      {required final int length,
      final bool? isShow,
      final int index}) = _$__BPVideoSctionConfig;

  @override
  int get length => throw _privateConstructorUsedError;
  @override
  bool? get isShow => throw _privateConstructorUsedError;
  @override
  int get index => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$_BPVideoSctionConfigCopyWith<__BPVideoSctionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
