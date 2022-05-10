// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'interact_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InteractiveStatus {
  int get count => throw _privateConstructorUsedError;
  InteractiveEvent? get event => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InteractiveStatusCopyWith<InteractiveStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractiveStatusCopyWith<$Res> {
  factory $InteractiveStatusCopyWith(
          InteractiveStatus value, $Res Function(InteractiveStatus) then) =
      _$InteractiveStatusCopyWithImpl<$Res>;
  $Res call({int count, InteractiveEvent? event});

  $InteractiveEventCopyWith<$Res>? get event;
}

/// @nodoc
class _$InteractiveStatusCopyWithImpl<$Res>
    implements $InteractiveStatusCopyWith<$Res> {
  _$InteractiveStatusCopyWithImpl(this._value, this._then);

  final InteractiveStatus _value;
  // ignore: unused_field
  final $Res Function(InteractiveStatus) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      event: event == freezed
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as InteractiveEvent?,
    ));
  }

  @override
  $InteractiveEventCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $InteractiveEventCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value));
    });
  }
}

/// @nodoc
abstract class _$$_InteractiveStatusCopyWith<$Res>
    implements $InteractiveStatusCopyWith<$Res> {
  factory _$$_InteractiveStatusCopyWith(_$_InteractiveStatus value,
          $Res Function(_$_InteractiveStatus) then) =
      __$$_InteractiveStatusCopyWithImpl<$Res>;
  @override
  $Res call({int count, InteractiveEvent? event});

  @override
  $InteractiveEventCopyWith<$Res>? get event;
}

/// @nodoc
class __$$_InteractiveStatusCopyWithImpl<$Res>
    extends _$InteractiveStatusCopyWithImpl<$Res>
    implements _$$_InteractiveStatusCopyWith<$Res> {
  __$$_InteractiveStatusCopyWithImpl(
      _$_InteractiveStatus _value, $Res Function(_$_InteractiveStatus) _then)
      : super(_value, (v) => _then(v as _$_InteractiveStatus));

  @override
  _$_InteractiveStatus get _value => super._value as _$_InteractiveStatus;

  @override
  $Res call({
    Object? count = freezed,
    Object? event = freezed,
  }) {
    return _then(_$_InteractiveStatus(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      event: event == freezed
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as InteractiveEvent?,
    ));
  }
}

/// @nodoc

class _$_InteractiveStatus implements _InteractiveStatus {
  const _$_InteractiveStatus({this.count = 0, this.event});

  @override
  @JsonKey()
  final int count;
  @override
  final InteractiveEvent? event;

  @override
  String toString() {
    return 'InteractiveStatus(count: $count, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InteractiveStatus &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.event, event));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(event));

  @JsonKey(ignore: true)
  @override
  _$$_InteractiveStatusCopyWith<_$_InteractiveStatus> get copyWith =>
      __$$_InteractiveStatusCopyWithImpl<_$_InteractiveStatus>(
          this, _$identity);
}

abstract class _InteractiveStatus implements InteractiveStatus {
  const factory _InteractiveStatus(
      {final int count, final InteractiveEvent? event}) = _$_InteractiveStatus;

  @override
  int get count => throw _privateConstructorUsedError;
  @override
  InteractiveEvent? get event => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InteractiveStatusCopyWith<_$_InteractiveStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InteractiveEvent {
  String get from => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;
  dynamic get args => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InteractiveEventCopyWith<InteractiveEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractiveEventCopyWith<$Res> {
  factory $InteractiveEventCopyWith(
          InteractiveEvent value, $Res Function(InteractiveEvent) then) =
      _$InteractiveEventCopyWithImpl<$Res>;
  $Res call({String from, String eventName, dynamic args});
}

/// @nodoc
class _$InteractiveEventCopyWithImpl<$Res>
    implements $InteractiveEventCopyWith<$Res> {
  _$InteractiveEventCopyWithImpl(this._value, this._then);

  final InteractiveEvent _value;
  // ignore: unused_field
  final $Res Function(InteractiveEvent) _then;

  @override
  $Res call({
    Object? from = freezed,
    Object? eventName = freezed,
    Object? args = freezed,
  }) {
    return _then(_value.copyWith(
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: eventName == freezed
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      args: args == freezed
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_InteractiveEventCopyWith<$Res>
    implements $InteractiveEventCopyWith<$Res> {
  factory _$$_InteractiveEventCopyWith(
          _$_InteractiveEvent value, $Res Function(_$_InteractiveEvent) then) =
      __$$_InteractiveEventCopyWithImpl<$Res>;
  @override
  $Res call({String from, String eventName, dynamic args});
}

/// @nodoc
class __$$_InteractiveEventCopyWithImpl<$Res>
    extends _$InteractiveEventCopyWithImpl<$Res>
    implements _$$_InteractiveEventCopyWith<$Res> {
  __$$_InteractiveEventCopyWithImpl(
      _$_InteractiveEvent _value, $Res Function(_$_InteractiveEvent) _then)
      : super(_value, (v) => _then(v as _$_InteractiveEvent));

  @override
  _$_InteractiveEvent get _value => super._value as _$_InteractiveEvent;

  @override
  $Res call({
    Object? from = freezed,
    Object? eventName = freezed,
    Object? args = freezed,
  }) {
    return _then(_$_InteractiveEvent(
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      eventName: eventName == freezed
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String,
      args: args == freezed
          ? _value.args
          : args // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_InteractiveEvent implements _InteractiveEvent {
  const _$_InteractiveEvent(
      {required this.from, required this.eventName, this.args});

  @override
  final String from;
  @override
  final String eventName;
  @override
  final dynamic args;

  @override
  String toString() {
    return 'InteractiveEvent(from: $from, eventName: $eventName, args: $args)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InteractiveEvent &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.eventName, eventName) &&
            const DeepCollectionEquality().equals(other.args, args));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(eventName),
      const DeepCollectionEquality().hash(args));

  @JsonKey(ignore: true)
  @override
  _$$_InteractiveEventCopyWith<_$_InteractiveEvent> get copyWith =>
      __$$_InteractiveEventCopyWithImpl<_$_InteractiveEvent>(this, _$identity);
}

abstract class _InteractiveEvent implements InteractiveEvent {
  const factory _InteractiveEvent(
      {required final String from,
      required final String eventName,
      final dynamic args}) = _$_InteractiveEvent;

  @override
  String get from => throw _privateConstructorUsedError;
  @override
  String get eventName => throw _privateConstructorUsedError;
  @override
  dynamic get args => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InteractiveEventCopyWith<_$_InteractiveEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
