// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_playing_status_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BPPlayingStatus {
  /// The current playback position.
  Duration get position => throw _privateConstructorUsedError;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
//todo: 这个是干什么用的？
  DateTime? get absolutePosition => throw _privateConstructorUsedError;

  /// True if the video is isLoading.
  bool get isLoading => throw _privateConstructorUsedError;

  /// True if the video is playing.
  bool get isPlaying => throw _privateConstructorUsedError;

  /// True if it's paused.
  bool get isPaused => throw _privateConstructorUsedError;

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;

  /// The currently buffered ranges.
  bool get isBuffered => throw _privateConstructorUsedError;

  ///是否错误
  bool get hasError => throw _privateConstructorUsedError;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  String? get errorDescription => throw _privateConstructorUsedError;

  /// True if the video is isFinished.
  bool get isFinished => throw _privateConstructorUsedError;

  /// The current volume of the playback.
  double get volume => throw _privateConstructorUsedError;

  /// The current speed of the playback
  double get speed => throw _privateConstructorUsedError;

  ///Is in Picture in Picture Mode
  bool get isPip => throw _privateConstructorUsedError;

  ///Is in Picture in full screenB Mode
  bool get isFullScreen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BPPlayingStatusCopyWith<BPPlayingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPPlayingStatusCopyWith<$Res> {
  factory $BPPlayingStatusCopyWith(
          BPPlayingStatus value, $Res Function(BPPlayingStatus) then) =
      _$BPPlayingStatusCopyWithImpl<$Res>;
  $Res call(
      {Duration position,
      DateTime? absolutePosition,
      bool isLoading,
      bool isPlaying,
      bool isPaused,
      bool isLooping,
      bool isBuffering,
      bool isBuffered,
      bool hasError,
      String? errorDescription,
      bool isFinished,
      double volume,
      double speed,
      bool isPip,
      bool isFullScreen});
}

