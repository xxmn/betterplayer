import 'video_format.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'np_data_source.freezed.dart';

/// Description of the data source used to create an instance of
/// the video player.
@freezed
class NPDataSource with _$NPDataSource {
  // Added constructor. Must not have any parameter
  const NPDataSource._();

  /// Constructs an instance of [DataSource].
  ///
  /// The [sourceType] is always required.
  ///
  /// The [uri] argument takes the form of `'https://example.com/video.mp4'` or
  /// `'file://${file.path}'`.
  ///
  /// The [formatHint] argument can be null.
  ///
  /// The [asset] argument takes the form of `'assets/video.mp4'`.
  ///
  /// The [package] argument must be non-null when the asset comes from a
  /// package and null otherwise.
  ///
  @Assert('uri != null || asset != null', "uri or asset should be not null")
  const factory NPDataSource({
    /// Describes the type of data source this [VideoPlayerController]
    /// is constructed with.
    ///
    /// The way in which the video was originally loaded.
    ///
    /// This has nothing to do with the video's file type. It's just the place
    /// from which the video is fetched from.
    required NPDataSourceType sourceType,

    /// The URI to the video file.
    ///
    /// This will be in different formats depending on the [DataSourceType] of
    /// the original video.
    String? uri,
    String? audioUri,

    /// **Android only**. Will override the platform's generic file format
    /// detection with whatever is set here.
    VideoFormat? formatHint,

    /// The name of the asset. Only set for [DataSourceType.asset] videos.
    String? asset,

    /// The package that the asset was loaded from. Only set for
    /// [DataSourceType.asset] videos.
    String? package,
    Map<String, String?>? headers,
    @Default(false) bool useCache,

    /// The maximum cache size to keep on disk in bytes.
    @Default(100 * 1024 * 1024) int? maxCacheSize,

    /// The maximum size of each individual file in bytes.
    @Default(10 * 1024 * 1024) int? maxCacheFileSize,
    String? cacheKey,
    @Default(false) bool? showNotification,
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
    String? videoExtension,
  }) = _NPDataSource;

  /// **Android only**. String representation of a formatHint.
  String? get rawFormalHint {
    switch (formatHint) {
      case VideoFormat.ss:
        return 'ss';
      case VideoFormat.hls:
        return 'hls';
      case VideoFormat.dash:
        return 'dash';
      case VideoFormat.other:
        return 'other';
      default:
        return null;
    }
  }

  /// Key to compare DataSource
  String get key {
    String? result = "";

    if (uri != null && uri!.isNotEmpty) {
      result = uri;
    } else if (package != null && package!.isNotEmpty) {
      result = "$package:$asset";
    } else {
      result = asset;
    }

    if (formatHint != null) {
      result = "$result:$rawFormalHint";
    }

    return result!;
  }
}

/// The way in which the video was originally loaded.
///
/// This has nothing to do with the video's file type. It's just the place
/// from which the video is fetched from.
enum NPDataSourceType {
  /// The video was included in the app's asset files.
  asset,

  /// The video was downloaded from the internet.
  network,

  /// The video was loaded off of the local filesystem.
  file
}
