// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_fullscreen_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BPFullscreenConfig {
  ///Flag used to enable/disable fullscreen
  bool get enableFullscreen => throw _privateConstructorUsedError;

  /// Defines if the player will start in fullscreen when play is pressed
  bool get fullScreenByDefault => throw _privateConstructorUsedError;

  /// Defines if the player will sleep in fullscreen or not
  bool get allowedScreenSleep => throw _privateConstructorUsedError;

  /// Defines the set of allowed device orientations on entering fullscreen
  List<DeviceOrientation> get deviceOrientationsOnFullScreen =>
      throw _privateConstructorUsedError;

  /// Defines the system overlays visible after exiting fullscreen
  List<SystemUiOverlay> get systemOverlaysAfterFullScreen =>
      throw _privateConstructorUsedError;

  /// Defines the set of allowed device orientations after exiting fullscreen
  List<DeviceOrientation> get deviceOrientationsAfterFullScreen =>
      throw _privateConstructorUsedError;

  ///Defines if player should auto detect full screen device orientation based
  ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
  ///video will played in full screen in portrait mode. If aspect ratio is >= 1
  ///then video will be played horizontally. If this parameter is true, then
  ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
  /// ignored.
  bool get autoDetectFullscreenDeviceOrientation =>
      throw _privateConstructorUsedError;

  /// Defines aspect ratio which will be used in fullscreen
  double? get fullScreenAspectRatio => throw _privateConstructorUsedError;

  ///Defines if player should auto detect full screen aspect ration of the video.
  ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
  bool get autoDetectFullscreenAspectRatio =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BPFullscreenConfigCopyWith<BPFullscreenConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPFullscreenConfigCopyWith<$Res> {
  factory $BPFullscreenConfigCopyWith(
          BPFullscreenConfig value, $Res Function(BPFullscreenConfig) then) =
      _$BPFullscreenConfigCopyWithImpl<$Res>;
  $Res call(
      {bool enableFullscreen,
      bool fullScreenByDefault,
      bool allowedScreenSleep,
      List<DeviceOrientation> deviceOrientationsOnFullScreen,
      List<SystemUiOverlay> systemOverlaysAfterFullScreen,
      List<DeviceOrientation> deviceOrientationsAfterFullScreen,
      bool autoDetectFullscreenDeviceOrientation,
      double? fullScreenAspectRatio,
      bool autoDetectFullscreenAspectRatio});
}

