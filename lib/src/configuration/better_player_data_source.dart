import 'package:better_player/src/configuration/better_player_buffering_configuration.dart';
import 'package:better_player/src/configuration/better_player_data_source_type.dart';
import 'package:better_player/src/configuration/better_player_drm_configuration.dart';
import 'package:better_player/src/configuration/better_player_notification_cfg.dart';
import 'package:better_player/src/configuration/better_player_video_format.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_source.dart';
import 'package:flutter/widgets.dart';

import 'better_player_cache_configuration.dart';

///Representation of data source which will be played in Better Player. Allows
///to setup all necessary configuration connected to video source.
class BPDataSource {
  // g_startAt = startAt;

  ///Type of source of video
  BPDataSourceType type;

  ///Url of the video
  String url;
  String? audioUrl;

  ///Subtitles configuration
  List<BPSubtitlesSource>? subtitles;
  List<Section>? sections;

  ///Flag to determine if current data source is live stream
  bool isLiveStream = false;

  /// Custom headers for player
  Map<String, String>? headers;

  ///Should player use hls / dash subtitles (ASMS - Adaptive Streaming Media Sources).
  bool? useAsmsSubtitles;

  ///Should player use hls tracks
  bool? useAsmsTracks;

  ///Should player use hls /das audio tracks
  bool? useAsmsAudioTracks;

  ///List of strings that represents tracks names.
  ///If empty, then better player will choose name based on track parameters
  List<String>? asmsTrackNames;

  ///Optional, alternative resolutions for non-hls/dash video. Used to setup
  ///different qualities for video.
  ///Data should be in given format:
  ///{"360p": "url", "540p": "url2" }
  Map<String, String>? resolutions;

  ///Optional cache configuration, used only for network data sources
  BPCacheCfg? cacheCfg;

  ///List of bytes, used only in memory player
  List<int>? bytes;

  ///Duration which will be returned instead of original duration
  Duration? overriddenDuration;
  int? start;

  ///Video format hint when data source url has not valid extension.
  BPVideoFormat? videoFormat;

  ///Extension of video without dot.
  String? videoExtension;

  ///Cfg of content protection
  BPDrmCfg? drmCfg;

  ///Placeholder widget which will be shown until video load or play. This
  ///placeholder may be useful if you want to show placeholder before each video
  ///in playlist. Otherwise, you should use placeholder from
  /// BPConfiguration.
  Widget? placeholder;

  ///Cfg of video buffering. Currently only supported in Android
  ///platform.
  BPBufferingCfg bufferingCfg;

  BPDataSource(
    this.type,
    this.url, {
    this.audioUrl,
    this.bytes,
    this.subtitles,
    this.sections,
    this.isLiveStream = false,
    this.headers,
    this.useAsmsSubtitles = true,
    this.useAsmsTracks = true,
    this.useAsmsAudioTracks = true,
    this.asmsTrackNames,
    this.resolutions,
    this.cacheCfg,
    this.overriddenDuration,
    this.start,
    this.videoFormat,
    this.videoExtension,
    this.drmCfg,
    this.placeholder,
    this.bufferingCfg = const BPBufferingCfg(),
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
    bool? isLiveStream,
    Map<String, String>? headers,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    bool? useAsmsAudioTracks,
    Map<String, String>? qualities,
    BPCacheCfg? cacheCfg,
    Duration? overriddenDuration,
    int? start,
    BPVideoFormat? videoFormat,
    BPDrmCfg? drmCfg,
    Widget? placeholder,
    BPBufferingCfg bufferingCfg = const BPBufferingCfg(),
  }) {
    return BPDataSource(
      BPDataSourceType.network,
      url,
      audioUrl: audioUrl,
      subtitles: subtitles,
      sections: sections,
      isLiveStream: isLiveStream ?? false,
      headers: headers,
      useAsmsSubtitles: useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks,
      useAsmsAudioTracks: useAsmsAudioTracks,
      resolutions: qualities,
      cacheCfg: cacheCfg,
      overriddenDuration: overriddenDuration,
      start: start,
      videoFormat: videoFormat,
      drmCfg: drmCfg,
      placeholder: placeholder,
      bufferingCfg: bufferingCfg,
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
    BPCacheCfg? cacheCfg,
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
      cacheCfg: cacheCfg,
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
    BPCacheCfg? cacheCfg,
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
      cacheCfg: cacheCfg,
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
    bool? isLiveStream,
    Map<String, String>? headers,
    bool? useAsmsSubtitles,
    bool? useAsmsTracks,
    bool? useAsmsAudioTracks,
    Map<String, String>? resolutions,
    BPCacheCfg? cacheCfg,
    Duration? overriddenDuration,
    int? start,
    BPVideoFormat? videoFormat,
    String? videoExtension,
    BPDrmCfg? drmCfg,
    Widget? placeholder,
    BPBufferingCfg? bufferingCfg = const BPBufferingCfg(),
  }) {
    return BPDataSource(
      type ?? this.type,
      url ?? this.url,
      audioUrl: audioUrl ?? this.audioUrl,
      bytes: bytes ?? this.bytes,
      subtitles: subtitles ?? this.subtitles,
      sections: sections ?? this.sections,
      isLiveStream: isLiveStream ?? this.isLiveStream,
      headers: headers ?? this.headers,
      useAsmsSubtitles: useAsmsSubtitles ?? this.useAsmsSubtitles,
      useAsmsTracks: useAsmsTracks ?? this.useAsmsTracks,
      useAsmsAudioTracks: useAsmsAudioTracks ?? this.useAsmsAudioTracks,
      resolutions: resolutions ?? this.resolutions,
      cacheCfg: cacheCfg ?? this.cacheCfg,
      overriddenDuration: overriddenDuration ?? this.overriddenDuration,
      start: start ?? this.start,
      videoFormat: videoFormat ?? this.videoFormat,
      videoExtension: videoExtension ?? this.videoExtension,
      drmCfg: drmCfg ?? this.drmCfg,
      placeholder: placeholder ?? this.placeholder,
      bufferingCfg: bufferingCfg ?? this.bufferingCfg,
    );
  }
}

class Section {
  int start; // in millisecond
  int? end; // in millisecond
  int? duration; // in millisecond

  String title;
  String? desc;
  String? imgUrl;

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
