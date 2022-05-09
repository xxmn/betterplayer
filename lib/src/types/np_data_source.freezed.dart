// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'np_data_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NPDataSource {
  /// Describes the type of data source this [VideoPlayerController]
  /// is constructed with.
  ///
  /// The way in which the video was originally loaded.
  ///
  /// This has nothing to do with the video's file type. It's just the place
  /// from which the video is fetched from.
  NPDataSourceType get sourceType => throw _privateConstructorUsedError;

  /// The URI to the video file.
  ///
  /// This will be in different formats depending on the [DataSourceType] of
  /// the original video.
  String? get uri => throw _privateConstructorUsedError;
  String? get audioUri => throw _privateConstructorUsedError;

  /// **Android only**. Will override the platform's generic file format
  /// detection with whatever is set here.
  VideoFormat? get formatHint => throw _privateConstructorUsedError;

  /// The name of the asset. Only set for [DataSourceType.asset] videos.
  String? get asset => throw _privateConstructorUsedError;

  /// The package that the asset was loaded from. Only set for
  /// [DataSourceType.asset] videos.
  String? get package => throw _privateConstructorUsedError;
  Map<String, String?>? get headers => throw _privateConstructorUsedError;
  bool get useCache => throw _privateConstructorUsedError;

  /// The maximum cache size to keep on disk in bytes.
  int? get maxCacheSize => throw _privateConstructorUsedError;

  /// The maximum size of each individual file in bytes.
  int? get maxCacheFileSize => throw _privateConstructorUsedError;
  String? get cacheKey => throw _privateConstructorUsedError;
  bool? get showNotification => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get notificationChannelName => throw _privateConstructorUsedError;
  Duration? get overriddenDuration => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;
  String? get licenseUrl => throw _privateConstructorUsedError;
  String? get certificateUrl => throw _privateConstructorUsedError;
  Map<String, String>? get drmHeaders => throw _privateConstructorUsedError;
  String? get activityName => throw _privateConstructorUsedError;
  String? get clearKey => throw _privateConstructorUsedError;
  String? get videoExtension => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NPDataSourceCopyWith<NPDataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NPDataSourceCopyWith<$Res> {
  factory $NPDataSourceCopyWith(
          NPDataSource value, $Res Function(NPDataSource) then) =
      _$NPDataSourceCopyWithImpl<$Res>;
  $Res call(
      {NPDataSourceType sourceType,
      String? uri,
      String? audioUri,
      VideoFormat? formatHint,
      String? asset,
      String? package,
      Map<String, String?>? headers,
      bool useCache,
      int? maxCacheSize,
      int? maxCacheFileSize,
      String? cacheKey,
      bool? showNotification,
      String? title,
      String? author,
      String? imageUrl,
      String? notificationChannelName,
      Duration? overriddenDuration,
      int? start,
      String? licenseUrl,
      String? certificateUrl,
      Map<String, String>? drmHeaders,
      String? activityName,
      String? clearKey,
      String? videoExtension});
}

/// @nodoc
class _$NPDataSourceCopyWithImpl<$Res> implements $NPDataSourceCopyWith<$Res> {
  _$NPDataSourceCopyWithImpl(this._value, this._then);

  final NPDataSource _value;
  // ignore: unused_field
  final $Res Function(NPDataSource) _then;

