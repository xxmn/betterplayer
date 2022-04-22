import 'package:better_player/src/configuration/better_player_buffering_configuration.dart';
import 'package:better_player/src/configuration/better_player_data_source_type.dart';
import 'package:better_player/src/configuration/better_player_drm_configuration.dart';
import 'package:better_player/src/configuration/better_player_notification_configuration.dart';
import 'package:better_player/src/configuration/better_player_video_format.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_source.dart';
import 'package:flutter/widgets.dart';

import 'better_player_cache_configuration.dart';

///Representation of data source which will be played in Better Player. Allows
///to setup all necessary configuration connected to video source.
class BPDataSource {
  ///Type of source of video
  final BPDataSourceType type;

  ///Url of the video
  final String url;
  final String? audioUrl;

  ///Subtitles configuration
  final List<BPSubtitlesSource>? subtitles;
  final List<Section>? sections;

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

  ///Optional cache configuration, used only for network data sources
  final BPCacheCfg? cacheConfiguration;

  ///List of bytes, used only in memory player
  final List<int>? bytes;

  ///Configuration of remote controls notification
  final BPNotificationCfg? notificationConfiguration;

  ///Duration which will be returned instead of original duration
  final Duration? overriddenDuration;
  final int? start;

  ///Video format hint when data source url has not valid extension.
  final BPVideoFormat? videoFormat;

  ///Extension of video without dot.
  final String? videoExtension;

  ///Configuration of content protection
  final BPDrmCfg? drmConfiguration;

  ///Placeholder widget which will be shown until video load or play. This
  ///placeholder may be useful if you want to show placeholder before each video
  ///in playlist. Otherwise, you should use placeholder from
  /// BPConfiguration.
  final Widget? placeholder;

  ///Configuration of video buffering. Currently only supported in Android
  ///platform.
  final BPBufferingCfg bufferingConfiguration;

  BPDataSource(
    this.type,
    this.url, {
    this.audioUrl,
    this.bytes,
    this.subtitles,
    this.sections,
    this.liveStream = false,
    this.headers,
    this.useAsmsSubtitles = true,
    this.useAsmsTracks = true,
    this.useAsmsAudioTracks = true,
    this.asmsTrackNames,
    this.resolutions,
    this.cacheConfiguration,
    this.notificationConfiguration = const BPNotificationCfg(
      showNotification: false,
    ),
    this.overriddenDuration,
    this.start,
    this.videoFormat,
    this.videoExtension,
    this.drmConfiguration,
    this.placeholder,
    this.bufferingConfiguration = const BPBufferingCfg(),
  }) : assert(
            (type == BPDataSourceType.network || type == BPDataSourceType.file) ||
                (type == BPDataSourceType.memory && bytes?.isNotEmpty == true),
            "Url can't be null in network or file data source | bytes can't be null when using memory data source");

  ///Factory method to build network data source which uses url as data source
  ///Bytes parameter is not used in this data source.
  factory BPDataSource.network(
    String url, {
    String? audioUrl,
    List<BPSubtitlesSource>? subtitles,
    List<Section>? sections,
    bool? liveStream,
    Map<String, String>? headers,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    bool? useAsmsAudioTracks,
    Map<String, String>? qualities,
    BPCacheCfg? cacheConfiguration,
    BPNotificationCfg notificationConfiguration = const BPNotificationCfg(showNotification: false),
    Duration? overriddenDuration,
    int? start,
    BPVideoFormat? videoFormat,
    BPDrmCfg? drmConfiguration,
    Widget? placeholder,
    BPBufferingCfg bufferingConfiguration = const BPBufferingCfg(),
  }) {
    return BPDataSource(
      BPDataSourceType.network,
      url,
      audioUrl: audioUrl,
      subtitles: subtitles,
      sections: sections,
      liveStream: liveStream,
      headers: headers,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      useAsmsAudioTracks: useAsmsAudioTracks,
      resolutions: qualities,
      cacheConfiguration: cacheConfiguration,
      notificationConfiguration: notificationConfiguration,
      overriddenDuration: overriddenDuration,
      start: start,
      videoFormat: videoFormat,
      drmConfiguration: drmConfiguration,
      placeholder: placeholder,
      bufferingConfiguration: bufferingConfiguration,
    );
  }

