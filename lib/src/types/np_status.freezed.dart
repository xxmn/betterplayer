// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'np_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NPStatus {
  /// The total duration of the video.
  ///
  /// Is null when [initialized] is false.
  Duration? get duration => throw _privateConstructorUsedError;

  /// The current playback position.
  Duration? get position => throw _privateConstructorUsedError;

  /// seek 动作
  Duration? get seekTo => throw _privateConstructorUsedError;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
  DateTime? get absolutePosition => throw _privateConstructorUsedError;

  /// The currently buffered ranges.
  List<DurationRange>? get buffered => throw _privateConstructorUsedError;

  /// True if the video is playing. False if it's paused.
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isPlayWhenReady => throw _privateConstructorUsedError;

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;

  /// 播放完成
  bool get isCompleted => throw _privateConstructorUsedError;

  /// The current volume of the playback.
  double get volume => throw _privateConstructorUsedError;

  /// The previous volume of the playback.
  double get previousVolume => throw _privateConstructorUsedError;

  /// The current speed of the playback
  double get speed => throw _privateConstructorUsedError;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  String? get errorDescription => throw _privateConstructorUsedError;

  /// The [size] of the currently loaded video.
  ///
  /// Is null when [initialized] is false.
  Size? get size => throw _privateConstructorUsedError;

  ///Is in Picture in Picture Mode
  bool get isPip => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NPStatusCopyWith<NPStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NPStatusCopyWith<$Res> {
  factory $NPStatusCopyWith(NPStatus value, $Res Function(NPStatus) then) =
      _$NPStatusCopyWithImpl<$Res>;
  $Res call(
      {Duration? duration,
      Duration? position,
      Duration? seekTo,
      DateTime? absolutePosition,
      List<DurationRange>? buffered,
      bool isPlaying,
      bool isPlayWhenReady,
      bool isLooping,
      bool isBuffering,
      bool isCompleted,
      double volume,
      double previousVolume,
      double speed,
      String? errorDescription,
      Size? size,
      bool isPip});
}

/// @nodoc
class _$NPStatusCopyWithImpl<$Res> implements $NPStatusCopyWith<$Res> {
  _$NPStatusCopyWithImpl(this._value, this._then);

  final NPStatus _value;
  // ignore: unused_field
  final $Res Function(NPStatus) _then;