/// @nodoc
class _$BPPlayingStatusCopyWithImpl<$Res>
    implements $BPPlayingStatusCopyWith<$Res> {
  _$BPPlayingStatusCopyWithImpl(this._value, this._then);

  final BPPlayingStatus _value;
  // ignore: unused_field
  final $Res Function(BPPlayingStatus) _then;

  @override
  $Res call({
    Object? position = freezed,
    Object? absolutePosition = freezed,
    Object? isLoading = freezed,
    Object? isPlaying = freezed,
    Object? isPaused = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? isBuffered = freezed,
    Object? hasError = freezed,
    Object? errorDescription = freezed,
    Object? isFinished = freezed,
    Object? volume = freezed,
    Object? speed = freezed,
    Object? isPip = freezed,
    Object? isFullScreen = freezed,
  }) {
    return _then(_value.copyWith(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      absolutePosition: absolutePosition == freezed
          ? _value.absolutePosition
          : absolutePosition // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: isPaused == freezed
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffered: isBuffered == freezed
          ? _value.isBuffered
          : isBuffered // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorDescription: errorDescription == freezed
          ? _value.errorDescription
          : errorDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: isFinished == freezed
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isPip: isPip == freezed
          ? _value.isPip
          : isPip // ignore: cast_nullable_to_non_nullable
              as bool,
      isFullScreen: isFullScreen == freezed
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_BPPlayingStatusCopyWith<$Res>
    implements $BPPlayingStatusCopyWith<$Res> {
  factory _$$_BPPlayingStatusCopyWith(
          _$_BPPlayingStatus value, $Res Function(_$_BPPlayingStatus) then) =
      __$$_BPPlayingStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {Duration position,
      DateTime? absolutePosition,
      bool isLoading,
      bool isPlaying,
      bool isPaused,
      bool isLooping,
      bool isBuffering,
      bool isBuffered,
      bool hasError,
      String? errorDescription,
      bool isFinished,
      double volume,
      double speed,
      bool isPip,
      bool isFullScreen});
}

/// @nodoc
class __$$_BPPlayingStatusCopyWithImpl<$Res>
    extends _$BPPlayingStatusCopyWithImpl<$Res>
    implements _$$_BPPlayingStatusCopyWith<$Res> {
  __$$_BPPlayingStatusCopyWithImpl(
      _$_BPPlayingStatus _value, $Res Function(_$_BPPlayingStatus) _then)
      : super(_value, (v) => _then(v as _$_BPPlayingStatus));

  @override
  _$_BPPlayingStatus get _value => super._value as _$_BPPlayingStatus;

  @override
  $Res call({
    Object? position = freezed,
    Object? absolutePosition = freezed,
    Object? isLoading = freezed,
    Object? isPlaying = freezed,
    Object? isPaused = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? isBuffered = freezed,
    Object? hasError = freezed,
    Object? errorDescription = freezed,
    Object? isFinished = freezed,
    Object? volume = freezed,
    Object? speed = freezed,
    Object? isPip = freezed,
    Object? isFullScreen = freezed,
  }) {
    return _then(_$_BPPlayingStatus(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      absolutePosition: absolutePosition == freezed
          ? _value.absolutePosition
          : absolutePosition // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: isPaused == freezed
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffered: isBuffered == freezed
          ? _value.isBuffered
          : isBuffered // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorDescription: errorDescription == freezed
          ? _value.errorDescription
          : errorDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: isFinished == freezed
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      isPip: isPip == freezed
          ? _value.isPip
          : isPip // ignore: cast_nullable_to_non_nullable
              as bool,
      isFullScreen: isFullScreen == freezed
          ? _value.isFullScreen
          : isFullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BPPlayingStatus implements _BPPlayingStatus {
  const _$_BPPlayingStatus(
      {this.position = const Duration(),
      this.absolutePosition,
      this.isLoading = false,
      this.isPlaying = false,
      this.isPaused = false,
      this.isLooping = false,
      this.isBuffering = false,
      this.isBuffered = false,
      this.hasError = false,
      this.errorDescription,
      this.isFinished = false,
      this.volume = 1.0,
      this.speed = 1.0,
      this.isPip = false,
      this.isFullScreen = false});

  /// The current playback position.
  @override
  @JsonKey()
  final Duration position;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
//todo: 这个是干什么用的？
  @override
  final DateTime? absolutePosition;

  /// True if the video is isLoading.
  @override
  @JsonKey()
  final bool isLoading;

  /// True if the video is playing.
  @override
  @JsonKey()
  final bool isPlaying;

  /// True if it's paused.
  @override
  @JsonKey()
  final bool isPaused;

  /// True if the video is looping.
  @override
  @JsonKey()
  final bool isLooping;

  /// True if the video is currently buffering.
  @override
  @JsonKey()
  final bool isBuffering;

  /// The currently buffered ranges.
  @override
  @JsonKey()
  final bool isBuffered;

  ///是否错误
  @override
  @JsonKey()
  final bool hasError;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  @override
  final String? errorDescription;

  /// True if the video is isFinished.
  @override
  @JsonKey()
  final bool isFinished;

  /// The current volume of the playback.
  @override
  @JsonKey()
  final double volume;

  /// The current speed of the playback
  @override
  @JsonKey()
  final double speed;

  ///Is in Picture in Picture Mode
  @override
  @JsonKey()
  final bool isPip;

  ///Is in Picture in full screenB Mode
  @override
  @JsonKey()
  final bool isFullScreen;

  @override
  String toString() {
    return 'BPPlayingStatus(position: $position, absolutePosition: $absolutePosition, isLoading: $isLoading, isPlaying: $isPlaying, isPaused: $isPaused, isLooping: $isLooping, isBuffering: $isBuffering, isBuffered: $isBuffered, hasError: $hasError, errorDescription: $errorDescription, isFinished: $isFinished, volume: $volume, speed: $speed, isPip: $isPip, isFullScreen: $isFullScreen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BPPlayingStatus &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality()
                .equals(other.absolutePosition, absolutePosition) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isPlaying, isPlaying) &&
            const DeepCollectionEquality().equals(other.isPaused, isPaused) &&
            const DeepCollectionEquality().equals(other.isLooping, isLooping) &&
            const DeepCollectionEquality()
                .equals(other.isBuffering, isBuffering) &&
            const DeepCollectionEquality()
                .equals(other.isBuffered, isBuffered) &&
            const DeepCollectionEquality().equals(other.hasError, hasError) &&
            const DeepCollectionEquality()
                .equals(other.errorDescription, errorDescription) &&
            const DeepCollectionEquality()
                .equals(other.isFinished, isFinished) &&
            const DeepCollectionEquality().equals(other.volume, volume) &&
            const DeepCollectionEquality().equals(other.speed, speed) &&
            const DeepCollectionEquality().equals(other.isPip, isPip) &&
            const DeepCollectionEquality()
                .equals(other.isFullScreen, isFullScreen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(absolutePosition),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isPlaying),
      const DeepCollectionEquality().hash(isPaused),
      const DeepCollectionEquality().hash(isLooping),
      const DeepCollectionEquality().hash(isBuffering),
      const DeepCollectionEquality().hash(isBuffered),
      const DeepCollectionEquality().hash(hasError),
      const DeepCollectionEquality().hash(errorDescription),
      const DeepCollectionEquality().hash(isFinished),
      const DeepCollectionEquality().hash(volume),
      const DeepCollectionEquality().hash(speed),
      const DeepCollectionEquality().hash(isPip),
      const DeepCollectionEquality().hash(isFullScreen));

  @JsonKey(ignore: true)
  @override
  _$$_BPPlayingStatusCopyWith<_$_BPPlayingStatus> get copyWith =>
      __$$_BPPlayingStatusCopyWithImpl<_$_BPPlayingStatus>(this, _$identity);
}

abstract class _BPPlayingStatus implements BPPlayingStatus {
  const factory _BPPlayingStatus(
      {final Duration position,
      final DateTime? absolutePosition,
      final bool isLoading,
      final bool isPlaying,
      final bool isPaused,
      final bool isLooping,
      final bool isBuffering,
      final bool isBuffered,
      final bool hasError,
      final String? errorDescription,
      final bool isFinished,
      final double volume,
      final double speed,
      final bool isPip,
      final bool isFullScreen}) = _$_BPPlayingStatus;

  @override

  /// The current playback position.
  Duration get position => throw _privateConstructorUsedError;
  @override

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
//todo: 这个是干什么用的？
  DateTime? get absolutePosition => throw _privateConstructorUsedError;
  @override

  /// True if the video is isLoading.
  bool get isLoading => throw _privateConstructorUsedError;
  @override

  /// True if the video is playing.
  bool get isPlaying => throw _privateConstructorUsedError;
  @override

  /// True if it's paused.
  bool get isPaused => throw _privateConstructorUsedError;
  @override

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;
  @override

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;
  @override

  /// The currently buffered ranges.
  bool get isBuffered => throw _privateConstructorUsedError;
  @override

  ///是否错误
  bool get hasError => throw _privateConstructorUsedError;
  @override

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  String? get errorDescription => throw _privateConstructorUsedError;
  @override

  /// True if the video is isFinished.
  bool get isFinished => throw _privateConstructorUsedError;
  @override

  /// The current volume of the playback.
  double get volume => throw _privateConstructorUsedError;
  @override

  /// The current speed of the playback
  double get speed => throw _privateConstructorUsedError;
  @override

  ///Is in Picture in Picture Mode
  bool get isPip => throw _privateConstructorUsedError;
  @override

  ///Is in Picture in full screenB Mode
  bool get isFullScreen => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BPPlayingStatusCopyWith<_$_BPPlayingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