  ///Factory method to build file data source which uses url as data source.
  ///Bytes parameter is not used in this data source.
  factory BPDataSource.file(
    String url, {
    String? audioUrl,
    List<BPSubtitlesSource>? subtitles,
    List<Section>? sections,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    Map<String, String>? qualities,
    BPCacheCfg? cacheConfiguration,
    BPNotificationCfg? notificationConfiguration,
    Duration? overriddenDuration,
    int? start,
    Widget? placeholder,
  }) {
    return BPDataSource(
      BPDataSourceType.file,
      url,
      audioUrl: audioUrl,
      subtitles: subtitles,
      sections: sections,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      resolutions: qualities,
      cacheConfiguration: cacheConfiguration,
      notificationConfiguration: notificationConfiguration = const BPNotificationCfg(showNotification: false),
      overriddenDuration: overriddenDuration,
      start: start,
      placeholder: placeholder,
    );
  }

  ///Factory method to build network data source which uses bytes as data source.
  ///Url parameter is not used in this data source.
  ///todo: memory 支持视频语音分离
  factory BPDataSource.memory(
    List<int> bytes, {
    String? videoExtension,
    List<BPSubtitlesSource>? subtitles,
    List<Section>? sections,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    Map<String, String>? qualities,
    BPCacheCfg? cacheConfiguration,
    BPNotificationCfg? notificationConfiguration,
    Duration? overriddenDuration,
    int? start,
    Widget? placeholder,
  }) {
    return BPDataSource(
      BPDataSourceType.memory,
      "",
      videoExtension: videoExtension,
      bytes: bytes,
      subtitles: subtitles,
      sections: sections,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      resolutions: qualities,
      cacheConfiguration: cacheConfiguration,
      notificationConfiguration: notificationConfiguration = const BPNotificationCfg(showNotification: false),
      overriddenDuration: overriddenDuration,
      start: start,
      placeholder: placeholder,
    );
  }

  BPDataSource copyWith({
    BPDataSourceType? type,
    String? url,
    String? audioUrl,
    List<int>? bytes,
    List<BPSubtitlesSource>? subtitles,
    List<Section>? sections,
    bool? liveStream,
    Map<String, String>? headers,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    bool? useAsmsAudioTracks,
    Map<String, String>? resolutions,
    BPCacheCfg? cacheConfiguration,
    BPNotificationCfg? notificationConfiguration = const BPNotificationCfg(showNotification: false),
    Duration? overriddenDuration,
    int? start,
    BPVideoFormat? videoFormat,
    String? videoExtension,
    BPDrmCfg? drmConfiguration,
    Widget? placeholder,
    BPBufferingCfg? bufferingConfiguration = const BPBufferingCfg(),
  }) {
    return BPDataSource(
      type ?? this.type,
      url ?? this.url,
      audioUrl: audioUrl ?? this.audioUrl,
      bytes: bytes ?? this.bytes,
      subtitles: subtitles ?? this.subtitles,
      sections: sections ?? this.sections,
      liveStream: liveStream ?? this.liveStream,
      headers: headers ?? this.headers,
      useAsmsSubtitles: useAsmsSubtitles ?? this.useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks ?? this.useAsmsTracks,
      useAsmsAudioTracks: useAsmsAudioTracks ?? this.useAsmsAudioTracks,
      resolutions: resolutions ?? this.resolutions,
      cacheConfiguration: cacheConfiguration ?? this.cacheConfiguration,
      notificationConfiguration: notificationConfiguration ?? this.notificationConfiguration,
      overriddenDuration: overriddenDuration ?? this.overriddenDuration,
      start: start ?? this.start,
      videoFormat: videoFormat ?? this.videoFormat,
      videoExtension: videoExtension ?? this.videoExtension,
      drmConfiguration: drmConfiguration ?? this.drmConfiguration,
      placeholder: placeholder ?? this.placeholder,
      bufferingConfiguration: bufferingConfiguration ?? this.bufferingConfiguration,
    );
  }
}

class Section {
  final int start; // in millisecond
  int? end; // in millisecond
  int? duration; // in millisecond

  final String title;
  final String? desc;
  final String? imgUrl;

  Section(this.title, {required this.start, this.duration, this.end, this.imgUrl, this.desc})
      : assert(duration != null || end != null, "duration or end must be filled."),
        assert(
          !(duration != null && end != null && end - start != duration),
          "should be match(duration = end - start).",
        ) {
    if (duration != null) {
      end = start + duration!;
    }
    if (end != null) {
      duration = end! - start;
    }
  }
}