  @override
  $Res call({
    Object? duration = freezed,
    Object? position = freezed,
    Object? seekTo = freezed,
    Object? absolutePosition = freezed,
    Object? buffered = freezed,
    Object? isPlaying = freezed,
    Object? isPlayWhenReady = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? isCompleted = freezed,
    Object? volume = freezed,
    Object? previousVolume = freezed,
    Object? speed = freezed,
    Object? errorDescription = freezed,
    Object? size = freezed,
    Object? isPip = freezed,
  }) {
    return _then(_value.copyWith(
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
      seekTo: seekTo == freezed
          ? _value.seekTo
          : seekTo // ignore: cast_nullable_to_non_nullable
              as Duration?,
      absolutePosition: absolutePosition == freezed
          ? _value.absolutePosition
          : absolutePosition // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      buffered: buffered == freezed
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>?,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlayWhenReady: isPlayWhenReady == freezed
          ? _value.isPlayWhenReady
          : isPlayWhenReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      previousVolume: previousVolume == freezed
          ? _value.previousVolume
          : previousVolume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      errorDescription: errorDescription == freezed
          ? _value.errorDescription
          : errorDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      isPip: isPip == freezed
          ? _value.isPip
          : isPip // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_NPStatusCopyWith<$Res> implements $NPStatusCopyWith<$Res> {
  factory _$$_NPStatusCopyWith(
          _$_NPStatus value, $Res Function(_$_NPStatus) then) =
      __$$_NPStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {Duration? duration,
      Duration? position,
      Duration? seekTo,
      DateTime? absolutePosition,
      List<DurationRange>? buffered,
      bool isPlaying,
      bool isPlayWhenReady,
      bool isLooping,
      bool isBuffering,
      bool isCompleted,
      double volume,
      double previousVolume,
      double speed,
      String? errorDescription,
      Size? size,
      bool isPip});
}

/// @nodoc
class __$$_NPStatusCopyWithImpl<$Res> extends _$NPStatusCopyWithImpl<$Res>
    implements _$$_NPStatusCopyWith<$Res> {
  __$$_NPStatusCopyWithImpl(
      _$_NPStatus _value, $Res Function(_$_NPStatus) _then)
      : super(_value, (v) => _then(v as _$_NPStatus));

  @override
  _$_NPStatus get _value => super._value as _$_NPStatus;

  @override
  $Res call({
    Object? duration = freezed,
    Object? position = freezed,
    Object? seekTo = freezed,
    Object? absolutePosition = freezed,
    Object? buffered = freezed,
    Object? isPlaying = freezed,
    Object? isPlayWhenReady = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? isCompleted = freezed,
    Object? volume = freezed,
    Object? previousVolume = freezed,
    Object? speed = freezed,
    Object? errorDescription = freezed,
    Object? size = freezed,
    Object? isPip = freezed,
  }) {
    return _then(_$_NPStatus(
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
      seekTo: seekTo == freezed
          ? _value.seekTo
          : seekTo // ignore: cast_nullable_to_non_nullable
              as Duration?,
      absolutePosition: absolutePosition == freezed
          ? _value.absolutePosition
          : absolutePosition // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      buffered: buffered == freezed
          ? _value._buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>?,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlayWhenReady: isPlayWhenReady == freezed
          ? _value.isPlayWhenReady
          : isPlayWhenReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      previousVolume: previousVolume == freezed
          ? _value.previousVolume
          : previousVolume // ignore: cast_nullable_to_non_nullable
              as double,
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      errorDescription: errorDescription == freezed
          ? _value.errorDescription
          : errorDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      isPip: isPip == freezed
          ? _value.isPip
          : isPip // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NPStatus extends _NPStatus {
  const _$_NPStatus(
      {this.duration,
      this.position,
      this.seekTo,
      this.absolutePosition,
      final List<DurationRange>? buffered,
      this.isPlaying = false,
      this.isPlayWhenReady = true,
      this.isLooping = false,
      this.isBuffering = false,
      this.isCompleted = false,
      this.volume = 1.0,
      this.previousVolume = 1.0,
      this.speed = 1.0,
      this.errorDescription,
      this.size,
      this.isPip = false})
      : _buffered = buffered,
        super._();

  /// The total duration of the video.
  ///
  /// Is null when [initialized] is false.
  @override
  final Duration? duration;

  /// The current playback position.
  @override
  final Duration? position;

  /// seek 动作
  @override
  final Duration? seekTo;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
  @override
  final DateTime? absolutePosition;

  /// The currently buffered ranges.
  final List<DurationRange>? _buffered;

  /// The currently buffered ranges.
  @override
  List<DurationRange>? get buffered {
    final value = _buffered;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// True if the video is playing. False if it's paused.
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isPlayWhenReady;

  /// True if the video is looping.
  @override
  @JsonKey()
  final bool isLooping;

  /// True if the video is currently buffering.
  @override
  @JsonKey()
  final bool isBuffering;

  /// 播放完成
  @override
  @JsonKey()
  final bool isCompleted;

  /// The current volume of the playback.
  @override
  @JsonKey()
  final double volume;

  /// The previous volume of the playback.
  @override
  @JsonKey()
  final double previousVolume;

  /// The current speed of the playback
  @override
  @JsonKey()
  final double speed;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  @override
  final String? errorDescription;

  /// The [size] of the currently loaded video.
  ///
  /// Is null when [initialized] is false.
  @override
  final Size? size;

  ///Is in Picture in Picture Mode
  @override
  @JsonKey()
  final bool isPip;

  @override
  String toString() {
    return 'NPStatus(duration: $duration, position: $position, seekTo: $seekTo, absolutePosition: $absolutePosition, buffered: $buffered, isPlaying: $isPlaying, isPlayWhenReady: $isPlayWhenReady, isLooping: $isLooping, isBuffering: $isBuffering, isCompleted: $isCompleted, volume: $volume, previousVolume: $previousVolume, speed: $speed, errorDescription: $errorDescription, size: $size, isPip: $isPip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NPStatus &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.seekTo, seekTo) &&
            const DeepCollectionEquality()
                .equals(other.absolutePosition, absolutePosition) &&
            const DeepCollectionEquality().equals(other._buffered, _buffered) &&
            const DeepCollectionEquality().equals(other.isPlaying, isPlaying) &&
            const DeepCollectionEquality()
                .equals(other.isPlayWhenReady, isPlayWhenReady) &&
            const DeepCollectionEquality().equals(other.isLooping, isLooping) &&
            const DeepCollectionEquality()
                .equals(other.isBuffering, isBuffering) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted) &&
            const DeepCollectionEquality().equals(other.volume, volume) &&
            const DeepCollectionEquality()
                .equals(other.previousVolume, previousVolume) &&
            const DeepCollectionEquality().equals(other.speed, speed) &&
            const DeepCollectionEquality()
                .equals(other.errorDescription, errorDescription) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.isPip, isPip));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(seekTo),
      const DeepCollectionEquality().hash(absolutePosition),
      const DeepCollectionEquality().hash(_buffered),
      const DeepCollectionEquality().hash(isPlaying),
      const DeepCollectionEquality().hash(isPlayWhenReady),
      const DeepCollectionEquality().hash(isLooping),
      const DeepCollectionEquality().hash(isBuffering),
      const DeepCollectionEquality().hash(isCompleted),
      const DeepCollectionEquality().hash(volume),
      const DeepCollectionEquality().hash(previousVolume),
      const DeepCollectionEquality().hash(speed),
      const DeepCollectionEquality().hash(errorDescription),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(isPip));

  @JsonKey(ignore: true)
  @override
  _$$_NPStatusCopyWith<_$_NPStatus> get copyWith =>
      __$$_NPStatusCopyWithImpl<_$_NPStatus>(this, _$identity);
}

abstract class _NPStatus extends NPStatus {
  const factory _NPStatus(
      {final Duration? duration,
      final Duration? position,
      final Duration? seekTo,
      final DateTime? absolutePosition,
      final List<DurationRange>? buffered,
      final bool isPlaying,
      final bool isPlayWhenReady,
      final bool isLooping,
      final bool isBuffering,
      final bool isCompleted,
      final double volume,
      final double previousVolume,
      final double speed,
      final String? errorDescription,
      final Size? size,
      final bool isPip}) = _$_NPStatus;
  const _NPStatus._() : super._();

  @override

  /// The total duration of the video.
  ///
  /// Is null when [initialized] is false.
  Duration? get duration => throw _privateConstructorUsedError;
  @override

  /// The current playback position.
  Duration? get position => throw _privateConstructorUsedError;
  @override

  /// seek 动作
  Duration? get seekTo => throw _privateConstructorUsedError;
  @override

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
  DateTime? get absolutePosition => throw _privateConstructorUsedError;
  @override

  /// The currently buffered ranges.
  List<DurationRange>? get buffered => throw _privateConstructorUsedError;
  @override

  /// True if the video is playing. False if it's paused.
  bool get isPlaying => throw _privateConstructorUsedError;
  @override
  bool get isPlayWhenReady => throw _privateConstructorUsedError;
  @override

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;
  @override

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;
  @override

  /// 播放完成
  bool get isCompleted => throw _privateConstructorUsedError;
  @override

  /// The current volume of the playback.
  double get volume => throw _privateConstructorUsedError;
  @override

  /// The previous volume of the playback.
  double get previousVolume => throw _privateConstructorUsedError;
  @override

  /// The current speed of the playback
  double get speed => throw _privateConstructorUsedError;
  @override

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  String? get errorDescription => throw _privateConstructorUsedError;
  @override

  /// The [size] of the currently loaded video.
  ///
  /// Is null when [initialized] is false.
  Size? get size => throw _privateConstructorUsedError;
  @override

  ///Is in Picture in Picture Mode
  bool get isPip => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_NPStatusCopyWith<_$_NPStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
