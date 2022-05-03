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

  /// The currently buffered ranges.
  List<DurationRange> get buffered => throw _privateConstructorUsedError;

  /// True if the video is playing. False if it's paused.
  bool get isPlayingStatus => throw _privateConstructorUsedError;

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;

  /// The current volume of the playback.
  double get volume => throw _privateConstructorUsedError;

  /// The current speed of the playback
  double get speed => throw _privateConstructorUsedError;

  ///Is in Picture in Picture Mode
  bool get isPip => throw _privateConstructorUsedError;

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
      List<DurationRange> buffered,
      bool isPlayingStatus,
      bool isLooping,
      bool isBuffering,
      double volume,
      double speed,
      bool isPip});
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
    Object? buffered = freezed,
    Object? isPlayingStatus = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? volume = freezed,
    Object? speed = freezed,
    Object? isPip = freezed,
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
      buffered: buffered == freezed
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>,
      isPlayingStatus: isPlayingStatus == freezed
          ? _value.isPlayingStatus
          : isPlayingStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
abstract class _$BPPlayingStatusCopyWith<$Res>
    implements $BPPlayingStatusCopyWith<$Res> {
  factory _$BPPlayingStatusCopyWith(
          _BPPlayingStatus value, $Res Function(_BPPlayingStatus) then) =
      __$BPPlayingStatusCopyWithImpl<$Res>;
  @override
  $Res call(
      {Duration position,
      DateTime? absolutePosition,
      List<DurationRange> buffered,
      bool isPlayingStatus,
      bool isLooping,
      bool isBuffering,
      double volume,
      double speed,
      bool isPip});
}

/// @nodoc
class __$BPPlayingStatusCopyWithImpl<$Res>
    extends _$BPPlayingStatusCopyWithImpl<$Res>
    implements _$BPPlayingStatusCopyWith<$Res> {
  __$BPPlayingStatusCopyWithImpl(
      _BPPlayingStatus _value, $Res Function(_BPPlayingStatus) _then)
      : super(_value, (v) => _then(v as _BPPlayingStatus));

  @override
  _BPPlayingStatus get _value => super._value as _BPPlayingStatus;

  @override
  $Res call({
    Object? position = freezed,
    Object? absolutePosition = freezed,
    Object? buffered = freezed,
    Object? isPlayingStatus = freezed,
    Object? isLooping = freezed,
    Object? isBuffering = freezed,
    Object? volume = freezed,
    Object? speed = freezed,
    Object? isPip = freezed,
  }) {
    return _then(_BPPlayingStatus(
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      absolutePosition: absolutePosition == freezed
          ? _value.absolutePosition
          : absolutePosition // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      buffered: buffered == freezed
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>,
      isPlayingStatus: isPlayingStatus == freezed
          ? _value.isPlayingStatus
          : isPlayingStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: isLooping == freezed
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      isBuffering: isBuffering == freezed
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc

class _$_BPPlayingStatus implements _BPPlayingStatus {
  const _$_BPPlayingStatus(
      {this.position = const Duration(),
      this.absolutePosition,
      final List<DurationRange> buffered = const <DurationRange>[],
      this.isPlayingStatus = false,
      this.isLooping = false,
      this.isBuffering = false,
      this.volume = 1.0,
      this.speed = 1.0,
      this.isPip = false})
      : _buffered = buffered;

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

  /// The currently buffered ranges.
  final List<DurationRange> _buffered;

  /// The currently buffered ranges.
  @override
  @JsonKey()
  List<DurationRange> get buffered {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buffered);
  }

  /// True if the video is playing. False if it's paused.
  @override
  @JsonKey()
  final bool isPlayingStatus;

  /// True if the video is looping.
  @override
  @JsonKey()
  final bool isLooping;

  /// True if the video is currently buffering.
  @override
  @JsonKey()
  final bool isBuffering;

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

  @override
  String toString() {
    return 'BPPlayingStatus(position: $position, absolutePosition: $absolutePosition, buffered: $buffered, isPlayingStatus: $isPlayingStatus, isLooping: $isLooping, isBuffering: $isBuffering, volume: $volume, speed: $speed, isPip: $isPip)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BPPlayingStatus &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality()
                .equals(other.absolutePosition, absolutePosition) &&
            const DeepCollectionEquality().equals(other.buffered, buffered) &&
            const DeepCollectionEquality()
                .equals(other.isPlayingStatus, isPlayingStatus) &&
            const DeepCollectionEquality().equals(other.isLooping, isLooping) &&
            const DeepCollectionEquality()
                .equals(other.isBuffering, isBuffering) &&
            const DeepCollectionEquality().equals(other.volume, volume) &&
            const DeepCollectionEquality().equals(other.speed, speed) &&
            const DeepCollectionEquality().equals(other.isPip, isPip));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(absolutePosition),
      const DeepCollectionEquality().hash(buffered),
      const DeepCollectionEquality().hash(isPlayingStatus),
      const DeepCollectionEquality().hash(isLooping),
      const DeepCollectionEquality().hash(isBuffering),
      const DeepCollectionEquality().hash(volume),
      const DeepCollectionEquality().hash(speed),
      const DeepCollectionEquality().hash(isPip));

  @JsonKey(ignore: true)
  @override
  _$BPPlayingStatusCopyWith<_BPPlayingStatus> get copyWith =>
      __$BPPlayingStatusCopyWithImpl<_BPPlayingStatus>(this, _$identity);
}

abstract class _BPPlayingStatus implements BPPlayingStatus {
  const factory _BPPlayingStatus(
      {final Duration position,
      final DateTime? absolutePosition,
      final List<DurationRange> buffered,
      final bool isPlayingStatus,
      final bool isLooping,
      final bool isBuffering,
      final double volume,
      final double speed,
      final bool isPip}) = _$_BPPlayingStatus;

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

  /// The currently buffered ranges.
  List<DurationRange> get buffered => throw _privateConstructorUsedError;
  @override

  /// True if the video is playing. False if it's paused.
  bool get isPlayingStatus => throw _privateConstructorUsedError;
  @override

  /// True if the video is looping.
  bool get isLooping => throw _privateConstructorUsedError;
  @override

  /// True if the video is currently buffering.
  bool get isBuffering => throw _privateConstructorUsedError;
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
  @JsonKey(ignore: true)
  _$BPPlayingStatusCopyWith<_BPPlayingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
