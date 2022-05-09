// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_subtitles_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BPSubtitlesSource {
  ///Source type
  BPSubtitlesSourceType? get type => throw _privateConstructorUsedError;

  ///Name of the subtitles, default value is "Default subtitles"
  String? get name => throw _privateConstructorUsedError;

  ///Url of the subtitles, used with file or network subtitles
  List<String?>? get urls => throw _privateConstructorUsedError;

  ///Content of subtitles, used when type is memory
  String? get content => throw _privateConstructorUsedError;

  ///Subtitles selected by default, without user interaction
  bool? get selectedByDefault =>
      throw _privateConstructorUsedError; //Additional headers used in HTTP request. Works only for
// [BPSubtitlesSourceType.memory] source type.
  Map<String, String>? get headers => throw _privateConstructorUsedError;

  ///Is ASMS segmented source (more than 1 subtitle file). This shouldn't be
  ///configured manually.
  bool? get asmsIsSegmented => throw _privateConstructorUsedError;

  ///Max. time between segments in milliseconds. This shouldn't be configured
  /// manually.
  int? get asmsSegmentsTime => throw _privateConstructorUsedError;

  ///List of segments (start,end,url of the segment). This shouldn't be
  ///configured manually.
  List<BPAsmsSubtitleSegment>? get asmsSegments =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BPSubtitlesSourceCopyWith<BPSubtitlesSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPSubtitlesSourceCopyWith<$Res> {
  factory $BPSubtitlesSourceCopyWith(
          BPSubtitlesSource value, $Res Function(BPSubtitlesSource) then) =
      _$BPSubtitlesSourceCopyWithImpl<$Res>;
  $Res call(
      {BPSubtitlesSourceType? type,
      String? name,
      List<String?>? urls,
      String? content,
      bool? selectedByDefault,
      Map<String, String>? headers,
      bool? asmsIsSegmented,
      int? asmsSegmentsTime,
      List<BPAsmsSubtitleSegment>? asmsSegments});
}

/// @nodoc
class _$BPSubtitlesSourceCopyWithImpl<$Res>
    implements $BPSubtitlesSourceCopyWith<$Res> {
  _$BPSubtitlesSourceCopyWithImpl(this._value, this._then);

  final BPSubtitlesSource _value;
  // ignore: unused_field
  final $Res Function(BPSubtitlesSource) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? urls = freezed,
    Object? content = freezed,
    Object? selectedByDefault = freezed,
    Object? headers = freezed,
    Object? asmsIsSegmented = freezed,
    Object? asmsSegmentsTime = freezed,
    Object? asmsSegments = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BPSubtitlesSourceType?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedByDefault: selectedByDefault == freezed
          ? _value.selectedByDefault
          : selectedByDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      headers: headers == freezed
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      asmsIsSegmented: asmsIsSegmented == freezed
          ? _value.asmsIsSegmented
          : asmsIsSegmented // ignore: cast_nullable_to_non_nullable
              as bool?,
      asmsSegmentsTime: asmsSegmentsTime == freezed
          ? _value.asmsSegmentsTime
          : asmsSegmentsTime // ignore: cast_nullable_to_non_nullable
              as int?,
      asmsSegments: asmsSegments == freezed
          ? _value.asmsSegments
          : asmsSegments // ignore: cast_nullable_to_non_nullable
              as List<BPAsmsSubtitleSegment>?,
    ));
  }
}

/// @nodoc
abstract class _$BPSubtitlesSourceCopyWith<$Res>
    implements $BPSubtitlesSourceCopyWith<$Res> {
  factory _$BPSubtitlesSourceCopyWith(
          _BPSubtitlesSource value, $Res Function(_BPSubtitlesSource) then) =
      __$BPSubtitlesSourceCopyWithImpl<$Res>;
  @override
  $Res call(
      {BPSubtitlesSourceType? type,
      String? name,
      List<String?>? urls,
      String? content,
      bool? selectedByDefault,
      Map<String, String>? headers,
      bool? asmsIsSegmented,
      int? asmsSegmentsTime,
      List<BPAsmsSubtitleSegment>? asmsSegments});
}

/// @nodoc
class __$BPSubtitlesSourceCopyWithImpl<$Res>
    extends _$BPSubtitlesSourceCopyWithImpl<$Res>
    implements _$BPSubtitlesSourceCopyWith<$Res> {
  __$BPSubtitlesSourceCopyWithImpl(
      _BPSubtitlesSource _value, $Res Function(_BPSubtitlesSource) _then)
      : super(_value, (v) => _then(v as _BPSubtitlesSource));

  @override
  _BPSubtitlesSource get _value => super._value as _BPSubtitlesSource;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
    Object? urls = freezed,
    Object? content = freezed,
    Object? selectedByDefault = freezed,
    Object? headers = freezed,
    Object? asmsIsSegmented = freezed,
    Object? asmsSegmentsTime = freezed,
    Object? asmsSegments = freezed,
  }) {
    return _then(_BPSubtitlesSource(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BPSubtitlesSourceType?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String?>?,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedByDefault: selectedByDefault == freezed
          ? _value.selectedByDefault
          : selectedByDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      headers: headers == freezed
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      asmsIsSegmented: asmsIsSegmented == freezed
          ? _value.asmsIsSegmented
          : asmsIsSegmented // ignore: cast_nullable_to_non_nullable
              as bool?,
      asmsSegmentsTime: asmsSegmentsTime == freezed
          ? _value.asmsSegmentsTime
          : asmsSegmentsTime // ignore: cast_nullable_to_non_nullable
              as int?,
      asmsSegments: asmsSegments == freezed
          ? _value.asmsSegments
          : asmsSegments // ignore: cast_nullable_to_non_nullable
              as List<BPAsmsSubtitleSegment>?,
    ));
  }
}

