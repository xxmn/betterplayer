import 'package:flutter/widgets.dart';
import 'bp_data_source_type.dart';

///Representation of data source which will be played in Better Player. Allows
///to setup all necessary configuration connected to video source.
class BPDataSource {
  ///Type of source of video
  final BPDataSourceType type;

  ///Url of the video
  final String url;

  // ///Subtitles configuration
  // final List<BPSubtitlesSource>? subtitles;

  ///Flag to determine if current data source is live stream
  final bool? liveStream;

  /// Custom headers for player
  final Map<String, String>? headers;

  ///Should player use hls / dash subtitles (ASMS - Adaptive Streaming Media Sources).
  final bool? useAsmsSubtitles;

  ///Should player use hls tracks
  final bool? useAsmsTracks;

  ///Should player use hls /das audio tracks
  final bool? useAsmsAudioTracks;

  ///List of strings that represents tracks names.
  ///If empty, then better player will choose name based on track parameters
  final List<String>? asmsTrackNames;

  ///Optional, alternative resolutions for non-hls/dash video. Used to setup
  ///different qualities for video.
  ///Data should be in given format:
  ///{"360p": "url", "540p": "url2" }
  final Map<String, String>? resolutions;

  // ///Optional cache configuration, used only for network data sources
  // final BPCacheConfig? cacheConfig;

  ///List of bytes, used only in memory player
  final List<int>? bytes;

  // ///Config of remote controls notification
  // final BPNotificationConfig? notificationConfig;

  ///Duration which will be returned instead of original duration
  final Duration? overriddenDuration;

  // ///Video format hint when data source url has not valid extension.
  // final BPVideoFormat? videoFormat;

  ///Extension of video without dot.
  final String? videoExtension;

  // ///Config of content protection
  // final BPDrmConfig? drmConfig;

  ///Placeholder widget which will be shown until video load or play. This
  ///placeholder may be useful if you want to show placeholder before each video
  ///in playlist. Otherwise, you should use placeholder from
  /// BPConfig.
  final Widget? placeholder;

  // ///Config of video buffering. Currently only supported in Android
  // ///platform.
  // final BPBufferingConfig bufferingConfig;

  BPDataSource(
    this.type,
    this.url, {
    this.bytes,
    // this.subtitles,
    this.liveStream = false,
    this.headers,
    this.useAsmsSubtitles = true,
    this.useAsmsTracks = true,
    this.useAsmsAudioTracks = true,
    this.asmsTrackNames,
    this.resolutions,
    // this.cacheConfig,
    // this.notificationConfig = const BPNotificationConfig(
    //   showNotification: false,
    // ),
    this.overriddenDuration,
    // this.videoFormat,
    this.videoExtension,
    // this.drmConfig,
    this.placeholder,
    // this.bufferingConfig = const BPBufferingConfig(),
  }) : assert(
            (type == BPDataSourceType.network || type == BPDataSourceType.file) ||
                (type == BPDataSourceType.memory && bytes?.isNotEmpty == true),
            "Url can't be null in network or file data source | bytes can't be null when using memory data source");

  ///Factory method to build network data source which uses url as data source
  ///Bytes parameter is not used in this data source.
  factory BPDataSource.network(
    String url, {
    // List<BPSubtitlesSource>? subtitles,
    bool? liveStream,
    Map<String, String>? headers,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    bool? useAsmsAudioTracks,
    Map<String, String>? qualities,
    // BPCacheConfig? cacheConfig,
    // BPNotificationConfig notificationConfig = const BPNotificationConfig(showNotification: false),
    Duration? overriddenDuration,
    // BPVideoFormat? videoFormat,
    // BPDrmConfig? drmConfig,
    Widget? placeholder,
    // BPBufferingConfig bufferingConfig = const BPBufferingConfig(),
  }) {
    return BPDataSource(
      BPDataSourceType.network,
      url,
      // subtitles: subtitles,
      liveStream: liveStream,
      headers: headers,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      useAsmsAudioTracks: useAsmsAudioTracks,
      resolutions: qualities,
      // cacheConfig: cacheConfig,
      // notificationConfig: notificationConfig,
      overriddenDuration: overriddenDuration,
      // videoFormat: videoFormat,
      // drmConfig: drmConfig,
      placeholder: placeholder,
      // bufferingConfig: bufferingConfig,
    );
  }

  ///Factory method to build file data source which uses url as data source.
  ///Bytes parameter is not used in this data source.
  factory BPDataSource.file(
    String url, {
    // List<BPSubtitlesSource>? subtitles,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    Map<String, String>? qualities,
    // BPCacheConfig? cacheConfig,
    // BPNotificationConfig? notificationConfig,
    Duration? overriddenDuration,
    Widget? placeholder,
  }) {
    return BPDataSource(
      BPDataSourceType.file,
      url,
      // subtitles: subtitles,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      resolutions: qualities,
      // cacheConfig: cacheConfig,
      // notificationConfig: notificationConfig = const BPNotificationConfig(showNotification: false),
      overriddenDuration: overriddenDuration,
      placeholder: placeholder,
    );
  }

  ///Factory method to build network data source which uses bytes as data source.
  ///Url parameter is not used in this data source.
  factory BPDataSource.memory(
    List<int> bytes, {
    String? videoExtension,
    // List<BPSubtitlesSource>? subtitles,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    Map<String, String>? qualities,
    // BPCacheConfig? cacheConfig,
    // BPNotificationConfig? notificationConfig,
    Duration? overriddenDuration,
    Widget? placeholder,
  }) {
    return BPDataSource(
      BPDataSourceType.memory,
      "",
      videoExtension: videoExtension,
      bytes: bytes,
      // subtitles: subtitles,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      resolutions: qualities,
      // cacheConfig: cacheConfig,
      // notificationConfig: notificationConfig = const BPNotificationConfig(showNotification: false),
      overriddenDuration: overriddenDuration,
      placeholder: placeholder,
    );
  }
}
