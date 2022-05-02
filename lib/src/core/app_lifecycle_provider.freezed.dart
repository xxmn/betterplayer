// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_lifecycle_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppLifecycle {
  ///当前app life cycle状态
  AppLifecycleState get appLifecycleState => throw _privateConstructorUsedError;

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  bool get isHandleLifecycle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppLifecycleCopyWith<AppLifecycle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLifecycleCopyWith<$Res> {
  factory $AppLifecycleCopyWith(AppLifecycle value, $Res Function(AppLifecycle) then) =
      _$AppLifecycleCopyWithImpl<$Res>;
  $Res call({AppLifecycleState appLifecycleState, bool isHandleLifecycle});
}

/// @nodoc
class _$AppLifecycleCopyWithImpl<$Res> implements $AppLifecycleCopyWith<$Res> {
  _$AppLifecycleCopyWithImpl(this._value, this._then);

  final AppLifecycle _value;
  // ignore: unused_field
  final $Res Function(AppLifecycle) _then;

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
abstract class _$AppLifecycleCopyWith<$Res> implements $AppLifecycleCopyWith<$Res> {
  factory _$AppLifecycleCopyWith(_AppLifecycle value, $Res Function(_AppLifecycle) then) =
      __$AppLifecycleCopyWithImpl<$Res>;
  @override
  $Res call({AppLifecycleState appLifecycleState, bool isHandleLifecycle});
}

/// @nodoc
class __$AppLifecycleCopyWithImpl<$Res> extends _$AppLifecycleCopyWithImpl<$Res>
    implements _$AppLifecycleCopyWith<$Res> {
  __$AppLifecycleCopyWithImpl(_AppLifecycle _value, $Res Function(_AppLifecycle) _then)
      : super(_value, (v) => _then(v as _AppLifecycle));

  @override
  _AppLifecycle get _value => super._value as _AppLifecycle;

  @override
  $Res call({
    Object? appLifecycleState = freezed,
    Object? isHandleLifecycle = freezed,
  }) {
    return _then(_AppLifecycle(
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

class _$_AppLifecycle with DiagnosticableTreeMixin implements _AppLifecycle {
  const _$_AppLifecycle(
      {this.appLifecycleState = AppLifecycleState.resumed, required this.isHandleLifecycle});

  ///当前app life cycle状态
  @override
  @JsonKey()
  final AppLifecycleState appLifecycleState;

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  @override
  final bool isHandleLifecycle;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppLifecycle(appLifecycleState: $appLifecycleState, isHandleLifecycle: $isHandleLifecycle)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppLifecycle'))
      ..add(DiagnosticsProperty('appLifecycleState', appLifecycleState))
      ..add(DiagnosticsProperty('isHandleLifecycle', isHandleLifecycle));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppLifecycle &&
            const DeepCollectionEquality().equals(other.appLifecycleState, appLifecycleState) &&
            const DeepCollectionEquality().equals(other.isHandleLifecycle, isHandleLifecycle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appLifecycleState),
      const DeepCollectionEquality().hash(isHandleLifecycle));

  @JsonKey(ignore: true)
  @override
  _$AppLifecycleCopyWith<_AppLifecycle> get copyWith =>
      __$AppLifecycleCopyWithImpl<_AppLifecycle>(this, _$identity);
}

abstract class _AppLifecycle implements AppLifecycle {
  const factory _AppLifecycle(
      {final AppLifecycleState appLifecycleState,
      required final bool isHandleLifecycle}) = _$_AppLifecycle;

  @override

  ///当前app life cycle状态
  AppLifecycleState get appLifecycleState => throw _privateConstructorUsedError;
  @override

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  bool get isHandleLifecycle => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AppLifecycleCopyWith<_AppLifecycle> get copyWith => throw _privateConstructorUsedError;
}
