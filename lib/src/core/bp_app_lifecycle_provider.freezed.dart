// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_app_lifecycle_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BPAppLifecycle {
  ///当前app life cycle状态
  AppLifecycleState get appLifecycleState => throw _privateConstructorUsedError;

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  bool get isHandleLifecycle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BPAppLifecycleCopyWith<BPAppLifecycle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPAppLifecycleCopyWith<$Res> {
  factory $BPAppLifecycleCopyWith(
          BPAppLifecycle value, $Res Function(BPAppLifecycle) then) =
      _$BPAppLifecycleCopyWithImpl<$Res>;
  $Res call({AppLifecycleState appLifecycleState, bool isHandleLifecycle});
}

/// @nodoc
class _$BPAppLifecycleCopyWithImpl<$Res>
    implements $BPAppLifecycleCopyWith<$Res> {
  _$BPAppLifecycleCopyWithImpl(this._value, this._then);

  final BPAppLifecycle _value;
  // ignore: unused_field
  final $Res Function(BPAppLifecycle) _then;

  @override
  $Res call({
    Object? appLifecycleState = freezed,
    Object? isHandleLifecycle = freezed,
  }) {
    return _then(_value.copyWith(
      appLifecycleState: appLifecycleState == freezed
          ? _value.appLifecycleState
          : appLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState,
      isHandleLifecycle: isHandleLifecycle == freezed
          ? _value.isHandleLifecycle
          : isHandleLifecycle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_BPAppLifecycleCopyWith<$Res>
    implements $BPAppLifecycleCopyWith<$Res> {
  factory _$$_BPAppLifecycleCopyWith(
          _$_BPAppLifecycle value, $Res Function(_$_BPAppLifecycle) then) =
      __$$_BPAppLifecycleCopyWithImpl<$Res>;
  @override
  $Res call({AppLifecycleState appLifecycleState, bool isHandleLifecycle});
}

/// @nodoc
class __$$_BPAppLifecycleCopyWithImpl<$Res>
    extends _$BPAppLifecycleCopyWithImpl<$Res>
    implements _$$_BPAppLifecycleCopyWith<$Res> {
  __$$_BPAppLifecycleCopyWithImpl(
      _$_BPAppLifecycle _value, $Res Function(_$_BPAppLifecycle) _then)
      : super(_value, (v) => _then(v as _$_BPAppLifecycle));

  @override
  _$_BPAppLifecycle get _value => super._value as _$_BPAppLifecycle;

  @override
  $Res call({
    Object? appLifecycleState = freezed,
    Object? isHandleLifecycle = freezed,
  }) {
    return _then(_$_BPAppLifecycle(
      appLifecycleState: appLifecycleState == freezed
          ? _value.appLifecycleState
          : appLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState,
      isHandleLifecycle: isHandleLifecycle == freezed
          ? _value.isHandleLifecycle
          : isHandleLifecycle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BPAppLifecycle
    with DiagnosticableTreeMixin
    implements _BPAppLifecycle {
  const _$_BPAppLifecycle(
      {this.appLifecycleState = AppLifecycleState.resumed,
      this.isHandleLifecycle = true});

  ///当前app life cycle状态
  @override
  @JsonKey()
  final AppLifecycleState appLifecycleState;

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  @override
  @JsonKey()
  final bool isHandleLifecycle;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BPAppLifecycle(appLifecycleState: $appLifecycleState, isHandleLifecycle: $isHandleLifecycle)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BPAppLifecycle'))
      ..add(DiagnosticsProperty('appLifecycleState', appLifecycleState))
      ..add(DiagnosticsProperty('isHandleLifecycle', isHandleLifecycle));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BPAppLifecycle &&
            const DeepCollectionEquality()
                .equals(other.appLifecycleState, appLifecycleState) &&
            const DeepCollectionEquality()
                .equals(other.isHandleLifecycle, isHandleLifecycle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appLifecycleState),
      const DeepCollectionEquality().hash(isHandleLifecycle));

  @JsonKey(ignore: true)
  @override
  _$$_BPAppLifecycleCopyWith<_$_BPAppLifecycle> get copyWith =>
      __$$_BPAppLifecycleCopyWithImpl<_$_BPAppLifecycle>(this, _$identity);
}

abstract class _BPAppLifecycle implements BPAppLifecycle {
  const factory _BPAppLifecycle(
      {final AppLifecycleState appLifecycleState,
      final bool isHandleLifecycle}) = _$_BPAppLifecycle;

  @override

  ///当前app life cycle状态
  AppLifecycleState get appLifecycleState => throw _privateConstructorUsedError;
  @override

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  bool get isHandleLifecycle => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BPAppLifecycleCopyWith<_$_BPAppLifecycle> get copyWith =>
      throw _privateConstructorUsedError;
}
