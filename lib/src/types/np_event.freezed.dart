// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'np_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NPVideoEvent {
  /// The type of the event.
  NPVideoEventType get eventType => throw _privateConstructorUsedError;

  /// Data source of the video.
  ///
  /// Used to determine which video the event belongs to.
  String? get key => throw _privateConstructorUsedError;

  /// Duration of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  Duration? get duration => throw _privateConstructorUsedError;

  /// Size of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  Size? get size => throw _privateConstructorUsedError;

  /// Buffered parts of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.bufferingUpdate].
  List<DurationRange>? get buffered => throw _privateConstructorUsedError;

  ///Seek position
  Duration? get position => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NPVideoEventCopyWith<NPVideoEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NPVideoEventCopyWith<$Res> {
  factory $NPVideoEventCopyWith(
          NPVideoEvent value, $Res Function(NPVideoEvent) then) =
      _$NPVideoEventCopyWithImpl<$Res>;
  $Res call(
      {NPVideoEventType eventType,
      String? key,
      Duration? duration,
      Size? size,
      List<DurationRange>? buffered,
      Duration? position});
}

/// @nodoc
class _$NPVideoEventCopyWithImpl<$Res> implements $NPVideoEventCopyWith<$Res> {
  _$NPVideoEventCopyWithImpl(this._value, this._then);

  final NPVideoEvent _value;
  // ignore: unused_field
  final $Res Function(NPVideoEvent) _then;

  @override
  $Res call({
    Object? eventType = freezed,
    Object? key = freezed,
    Object? duration = freezed,
    Object? size = freezed,
    Object? buffered = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      eventType: eventType == freezed
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as NPVideoEventType,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      buffered: buffered == freezed
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
abstract class _$$_NPVideoEventCopyWith<$Res>
    implements $NPVideoEventCopyWith<$Res> {
  factory _$$_NPVideoEventCopyWith(
          _$_NPVideoEvent value, $Res Function(_$_NPVideoEvent) then) =
      __$$_NPVideoEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {NPVideoEventType eventType,
      String? key,
      Duration? duration,
      Size? size,
      List<DurationRange>? buffered,
      Duration? position});
}

/// @nodoc
class __$$_NPVideoEventCopyWithImpl<$Res>
    extends _$NPVideoEventCopyWithImpl<$Res>
    implements _$$_NPVideoEventCopyWith<$Res> {
  __$$_NPVideoEventCopyWithImpl(
      _$_NPVideoEvent _value, $Res Function(_$_NPVideoEvent) _then)
      : super(_value, (v) => _then(v as _$_NPVideoEvent));

  @override
  _$_NPVideoEvent get _value => super._value as _$_NPVideoEvent;

  @override
  $Res call({
    Object? eventType = freezed,
    Object? key = freezed,
    Object? duration = freezed,
    Object? size = freezed,
    Object? buffered = freezed,
    Object? position = freezed,
  }) {
    return _then(_$_NPVideoEvent(
      eventType: eventType == freezed
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as NPVideoEventType,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      buffered: buffered == freezed
          ? _value._buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as List<DurationRange>?,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$_NPVideoEvent with DiagnosticableTreeMixin implements _NPVideoEvent {
  const _$_NPVideoEvent(
      {required this.eventType,
      required this.key,
      this.duration,
      this.size,
      final List<DurationRange>? buffered,
      this.position})
      : _buffered = buffered;

  /// The type of the event.
  @override
  final NPVideoEventType eventType;

  /// Data source of the video.
  ///
  /// Used to determine which video the event belongs to.
  @override
  final String? key;

  /// Duration of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  @override
  final Duration? duration;

  /// Size of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  @override
  final Size? size;

  /// Buffered parts of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.bufferingUpdate].
  final List<DurationRange>? _buffered;

  /// Buffered parts of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.bufferingUpdate].
  @override
  List<DurationRange>? get buffered {
    final value = _buffered;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  ///Seek position
  @override
  final Duration? position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NPVideoEvent(eventType: $eventType, key: $key, duration: $duration, size: $size, buffered: $buffered, position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NPVideoEvent'))
      ..add(DiagnosticsProperty('eventType', eventType))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('buffered', buffered))
      ..add(DiagnosticsProperty('position', position));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NPVideoEvent &&
            const DeepCollectionEquality().equals(other.eventType, eventType) &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other._buffered, _buffered) &&
            const DeepCollectionEquality().equals(other.position, position));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(eventType),
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(_buffered),
      const DeepCollectionEquality().hash(position));

  @JsonKey(ignore: true)
  @override
  _$$_NPVideoEventCopyWith<_$_NPVideoEvent> get copyWith =>
      __$$_NPVideoEventCopyWithImpl<_$_NPVideoEvent>(this, _$identity);
}

abstract class _NPVideoEvent implements NPVideoEvent {
  const factory _NPVideoEvent(
      {required final NPVideoEventType eventType,
      required final String? key,
      final Duration? duration,
      final Size? size,
      final List<DurationRange>? buffered,
      final Duration? position}) = _$_NPVideoEvent;

  @override

  /// The type of the event.
  NPVideoEventType get eventType => throw _privateConstructorUsedError;
  @override

  /// Data source of the video.
  ///
  /// Used to determine which video the event belongs to.
  String? get key => throw _privateConstructorUsedError;
  @override

  /// Duration of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  Duration? get duration => throw _privateConstructorUsedError;
  @override

  /// Size of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.initialized].
  Size? get size => throw _privateConstructorUsedError;
  @override

  /// Buffered parts of the video.
  ///
  /// Only used if [eventType] is [NPVideoEventType.bufferingUpdate].
  List<DurationRange>? get buffered => throw _privateConstructorUsedError;
  @override

  ///Seek position
  Duration? get position => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_NPVideoEventCopyWith<_$_NPVideoEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