/// @nodoc

class _$_BPSubtitlesSource extends _BPSubtitlesSource {
  const _$_BPSubtitlesSource(
      {this.type,
      this.name = "Default subtitles",
      final List<String?>? urls,
      this.content,
      this.selectedByDefault,
      final Map<String, String>? headers,
      this.asmsIsSegmented,
      this.asmsSegmentsTime,
      final List<BPAsmsSubtitleSegment>? asmsSegments})
      : _urls = urls,
        _headers = headers,
        _asmsSegments = asmsSegments,
        super._();

  ///Source type
  @override
  final BPSubtitlesSourceType? type;

  ///Name of the subtitles, default value is "Default subtitles"
  @override
  @JsonKey()
  final String? name;

  ///Url of the subtitles, used with file or network subtitles
  final List<String?>? _urls;

  ///Url of the subtitles, used with file or network subtitles
  @override
  List<String?>? get urls {
    final value = _urls;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  ///Content of subtitles, used when type is memory
  @override
  final String? content;

  ///Subtitles selected by default, without user interaction
  @override
  final bool? selectedByDefault;
//Additional headers used in HTTP request. Works only for
// [BPSubtitlesSourceType.memory] source type.
  final Map<String, String>? _headers;
//Additional headers used in HTTP request. Works only for
// [BPSubtitlesSourceType.memory] source type.
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  ///Is ASMS segmented source (more than 1 subtitle file). This shouldn't be
  ///configured manually.
  @override
  final bool? asmsIsSegmented;

  ///Max. time between segments in milliseconds. This shouldn't be configured
  /// manually.
  @override
  final int? asmsSegmentsTime;

  ///List of segments (start,end,url of the segment). This shouldn't be
  ///configured manually.
  final List<BPAsmsSubtitleSegment>? _asmsSegments;

  ///List of segments (start,end,url of the segment). This shouldn't be
  ///configured manually.
  @override
  List<BPAsmsSubtitleSegment>? get asmsSegments {
    final value = _asmsSegments;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BPSubtitlesSource(type: $type, name: $name, urls: $urls, content: $content, selectedByDefault: $selectedByDefault, headers: $headers, asmsIsSegmented: $asmsIsSegmented, asmsSegmentsTime: $asmsSegmentsTime, asmsSegments: $asmsSegments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BPSubtitlesSource &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.urls, urls) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality()
                .equals(other.selectedByDefault, selectedByDefault) &&
            const DeepCollectionEquality().equals(other.headers, headers) &&
            const DeepCollectionEquality()
                .equals(other.asmsIsSegmented, asmsIsSegmented) &&
            const DeepCollectionEquality()
                .equals(other.asmsSegmentsTime, asmsSegmentsTime) &&
            const DeepCollectionEquality()
                .equals(other.asmsSegments, asmsSegments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(urls),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(selectedByDefault),
      const DeepCollectionEquality().hash(headers),
      const DeepCollectionEquality().hash(asmsIsSegmented),
      const DeepCollectionEquality().hash(asmsSegmentsTime),
      const DeepCollectionEquality().hash(asmsSegments));

  @JsonKey(ignore: true)
  @override
  _$BPSubtitlesSourceCopyWith<_BPSubtitlesSource> get copyWith =>
      __$BPSubtitlesSourceCopyWithImpl<_BPSubtitlesSource>(this, _$identity);
}

abstract class _BPSubtitlesSource extends BPSubtitlesSource {
  const factory _BPSubtitlesSource(
      {final BPSubtitlesSourceType? type,
      final String? name,
      final List<String?>? urls,
      final String? content,
      final bool? selectedByDefault,
      final Map<String, String>? headers,
      final bool? asmsIsSegmented,
      final int? asmsSegmentsTime,
      final List<BPAsmsSubtitleSegment>? asmsSegments}) = _$_BPSubtitlesSource;
  const _BPSubtitlesSource._() : super._();

  @override

  ///Source type
  BPSubtitlesSourceType? get type => throw _privateConstructorUsedError;
  @override

  ///Name of the subtitles, default value is "Default subtitles"
  String? get name => throw _privateConstructorUsedError;
  @override

  ///Url of the subtitles, used with file or network subtitles
  List<String?>? get urls => throw _privateConstructorUsedError;
  @override

  ///Content of subtitles, used when type is memory
  String? get content => throw _privateConstructorUsedError;
  @override

  ///Subtitles selected by default, without user interaction
  bool? get selectedByDefault => throw _privateConstructorUsedError;
  @override //Additional headers used in HTTP request. Works only for
// [BPSubtitlesSourceType.memory] source type.
  Map<String, String>? get headers => throw _privateConstructorUsedError;
  @override

  ///Is ASMS segmented source (more than 1 subtitle file). This shouldn't be
  ///configured manually.
  bool? get asmsIsSegmented => throw _privateConstructorUsedError;
  @override

  ///Max. time between segments in milliseconds. This shouldn't be configured
  /// manually.
  int? get asmsSegmentsTime => throw _privateConstructorUsedError;
  @override

  ///List of segments (start,end,url of the segment). This shouldn't be
  ///configured manually.
  List<BPAsmsSubtitleSegment>? get asmsSegments =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BPSubtitlesSourceCopyWith<_BPSubtitlesSource> get copyWith =>
      throw _privateConstructorUsedError;
}
