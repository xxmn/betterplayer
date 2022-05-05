import 'dart:io';

import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/native_player/platform_interface.dart';
import 'package:better_player/src/types/np_data_source.dart';
import 'package:better_player/src/types/video_format.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final npDataSourceProvider = Provider<NPDataSource?>((ref) {
  var bpDS = ref.watch(bpDataSourceProvider);
});

/// Set data source for playing a video from an asset.
///
/// The name of the asset is given by the [dataSource] argument and must not be
/// null. The [package] argument must be non-null when the asset comes from a
/// package and null otherwise.
Future<void> _setAssetDataSource(
  String dataSource, {
  String? package,
  bool? showNotification,
  String? title,
  String? author,
  String? imageUrl,
  String? notificationChannelName,
  Duration? overriddenDuration,
  String? activityName,
}) {
  return _setDataSource(
    NPDataSource(
      sourceType: NPDataSourceType.asset,
      asset: dataSource,
      package: package,
      showNotification: showNotification,
      title: title,
      author: author,
      imageUrl: imageUrl,
      notificationChannelName: notificationChannelName,
      overriddenDuration: overriddenDuration,
      activityName: activityName,
    ),
  );
}

/// Set data source for playing a video from obtained from
/// the network.
///
/// The URI for the video is given by the [dataSource] argument and must not be
/// null.
/// **Android only**: The [formatHint] option allows the caller to override
/// the video format detection code.
/// ClearKey DRM only supported on Android.
Future<void> _setNetworkDataSource(
  String dataSource, {
  VideoFormat? formatHint,
  Map<String, String?>? headers,
  bool useCache = false,
  int? maxCacheSize,
  int? maxCacheFileSize,
  String? cacheKey,
  bool? showNotification,
  String? title,
  String? author,
  String? imageUrl,
  String? notificationChannelName,
  Duration? overriddenDuration,
  String? licenseUrl,
  String? certificateUrl,
  Map<String, String>? drmHeaders,
  String? activityName,
  String? clearKey,
  String? videoExtension,
}) {
  return _setDataSource(
    NPDataSource(
      sourceType: NPDataSourceType.network,
      uri: dataSource,
      formatHint: formatHint,
      headers: headers,
      useCache: useCache,
      maxCacheSize: maxCacheSize,
      maxCacheFileSize: maxCacheFileSize,
      cacheKey: cacheKey,
      showNotification: showNotification,
      title: title,
      author: author,
      imageUrl: imageUrl,
      notificationChannelName: notificationChannelName,
      overriddenDuration: overriddenDuration,
      licenseUrl: licenseUrl,
      certificateUrl: certificateUrl,
      drmHeaders: drmHeaders,
      activityName: activityName,
      clearKey: clearKey,
      videoExtension: videoExtension,
    ),
  );
}

/// Set data source for playing a video from a file.
///
/// This will load the file from the file-URI given by:
/// `'file://${file.path}'`.
Future<void> _setFileDataSource(
  File file, {
  bool? showNotification,
  String? title,
  String? author,
  String? imageUrl,
  String? notificationChannelName,
  Duration? overriddenDuration,
  String? activityName,
  String? clearKey,
}) {
  return _setDataSource(
    NPDataSource(
        sourceType: NPDataSourceType.file,
        uri: 'file://${file.path}',
        showNotification: showNotification,
        title: title,
        author: author,
        imageUrl: imageUrl,
        notificationChannelName: notificationChannelName,
        overriddenDuration: overriddenDuration,
        activityName: activityName,
        clearKey: clearKey),
  );
}

Future<void> _setDataSource(NPDataSource dataSourceDescription) async {
  Future.value("11");
  // if (_isDisposed) {
  //   return;
  // }

  // value = VideoPlayerValue(
  //   duration: null,
  //   isLooping: value.isLooping,
  //   volume: value.volume,
  // );

  // if (!_creatingCompleter.isCompleted) await _creatingCompleter.future;

  // _initializingCompleter = Completer<void>();

  // await NativePlayerPlatform.instance.setDataSource(_textureId, dataSourceDescription);
  // return _initializingCompleter.future;
}