  @override
  $Res call({
    Object? sourceType = freezed,
    Object? uri = freezed,
    Object? audioUri = freezed,
    Object? formatHint = freezed,
    Object? asset = freezed,
    Object? package = freezed,
    Object? headers = freezed,
    Object? useCache = freezed,
    Object? maxCacheSize = freezed,
    Object? maxCacheFileSize = freezed,
    Object? cacheKey = freezed,
    Object? showNotification = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? imageUrl = freezed,
    Object? notificationChannelName = freezed,
    Object? overriddenDuration = freezed,
    Object? start = freezed,
    Object? licenseUrl = freezed,
    Object? certificateUrl = freezed,
    Object? drmHeaders = freezed,
    Object? activityName = freezed,
    Object? clearKey = freezed,
    Object? videoExtension = freezed,
  }) {
    return _then(_value.copyWith(
      sourceType: sourceType == freezed
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as NPDataSourceType,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUri: audioUri == freezed
          ? _value.audioUri
          : audioUri // ignore: cast_nullable_to_non_nullable
              as String?,
      formatHint: formatHint == freezed
          ? _value.formatHint
          : formatHint // ignore: cast_nullable_to_non_nullable
              as VideoFormat?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: headers == freezed
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
      useCache: useCache == freezed
          ? _value.useCache
          : useCache // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCacheSize: maxCacheSize == freezed
          ? _value.maxCacheSize
          : maxCacheSize // ignore: cast_nullable_to_non_nullable
              as int?,
      maxCacheFileSize: maxCacheFileSize == freezed
          ? _value.maxCacheFileSize
          : maxCacheFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      cacheKey: cacheKey == freezed
          ? _value.cacheKey
          : cacheKey // ignore: cast_nullable_to_non_nullable
              as String?,
      showNotification: showNotification == freezed
          ? _value.showNotification
          : showNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationChannelName: notificationChannelName == freezed
          ? _value.notificationChannelName
          : notificationChannelName // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenDuration: overriddenDuration == freezed
          ? _value.overriddenDuration
          : overriddenDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      licenseUrl: licenseUrl == freezed
          ? _value.licenseUrl
          : licenseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      certificateUrl: certificateUrl == freezed
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      drmHeaders: drmHeaders == freezed
          ? _value.drmHeaders
          : drmHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      activityName: activityName == freezed
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      clearKey: clearKey == freezed
          ? _value.clearKey
          : clearKey // ignore: cast_nullable_to_non_nullable
              as String?,
      videoExtension: videoExtension == freezed
          ? _value.videoExtension
          : videoExtension // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$NPDataSourceCopyWith<$Res>
    implements $NPDataSourceCopyWith<$Res> {
  factory _$NPDataSourceCopyWith(
          _NPDataSource value, $Res Function(_NPDataSource) then) =
      __$NPDataSourceCopyWithImpl<$Res>;
  @override
  $Res call(
      {NPDataSourceType sourceType,
      String? uri,
      String? audioUri,
      VideoFormat? formatHint,
      String? asset,
      String? package,
      Map<String, String?>? headers,
      bool useCache,
      int? maxCacheSize,
      int? maxCacheFileSize,
      String? cacheKey,
      bool? showNotification,
      String? title,
      String? author,
      String? imageUrl,
      String? notificationChannelName,
      Duration? overriddenDuration,
      int? start,
      String? licenseUrl,
      String? certificateUrl,
      Map<String, String>? drmHeaders,
      String? activityName,
      String? clearKey,
      String? videoExtension});
}

/// @nodoc
class __$NPDataSourceCopyWithImpl<$Res> extends _$NPDataSourceCopyWithImpl<$Res>
    implements _$NPDataSourceCopyWith<$Res> {
  __$NPDataSourceCopyWithImpl(
      _NPDataSource _value, $Res Function(_NPDataSource) _then)
      : super(_value, (v) => _then(v as _NPDataSource));

  @override
  _NPDataSource get _value => super._value as _NPDataSource;

  @override
  $Res call({
    Object? sourceType = freezed,
    Object? uri = freezed,
    Object? audioUri = freezed,
    Object? formatHint = freezed,
    Object? asset = freezed,
    Object? package = freezed,
    Object? headers = freezed,
    Object? useCache = freezed,
    Object? maxCacheSize = freezed,
    Object? maxCacheFileSize = freezed,
    Object? cacheKey = freezed,
    Object? showNotification = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? imageUrl = freezed,
    Object? notificationChannelName = freezed,
    Object? overriddenDuration = freezed,
    Object? start = freezed,
    Object? licenseUrl = freezed,
    Object? certificateUrl = freezed,
    Object? drmHeaders = freezed,
    Object? activityName = freezed,
    Object? clearKey = freezed,
    Object? videoExtension = freezed,
  }) {
    return _then(_NPDataSource(
      sourceType: sourceType == freezed
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as NPDataSourceType,
      uri: uri == freezed
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUri: audioUri == freezed
          ? _value.audioUri
          : audioUri // ignore: cast_nullable_to_non_nullable
              as String?,
      formatHint: formatHint == freezed
          ? _value.formatHint
          : formatHint // ignore: cast_nullable_to_non_nullable
              as VideoFormat?,
      asset: asset == freezed
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      package: package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: headers == freezed
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
      useCache: useCache == freezed
          ? _value.useCache
          : useCache // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCacheSize: maxCacheSize == freezed
          ? _value.maxCacheSize
          : maxCacheSize // ignore: cast_nullable_to_non_nullable
              as int?,
      maxCacheFileSize: maxCacheFileSize == freezed
          ? _value.maxCacheFileSize
          : maxCacheFileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      cacheKey: cacheKey == freezed
          ? _value.cacheKey
          : cacheKey // ignore: cast_nullable_to_non_nullable
              as String?,
      showNotification: showNotification == freezed
          ? _value.showNotification
          : showNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationChannelName: notificationChannelName == freezed
          ? _value.notificationChannelName
          : notificationChannelName // ignore: cast_nullable_to_non_nullable
              as String?,
      overriddenDuration: overriddenDuration == freezed
          ? _value.overriddenDuration
          : overriddenDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      licenseUrl: licenseUrl == freezed
          ? _value.licenseUrl
          : licenseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      certificateUrl: certificateUrl == freezed
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      drmHeaders: drmHeaders == freezed
          ? _value.drmHeaders
          : drmHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      activityName: activityName == freezed
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      clearKey: clearKey == freezed
          ? _value.clearKey
          : clearKey // ignore: cast_nullable_to_non_nullable
              as String?,
      videoExtension: videoExtension == freezed
          ? _value.videoExtension
          : videoExtension // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_NPDataSource extends _NPDataSource {
  const _$_NPDataSource(
      {required this.sourceType,
      this.uri,
      this.audioUri,
      this.formatHint,
      this.asset,
      this.package,
      final Map<String, String?>? headers,
      this.useCache = false,
      this.maxCacheSize = 100 * 1024 * 1024,
      this.maxCacheFileSize = 10 * 1024 * 1024,
      this.cacheKey,
      this.showNotification = false,
      this.title,
      this.author,
      this.imageUrl,
      this.notificationChannelName,
      this.overriddenDuration,
      this.start,
      this.licenseUrl,
      this.certificateUrl,
      final Map<String, String>? drmHeaders,
      this.activityName,
      this.clearKey,
      this.videoExtension})
      : assert(uri != null || asset != null, 'uri or asset should be not null'),
        _headers = headers,
        _drmHeaders = drmHeaders,
        super._();

  /// Describes the type of data source this [VideoPlayerController]
  /// is constructed with.
  ///
  /// The way in which the video was originally loaded.
  ///
  /// This has nothing to do with the video's file type. It's just the place
  /// from which the video is fetched from.
  @override
  final NPDataSourceType sourceType;

  /// The URI to the video file.
  ///
  /// This will be in different formats depending on the [DataSourceType] of
  /// the original video.
  @override
  final String? uri;
  @override
  final String? audioUri;

  /// **Android only**. Will override the platform's generic file format
  /// detection with whatever is set here.
  @override
  final VideoFormat? formatHint;

  /// The name of the asset. Only set for [DataSourceType.asset] videos.
  @override
  final String? asset;

  /// The package that the asset was loaded from. Only set for
  /// [DataSourceType.asset] videos.
  @override
  final String? package;
  final Map<String, String?>? _headers;
  @override
  Map<String, String?>? get headers {
    final value = _headers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool useCache;

  /// The maximum cache size to keep on disk in bytes.
  @override
  @JsonKey()
  final int? maxCacheSize;

  /// The maximum size of each individual file in bytes.
  @override
  @JsonKey()
  final int? maxCacheFileSize;
  @override
  final String? cacheKey;
  @override
  @JsonKey()
  final bool? showNotification;
  @override
  final String? title;
  @override
  final String? author;
  @override
  final String? imageUrl;
  @override
  final String? notificationChannelName;
  @override
  final Duration? overriddenDuration;
  @override
  final int? start;
  @override
  final String? licenseUrl;
  @override
  final String? certificateUrl;
  final Map<String, String>? _drmHeaders;
  @override
  Map<String, String>? get drmHeaders {
    final value = _drmHeaders;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? activityName;
  @override
  final String? clearKey;
  @override
  final String? videoExtension;

  @override
  String toString() {
    return 'NPDataSource(sourceType: $sourceType, uri: $uri, audioUri: $audioUri, formatHint: $formatHint, asset: $asset, package: $package, headers: $headers, useCache: $useCache, maxCacheSize: $maxCacheSize, maxCacheFileSize: $maxCacheFileSize, cacheKey: $cacheKey, showNotification: $showNotification, title: $title, author: $author, imageUrl: $imageUrl, notificationChannelName: $notificationChannelName, overriddenDuration: $overriddenDuration, start: $start, licenseUrl: $licenseUrl, certificateUrl: $certificateUrl, drmHeaders: $drmHeaders, activityName: $activityName, clearKey: $clearKey, videoExtension: $videoExtension)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NPDataSource &&
            const DeepCollectionEquality()
                .equals(other.sourceType, sourceType) &&
            const DeepCollectionEquality().equals(other.uri, uri) &&
            const DeepCollectionEquality().equals(other.audioUri, audioUri) &&
            const DeepCollectionEquality()
                .equals(other.formatHint, formatHint) &&
            const DeepCollectionEquality().equals(other.asset, asset) &&
            const DeepCollectionEquality().equals(other.package, package) &&
            const DeepCollectionEquality().equals(other.headers, headers) &&
            const DeepCollectionEquality().equals(other.useCache, useCache) &&
            const DeepCollectionEquality()
                .equals(other.maxCacheSize, maxCacheSize) &&
            const DeepCollectionEquality()
                .equals(other.maxCacheFileSize, maxCacheFileSize) &&
            const DeepCollectionEquality().equals(other.cacheKey, cacheKey) &&
            const DeepCollectionEquality()
                .equals(other.showNotification, showNotification) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality().equals(
                other.notificationChannelName, notificationChannelName) &&
            const DeepCollectionEquality()
                .equals(other.overriddenDuration, overriddenDuration) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality()
                .equals(other.licenseUrl, licenseUrl) &&
            const DeepCollectionEquality()
                .equals(other.certificateUrl, certificateUrl) &&
            const DeepCollectionEquality()
                .equals(other.drmHeaders, drmHeaders) &&
            const DeepCollectionEquality()
                .equals(other.activityName, activityName) &&
            const DeepCollectionEquality().equals(other.clearKey, clearKey) &&
            const DeepCollectionEquality()
                .equals(other.videoExtension, videoExtension));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(sourceType),
        const DeepCollectionEquality().hash(uri),
        const DeepCollectionEquality().hash(audioUri),
        const DeepCollectionEquality().hash(formatHint),
        const DeepCollectionEquality().hash(asset),
        const DeepCollectionEquality().hash(package),
        const DeepCollectionEquality().hash(headers),
        const DeepCollectionEquality().hash(useCache),
        const DeepCollectionEquality().hash(maxCacheSize),
        const DeepCollectionEquality().hash(maxCacheFileSize),
        const DeepCollectionEquality().hash(cacheKey),
        const DeepCollectionEquality().hash(showNotification),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(author),
        const DeepCollectionEquality().hash(imageUrl),
        const DeepCollectionEquality().hash(notificationChannelName),
        const DeepCollectionEquality().hash(overriddenDuration),
        const DeepCollectionEquality().hash(start),
        const DeepCollectionEquality().hash(licenseUrl),
        const DeepCollectionEquality().hash(certificateUrl),
        const DeepCollectionEquality().hash(drmHeaders),
        const DeepCollectionEquality().hash(activityName),
        const DeepCollectionEquality().hash(clearKey),
        const DeepCollectionEquality().hash(videoExtension)
      ]);

  @JsonKey(ignore: true)
  @override
  _$NPDataSourceCopyWith<_NPDataSource> get copyWith =>
      __$NPDataSourceCopyWithImpl<_NPDataSource>(this, _$identity);
}

abstract class _NPDataSource extends NPDataSource {
  const factory _NPDataSource(
      {required final NPDataSourceType sourceType,
      final String? uri,
      final String? audioUri,
      final VideoFormat? formatHint,
      final String? asset,
      final String? package,
      final Map<String, String?>? headers,
      final bool useCache,
      final int? maxCacheSize,
      final int? maxCacheFileSize,
      final String? cacheKey,
      final bool? showNotification,
      final String? title,
      final String? author,
      final String? imageUrl,
      final String? notificationChannelName,
      final Duration? overriddenDuration,
      final int? start,
      final String? licenseUrl,
      final String? certificateUrl,
      final Map<String, String>? drmHeaders,
      final String? activityName,
      final String? clearKey,
      final String? videoExtension}) = _$_NPDataSource;
  const _NPDataSource._() : super._();

  @override

  /// Describes the type of data source this [VideoPlayerController]
  /// is constructed with.
  ///
  /// The way in which the video was originally loaded.
  ///
  /// This has nothing to do with the video's file type. It's just the place
  /// from which the video is fetched from.
  NPDataSourceType get sourceType => throw _privateConstructorUsedError;
  @override

  /// The URI to the video file.
  ///
  /// This will be in different formats depending on the [DataSourceType] of
  /// the original video.
  String? get uri => throw _privateConstructorUsedError;
  @override
  String? get audioUri => throw _privateConstructorUsedError;
  @override

  /// **Android only**. Will override the platform's generic file format
  /// detection with whatever is set here.
  VideoFormat? get formatHint => throw _privateConstructorUsedError;
  @override

  /// The name of the asset. Only set for [DataSourceType.asset] videos.
  String? get asset => throw _privateConstructorUsedError;
  @override

  /// The package that the asset was loaded from. Only set for
  /// [DataSourceType.asset] videos.
  String? get package => throw _privateConstructorUsedError;
  @override
  Map<String, String?>? get headers => throw _privateConstructorUsedError;
  @override
  bool get useCache => throw _privateConstructorUsedError;
  @override

  /// The maximum cache size to keep on disk in bytes.
  int? get maxCacheSize => throw _privateConstructorUsedError;
  @override

  /// The maximum size of each individual file in bytes.
  int? get maxCacheFileSize => throw _privateConstructorUsedError;
  @override
  String? get cacheKey => throw _privateConstructorUsedError;
  @override
  bool? get showNotification => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get author => throw _privateConstructorUsedError;
  @override
  String? get imageUrl => throw _privateConstructorUsedError;
  @override
  String? get notificationChannelName => throw _privateConstructorUsedError;
  @override
  Duration? get overriddenDuration => throw _privateConstructorUsedError;
  @override
  int? get start => throw _privateConstructorUsedError;
  @override
  String? get licenseUrl => throw _privateConstructorUsedError;
  @override
  String? get certificateUrl => throw _privateConstructorUsedError;
  @override
  Map<String, String>? get drmHeaders => throw _privateConstructorUsedError;
  @override
  String? get activityName => throw _privateConstructorUsedError;
  @override
  String? get clearKey => throw _privateConstructorUsedError;
  @override
  String? get videoExtension => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NPDataSourceCopyWith<_NPDataSource> get copyWith =>
      throw _privateConstructorUsedError;
}