/// @nodoc
class _$BPFullscreenConfigCopyWithImpl<$Res>
    implements $BPFullscreenConfigCopyWith<$Res> {
  _$BPFullscreenConfigCopyWithImpl(this._value, this._then);

  final BPFullscreenConfig _value;
  // ignore: unused_field
  final $Res Function(BPFullscreenConfig) _then;

  @override
  $Res call({
    Object? enableFullscreen = freezed,
    Object? fullScreenByDefault = freezed,
    Object? allowedScreenSleep = freezed,
    Object? deviceOrientationsOnFullScreen = freezed,
    Object? systemOverlaysAfterFullScreen = freezed,
    Object? deviceOrientationsAfterFullScreen = freezed,
    Object? autoDetectFullscreenDeviceOrientation = freezed,
    Object? fullScreenAspectRatio = freezed,
    Object? autoDetectFullscreenAspectRatio = freezed,
  }) {
    return _then(_value.copyWith(
      enableFullscreen: enableFullscreen == freezed
          ? _value.enableFullscreen
          : enableFullscreen // ignore: cast_nullable_to_non_nullable
              as bool,
      fullScreenByDefault: fullScreenByDefault == freezed
          ? _value.fullScreenByDefault
          : fullScreenByDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      allowedScreenSleep: allowedScreenSleep == freezed
          ? _value.allowedScreenSleep
          : allowedScreenSleep // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceOrientationsOnFullScreen: deviceOrientationsOnFullScreen == freezed
          ? _value.deviceOrientationsOnFullScreen
          : deviceOrientationsOnFullScreen // ignore: cast_nullable_to_non_nullable
              as List<DeviceOrientation>,
      systemOverlaysAfterFullScreen: systemOverlaysAfterFullScreen == freezed
          ? _value.systemOverlaysAfterFullScreen
          : systemOverlaysAfterFullScreen // ignore: cast_nullable_to_non_nullable
              as List<SystemUiOverlay>,
      deviceOrientationsAfterFullScreen: deviceOrientationsAfterFullScreen ==
              freezed
          ? _value.deviceOrientationsAfterFullScreen
          : deviceOrientationsAfterFullScreen // ignore: cast_nullable_to_non_nullable
              as List<DeviceOrientation>,
      autoDetectFullscreenDeviceOrientation:
          autoDetectFullscreenDeviceOrientation == freezed
              ? _value.autoDetectFullscreenDeviceOrientation
              : autoDetectFullscreenDeviceOrientation // ignore: cast_nullable_to_non_nullable
                  as bool,
      fullScreenAspectRatio: fullScreenAspectRatio == freezed
          ? _value.fullScreenAspectRatio
          : fullScreenAspectRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      autoDetectFullscreenAspectRatio: autoDetectFullscreenAspectRatio ==
              freezed
          ? _value.autoDetectFullscreenAspectRatio
          : autoDetectFullscreenAspectRatio // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$BPFullscreenConfigCopyWith<$Res>
    implements $BPFullscreenConfigCopyWith<$Res> {
  factory _$BPFullscreenConfigCopyWith(
          _BPFullscreenConfig value, $Res Function(_BPFullscreenConfig) then) =
      __$BPFullscreenConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool enableFullscreen,
      bool fullScreenByDefault,
      bool allowedScreenSleep,
      List<DeviceOrientation> deviceOrientationsOnFullScreen,
      List<SystemUiOverlay> systemOverlaysAfterFullScreen,
      List<DeviceOrientation> deviceOrientationsAfterFullScreen,
      bool autoDetectFullscreenDeviceOrientation,
      double? fullScreenAspectRatio,
      bool autoDetectFullscreenAspectRatio});
}

/// @nodoc
class __$BPFullscreenConfigCopyWithImpl<$Res>
    extends _$BPFullscreenConfigCopyWithImpl<$Res>
    implements _$BPFullscreenConfigCopyWith<$Res> {
  __$BPFullscreenConfigCopyWithImpl(
      _BPFullscreenConfig _value, $Res Function(_BPFullscreenConfig) _then)
      : super(_value, (v) => _then(v as _BPFullscreenConfig));

  @override
  _BPFullscreenConfig get _value => super._value as _BPFullscreenConfig;

  @override
  $Res call({
    Object? enableFullscreen = freezed,
    Object? fullScreenByDefault = freezed,
    Object? allowedScreenSleep = freezed,
    Object? deviceOrientationsOnFullScreen = freezed,
    Object? systemOverlaysAfterFullScreen = freezed,
    Object? deviceOrientationsAfterFullScreen = freezed,
    Object? autoDetectFullscreenDeviceOrientation = freezed,
    Object? fullScreenAspectRatio = freezed,
    Object? autoDetectFullscreenAspectRatio = freezed,
  }) {
    return _then(_BPFullscreenConfig(
      enableFullscreen: enableFullscreen == freezed
          ? _value.enableFullscreen
          : enableFullscreen // ignore: cast_nullable_to_non_nullable
              as bool,
      fullScreenByDefault: fullScreenByDefault == freezed
          ? _value.fullScreenByDefault
          : fullScreenByDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      allowedScreenSleep: allowedScreenSleep == freezed
          ? _value.allowedScreenSleep
          : allowedScreenSleep // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceOrientationsOnFullScreen: deviceOrientationsOnFullScreen == freezed
          ? _value.deviceOrientationsOnFullScreen
          : deviceOrientationsOnFullScreen // ignore: cast_nullable_to_non_nullable
              as List<DeviceOrientation>,
      systemOverlaysAfterFullScreen: systemOverlaysAfterFullScreen == freezed
          ? _value.systemOverlaysAfterFullScreen
          : systemOverlaysAfterFullScreen // ignore: cast_nullable_to_non_nullable
              as List<SystemUiOverlay>,
      deviceOrientationsAfterFullScreen: deviceOrientationsAfterFullScreen ==
              freezed
          ? _value.deviceOrientationsAfterFullScreen
          : deviceOrientationsAfterFullScreen // ignore: cast_nullable_to_non_nullable
              as List<DeviceOrientation>,
      autoDetectFullscreenDeviceOrientation:
          autoDetectFullscreenDeviceOrientation == freezed
              ? _value.autoDetectFullscreenDeviceOrientation
              : autoDetectFullscreenDeviceOrientation // ignore: cast_nullable_to_non_nullable
                  as bool,
      fullScreenAspectRatio: fullScreenAspectRatio == freezed
          ? _value.fullScreenAspectRatio
          : fullScreenAspectRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      autoDetectFullscreenAspectRatio: autoDetectFullscreenAspectRatio ==
              freezed
          ? _value.autoDetectFullscreenAspectRatio
          : autoDetectFullscreenAspectRatio // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BPFullscreenConfig implements _BPFullscreenConfig {
  const _$_BPFullscreenConfig(
      {this.enableFullscreen = true,
      this.fullScreenByDefault = false,
      this.allowedScreenSleep = false,
      final List<DeviceOrientation> deviceOrientationsOnFullScreen = const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      final List<SystemUiOverlay> systemOverlaysAfterFullScreen =
          SystemUiOverlay.values,
      final List<DeviceOrientation> deviceOrientationsAfterFullScreen = const [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      this.autoDetectFullscreenDeviceOrientation = false,
      this.fullScreenAspectRatio,
      this.autoDetectFullscreenAspectRatio = false})
      : _deviceOrientationsOnFullScreen = deviceOrientationsOnFullScreen,
        _systemOverlaysAfterFullScreen = systemOverlaysAfterFullScreen,
        _deviceOrientationsAfterFullScreen = deviceOrientationsAfterFullScreen;

  ///Flag used to enable/disable fullscreen
  @override
  @JsonKey()
  final bool enableFullscreen;

  /// Defines if the player will start in fullscreen when play is pressed
  @override
  @JsonKey()
  final bool fullScreenByDefault;

  /// Defines if the player will sleep in fullscreen or not
  @override
  @JsonKey()
  final bool allowedScreenSleep;

  /// Defines the set of allowed device orientations on entering fullscreen
  final List<DeviceOrientation> _deviceOrientationsOnFullScreen;

  /// Defines the set of allowed device orientations on entering fullscreen
  @override
  @JsonKey()
  List<DeviceOrientation> get deviceOrientationsOnFullScreen {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceOrientationsOnFullScreen);
  }

  /// Defines the system overlays visible after exiting fullscreen
  final List<SystemUiOverlay> _systemOverlaysAfterFullScreen;

  /// Defines the system overlays visible after exiting fullscreen
  @override
  @JsonKey()
  List<SystemUiOverlay> get systemOverlaysAfterFullScreen {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_systemOverlaysAfterFullScreen);
  }

  /// Defines the set of allowed device orientations after exiting fullscreen
  final List<DeviceOrientation> _deviceOrientationsAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  @override
  @JsonKey()
  List<DeviceOrientation> get deviceOrientationsAfterFullScreen {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceOrientationsAfterFullScreen);
  }

  ///Defines if player should auto detect full screen device orientation based
  ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
  ///video will played in full screen in portrait mode. If aspect ratio is >= 1
  ///then video will be played horizontally. If this parameter is true, then
  ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
  /// ignored.
  @override
  @JsonKey()
  final bool autoDetectFullscreenDeviceOrientation;

  /// Defines aspect ratio which will be used in fullscreen
  @override
  final double? fullScreenAspectRatio;

  ///Defines if player should auto detect full screen aspect ration of the video.
  ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
  @override
  @JsonKey()
  final bool autoDetectFullscreenAspectRatio;

  @override
  String toString() {
    return 'BPFullscreenConfig(enableFullscreen: $enableFullscreen, fullScreenByDefault: $fullScreenByDefault, allowedScreenSleep: $allowedScreenSleep, deviceOrientationsOnFullScreen: $deviceOrientationsOnFullScreen, systemOverlaysAfterFullScreen: $systemOverlaysAfterFullScreen, deviceOrientationsAfterFullScreen: $deviceOrientationsAfterFullScreen, autoDetectFullscreenDeviceOrientation: $autoDetectFullscreenDeviceOrientation, fullScreenAspectRatio: $fullScreenAspectRatio, autoDetectFullscreenAspectRatio: $autoDetectFullscreenAspectRatio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BPFullscreenConfig &&
            const DeepCollectionEquality()
                .equals(other.enableFullscreen, enableFullscreen) &&
            const DeepCollectionEquality()
                .equals(other.fullScreenByDefault, fullScreenByDefault) &&
            const DeepCollectionEquality()
                .equals(other.allowedScreenSleep, allowedScreenSleep) &&
            const DeepCollectionEquality().equals(
                other.deviceOrientationsOnFullScreen,
                deviceOrientationsOnFullScreen) &&
            const DeepCollectionEquality().equals(
                other.systemOverlaysAfterFullScreen,
                systemOverlaysAfterFullScreen) &&
            const DeepCollectionEquality().equals(
                other.deviceOrientationsAfterFullScreen,
                deviceOrientationsAfterFullScreen) &&
            const DeepCollectionEquality().equals(
                other.autoDetectFullscreenDeviceOrientation,
                autoDetectFullscreenDeviceOrientation) &&
            const DeepCollectionEquality()
                .equals(other.fullScreenAspectRatio, fullScreenAspectRatio) &&
            const DeepCollectionEquality().equals(
                other.autoDetectFullscreenAspectRatio,
                autoDetectFullscreenAspectRatio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(enableFullscreen),
      const DeepCollectionEquality().hash(fullScreenByDefault),
      const DeepCollectionEquality().hash(allowedScreenSleep),
      const DeepCollectionEquality().hash(deviceOrientationsOnFullScreen),
      const DeepCollectionEquality().hash(systemOverlaysAfterFullScreen),
      const DeepCollectionEquality().hash(deviceOrientationsAfterFullScreen),
      const DeepCollectionEquality()
          .hash(autoDetectFullscreenDeviceOrientation),
      const DeepCollectionEquality().hash(fullScreenAspectRatio),
      const DeepCollectionEquality().hash(autoDetectFullscreenAspectRatio));

  @JsonKey(ignore: true)
  @override
  _$BPFullscreenConfigCopyWith<_BPFullscreenConfig> get copyWith =>
      __$BPFullscreenConfigCopyWithImpl<_BPFullscreenConfig>(this, _$identity);
}

abstract class _BPFullscreenConfig implements BPFullscreenConfig {
  const factory _BPFullscreenConfig(
      {final bool enableFullscreen,
      final bool fullScreenByDefault,
      final bool allowedScreenSleep,
      final List<DeviceOrientation> deviceOrientationsOnFullScreen,
      final List<SystemUiOverlay> systemOverlaysAfterFullScreen,
      final List<DeviceOrientation> deviceOrientationsAfterFullScreen,
      final bool autoDetectFullscreenDeviceOrientation,
      final double? fullScreenAspectRatio,
      final bool autoDetectFullscreenAspectRatio}) = _$_BPFullscreenConfig;

  @override

  ///Flag used to enable/disable fullscreen
  bool get enableFullscreen => throw _privateConstructorUsedError;
  @override

  /// Defines if the player will start in fullscreen when play is pressed
  bool get fullScreenByDefault => throw _privateConstructorUsedError;
  @override

  /// Defines if the player will sleep in fullscreen or not
  bool get allowedScreenSleep => throw _privateConstructorUsedError;
  @override

  /// Defines the set of allowed device orientations on entering fullscreen
  List<DeviceOrientation> get deviceOrientationsOnFullScreen =>
      throw _privateConstructorUsedError;
  @override

  /// Defines the system overlays visible after exiting fullscreen
  List<SystemUiOverlay> get systemOverlaysAfterFullScreen =>
      throw _privateConstructorUsedError;
  @override

  /// Defines the set of allowed device orientations after exiting fullscreen
  List<DeviceOrientation> get deviceOrientationsAfterFullScreen =>
      throw _privateConstructorUsedError;
  @override

  ///Defines if player should auto detect full screen device orientation based
  ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
  ///video will played in full screen in portrait mode. If aspect ratio is >= 1
  ///then video will be played horizontally. If this parameter is true, then
  ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
  /// ignored.
  bool get autoDetectFullscreenDeviceOrientation =>
      throw _privateConstructorUsedError;
  @override

  /// Defines aspect ratio which will be used in fullscreen
  double? get fullScreenAspectRatio => throw _privateConstructorUsedError;
  @override

  ///Defines if player should auto detect full screen aspect ration of the video.
  ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
  bool get autoDetectFullscreenAspectRatio =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BPFullscreenConfigCopyWith<_BPFullscreenConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
