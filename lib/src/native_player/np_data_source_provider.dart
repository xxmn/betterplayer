import 'dart:io';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/types/bp_data_source.dart';
import 'package:better_player/src/types/np_data_source.dart';
import 'package:better_player/src/types/video_format.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final npDataSourceProvider = StateNotifierProvider<NPDataSourceNotifier, NPDataSourceStatus>(
  (ref) {
    var bpDataSource = ref.watch(bpDataSourceProvider!);
    return NPDataSourceNotifier(bpDataSource: bpDataSource);
  },
);

class NPDataSourceNotifier extends StateNotifier<NPDataSourceStatus> {
  NPDataSourceNotifier({BPDataSource? bpDataSource}) : super(NPDataSourceStatus()) {
    if (bpDataSource != null) {
      _getDataSource(
        bpDataSource,
        (file) => state.tempFiles.add(file), // todo: 有待测试
      ).then(
        (ds) => state = state.copyWith(npDataSource: ds),
      );
    }
  }

  @override
  void dispose() {
    ///Delete files async
    state.tempFiles.forEach((file) => file.delete());
    super.dispose();
  }
}

class NPDataSourceStatus {
  NPDataSourceStatus({
    this.npDataSource,
    this.tempFiles = const [],
  });

  final NPDataSource? npDataSource;

  ///List of files to delete once player disposes.
  final List<File> tempFiles;

  NPDataSourceStatus copyWith({
    NPDataSource? npDataSource,
    List<File>? tempFiles,
  }) {
    return NPDataSourceStatus(
      npDataSource: npDataSource ?? this.npDataSource,
      tempFiles: tempFiles ?? this.tempFiles,
    );
  }
}

///Internal method which invokes videoPlayerController source setup.
Future<NPDataSource?> _getDataSource(BPDataSource bpDataSource, void Function(File) fn) async {
  var ntConfig = bpDataSource.notificationConfig;
  var cacheConfig = bpDataSource.cacheConfig;
  var drmConfig = bpDataSource.drmConfig;
  switch (bpDataSource.type) {
    case BPDataSourceType.network:
      return _getNetworkDataSource(
        bpDataSource.url,
        headers: getHeaders(bpDataSource.headers, drmConfig),
        useCache: cacheConfig?.useCache ?? false,
        maxCacheSize: cacheConfig?.maxCacheSize ?? 0,
        maxCacheFileSize: cacheConfig?.maxCacheFileSize ?? 0,
        cacheKey: cacheConfig?.key,
        showNotification: ntConfig?.isShow,
        title: ntConfig?.title,
        author: ntConfig?.author,
        imageUrl: ntConfig?.imageUrl,
        notificationChannelName: ntConfig?.channelName,
        overriddenDuration: bpDataSource.overriddenDuration,
        formatHint: bpDataSource.videoFormat,
        licenseUrl: drmConfig?.licenseUrl,
        certificateUrl: drmConfig?.certificateUrl,
        drmHeaders: drmConfig?.headers,
        activityName: ntConfig?.activityName,
        clearKey: drmConfig?.clearKey,
        videoExtension: bpDataSource.videoExtension,
      );

    case BPDataSourceType.file:
      final file = File(bpDataSource.url);
      if (!file.existsSync()) {
        BPUtils.log("File ${file.path} doesn't exists. This may be because "
            "you're acessing file from native path and Flutter doesn't "
            "recognize this path.");
      }

      return _getFileDataSource(
        File(bpDataSource.url),
        showNotification: ntConfig?.isShow,
        title: ntConfig?.title,
        author: ntConfig?.author,
        imageUrl: ntConfig?.imageUrl,
        notificationChannelName: ntConfig?.channelName,
        overriddenDuration: bpDataSource.overriddenDuration,
        activityName: ntConfig?.activityName,
        clearKey: drmConfig?.clearKey,
      );

    case BPDataSourceType.memory:
      final file = await _createFile(bpDataSource.bytes!, extension: bpDataSource.videoExtension);

      if (file.existsSync()) {
        fn(file);
        return _getFileDataSource(
          file,
          showNotification: ntConfig?.isShow,
          title: ntConfig?.title,
          author: ntConfig?.author,
          imageUrl: ntConfig?.imageUrl,
          notificationChannelName: ntConfig?.channelName,
          overriddenDuration: bpDataSource.overriddenDuration,
          activityName: ntConfig?.activityName,
          clearKey: drmConfig?.clearKey,
        );
      } else {
        return null;
      }

    default:
      return null;
  }
}

/// Set data source for playing a video from an asset.
///
/// The name of the asset is given by the [dataSource] argument and must not be
/// null. The [package] argument must be non-null when the asset comes from a
/// package and null otherwise.
NPDataSource _getAssetDataSource(
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
  return NPDataSource(
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
NPDataSource _getNetworkDataSource(
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
  return NPDataSource(
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
  );
}

/// Set data source for playing a video from a file.
///
/// This will load the file from the file-URI given by:
/// `'file://${file.path}'`.
NPDataSource _getFileDataSource(
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
  return NPDataSource(
    sourceType: NPDataSourceType.file,
    uri: 'file://${file.path}',
    showNotification: showNotification,
    title: title,
    author: author,
    imageUrl: imageUrl,
    notificationChannelName: notificationChannelName,
    overriddenDuration: overriddenDuration,
    activityName: activityName,
    clearKey: clearKey,
  );
}

///Create file from provided list of bytes. File will be created in temporary
///directory.
Future<File> _createFile(List<int> bytes, {String? extension = "temp"}) async {
  final String dir = (await getTemporaryDirectory()).path;
  final File temp = File('$dir/better_player_${DateTime.now().millisecondsSinceEpoch}.$extension');
  await temp.writeAsBytes(bytes);
  return temp;
}
