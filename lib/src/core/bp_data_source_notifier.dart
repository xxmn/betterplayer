import 'dart:io';
import 'package:better_player/src/asms/better_player_asms_audio_track.dart';
import 'package:better_player/src/asms/better_player_asms_subtitle.dart';
import 'package:better_player/src/asms/better_player_asms_track.dart';
import 'package:better_player/src/asms/better_player_asms_utils.dart';
import 'package:better_player/src/configuration/better_player_controller_event.dart';
import 'package:better_player/src/configuration/better_player_data_source.dart';
import 'package:better_player/src/configuration/better_player_data_source_type.dart';
import 'package:better_player/src/configuration/better_player_drm_configuration.dart';
import 'package:better_player/src/configuration/better_player_event.dart';
import 'package:better_player/src/configuration/better_player_event_type.dart';
import 'package:better_player/src/configuration/better_player_notification_cfg.dart';
import 'package:better_player/src/configuration/better_player_video_format.dart';
import 'package:better_player/src/native_player/platform_interface.dart';
import 'package:better_player/src/subtitles/better_player_subtitle.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_factory.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_source.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_source_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPDataSourceNotifier with ChangeNotifier {
  BPDataSourceNotifier({
    required BPDataSource bpDataSource,
    required this.bpNotificationCfg,
  }) {
    this._bpDataSource = bpDataSource;
  }

  BPDataSource _bpDataSource;
  BPNotificationCfg bpNotificationCfg;

  ///Has current data source started
  bool _hasCurrentDataSourceStarted = false;

  ///Flag which determines whenever current data source has started.
  bool get hasCurrentDataSourceStarted => _hasCurrentDataSourceStarted;

  ///Has current data source initialized
  bool _hasCurrentDataSourceInitialized = false;

  ///Flag which determines whenever player is playing live data source.
  bool get isLiveStream => bpDataSource.isLiveStream;
  void set isLiveStream(bool isLiveStream) {
    if (bpDataSource.isLiveStream != isLiveStream) {
      bpDataSource.isLiveStream = isLiveStream;
      notifyListeners();
    }
  }

  ///Flag which determines whenever player data source has been initialized.
  // bool? isVideoInitialized() {
  /// Indicates whether or not the video has been loaded and is ready to play.
  bool get initialized => duration != null;

  /// Returns [size.width] / [size.height] when size is non-null, or `1.0.` when
  /// size is null or the aspect ratio would be less than or equal to 0.0.
  double get aspectRatio {
    if (size == null) {
      return 1.0;
    }
    final double aspectRatio = size!.width / size!.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  final String? errorDescription;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != null;

  /// The [size] of the currently loaded video.
  ///
  /// Is null when [initialized] is false.
  final Size? size;

  /// The total duration of the video.
  ///
  /// Is null when [initialized] is false.
  final Duration? duration;

  ///List of BPSubtitlesSources.
  final List<BPSubtitlesSource> _betterPlayerSubtitlesSourceList = [];

  ///List of BPSubtitlesSources.
  List<BPSubtitlesSource> get betterPlayerSubtitlesSourceList => _betterPlayerSubtitlesSourceList;
  BPSubtitlesSource? _betterPlayerSubtitlesSource;

  ///Currently used subtitles source.
  BPSubtitlesSource? get betterPlayerSubtitlesSource => _betterPlayerSubtitlesSource;

  ///Subtitles lines for current data source.
  List<BPSubtitle> subtitlesLines = [];

  ///List of tracks available for current data source. Used only for HLS / DASH.
  List<BPAsmsTrack> _betterPlayerAsmsTracks = [];

  ///List of tracks available for current data source. Used only for HLS / DASH.
  List<BPAsmsTrack> get betterPlayerAsmsTracks => _betterPlayerAsmsTracks;

  ///Currently selected player track. Used only for HLS / DASH.
  BPAsmsTrack? _betterPlayerAsmsTrack;

  ///Currently selected player track. Used only for HLS / DASH.
  BPAsmsTrack? get betterPlayerAsmsTrack => _betterPlayerAsmsTrack;

  ///List of all possible audio tracks returned from ASMS stream
  List<BPAsmsAudioTrack>? _betterPlayerAsmsAudioTracks;

  ///List of all possible audio tracks returned from ASMS stream
  List<BPAsmsAudioTrack>? get betterPlayerAsmsAudioTracks => _betterPlayerAsmsAudioTracks;

  ///Selected ASMS audio track
  BPAsmsAudioTrack? _betterPlayerAsmsAudioTrack;

  ///Selected ASMS audio track
  BPAsmsAudioTrack? get betterPlayerAsmsAudioTrack => _betterPlayerAsmsAudioTrack;

  ///Flag which determines whether are ASMS segments loading
  bool _asmsSegmentsLoading = false;

  ///List of loaded ASMS segments
  final List<String> _asmsSegmentsLoaded = [];

  ///Currently displayed [BPSubtitle].
  BPSubtitle? renderedSubtitle;

  ///Setup new data source in Better Player.
  Future setupDataSource(BPDataSource betterPlayerDataSource) async {
    // postEvent(BPEvent(BPEventType.setupDataSource, parameters: <String, dynamic>{
    //   _dataSourceParameter: betterPlayerDataSource,
    // }));
    // _postControllerEvent(BPControllerEvent.setupDataSource);
    _hasCurrentDataSourceStarted = false;
    _hasCurrentDataSourceInitialized = false;
    _bpDataSource = betterPlayerDataSource;
    _betterPlayerSubtitlesSourceList.clear();

    ///Build videoPlayerController if null
    if (videoPlayerController == null) {
      videoPlayerController =
          VideoPlayerController(bufferingConfiguration: betterPlayerDataSource.bufferingConfiguration);
      videoPlayerController?.addListener(_onVideoPlayerChanged);
    }

    ///Clear asms tracks
    betterPlayerAsmsTracks.clear();

    ///Setup subtitles
    final List<BPSubtitlesSource>? betterPlayerSubtitlesSourceList = betterPlayerDataSource.subtitles;
    if (betterPlayerSubtitlesSourceList != null) {
      _betterPlayerSubtitlesSourceList.addAll(betterPlayerDataSource.subtitles!);
    }

    if (_isDataSourceAsms(betterPlayerDataSource)) {
      _setupAsmsDataSource(betterPlayerDataSource).then((dynamic value) {
        _setupSubtitles();
      });
    } else {
      _setupSubtitles();
    }

    ///Process data source
    await _setupDataSource(betterPlayerDataSource);
    setTrack(BPAsmsTrack.defaultTrack());
  }

  ///Check if given [betterPlayerDataSource] is HLS / DASH-type data source.
  bool _isDataSourceAsms(BPDataSource betterPlayerDataSource) =>
      (BPAsmsUtils.isDataSourceHls(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BPVideoFormat.hls) ||
      (BPAsmsUtils.isDataSourceDash(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BPVideoFormat.dash);

  ///Check if given [betterPlayerDataSource] is HLS / DASH-type data source.
  bool _isDataSourceAsms(BPDataSource betterPlayerDataSource) =>
      (BPAsmsUtils.isDataSourceHls(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BPVideoFormat.hls) ||
      (BPAsmsUtils.isDataSourceDash(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BPVideoFormat.dash);

  ///Configure HLS / DASH data source based on provided data source and configuration.
  ///This method configures tracks, subtitles and audio tracks from given
  ///master playlist.
  Future _setupAsmsDataSource(BPDataSource source) async {
    final String? data = await BPAsmsUtils.getDataFromUrl(
      betterPlayerDataSource!.url,
      _getHeaders(),
    );
    if (data != null) {
      final BPAsmsDataHolder _response = await BPAsmsUtils.parse(data, betterPlayerDataSource!.url);

      /// Load tracks
      if (_betterPlayerDataSource?.useAsmsTracks == true) {
        _betterPlayerAsmsTracks = _response.tracks ?? [];
      }

      /// Load subtitles
      if (betterPlayerDataSource?.useAsmsSubtitles == true) {
        final List<BPAsmsSubtitle> asmsSubtitles = _response.subtitles ?? [];
        asmsSubtitles.forEach((BPAsmsSubtitle asmsSubtitle) {
          _betterPlayerSubtitlesSourceList.add(
            BPSubtitlesSource(
              type: BPSubtitlesSourceType.network,
              name: asmsSubtitle.name,
              urls: asmsSubtitle.realUrls,
              asmsIsSegmented: asmsSubtitle.isSegmented,
              asmsSegmentsTime: asmsSubtitle.segmentsTime,
              asmsSegments: asmsSubtitle.segments,
              selectedByDefault: asmsSubtitle.isDefault,
            ),
          );
        });
      }

      ///Load audio tracks
      if (betterPlayerDataSource?.useAsmsAudioTracks == true && _isDataSourceAsms(betterPlayerDataSource!)) {
        _betterPlayerAsmsAudioTracks = _response.audios ?? [];
        if (_betterPlayerAsmsAudioTracks?.isNotEmpty == true) {
          setAudioTrack(_betterPlayerAsmsAudioTracks!.first);
        }
      }
    }
  }

  ///Setup subtitles to be displayed from given subtitle source.
  ///If subtitles source is segmented then don't load videos at start. Videos
  ///will load with just in time policy.
  Future<void> setupSubtitleSource(BPSubtitlesSource subtitlesSource, {bool sourceInitialize = false}) async {
    _betterPlayerSubtitlesSource = subtitlesSource;
    subtitlesLines.clear();
    _asmsSegmentsLoaded.clear();
    _asmsSegmentsLoading = false;

    if (subtitlesSource.type != BPSubtitlesSourceType.none) {
      if (subtitlesSource.asmsIsSegmented == true) {
        return;
      }
      final subtitlesParsed = await BPSubtitlesFactory.parseSubtitles(subtitlesSource);
      subtitlesLines.addAll(subtitlesParsed);
    }

    _postEvent(BPEvent(BPEventType.changedSubtitles));
    if (!_disposed && !sourceInitialize) {
      _postControllerEvent(BPControllerEvent.changeSubtitles);
    }
  }

  ///Load ASMS subtitles segments for given [position].
  ///Segments are being loaded within range (current video position;endPosition)
  ///where endPosition is based on time segment detected in HLS playlist. If
  ///time segment is not present then 5000 ms will be used. Also time segment
  ///is multiplied by 5 to increase window of duration.
  ///Segments are also cached, so same segment won't load twice. Only one
  ///pack of segments can be load at given time.
  Future _loadAsmsSubtitlesSegments(Duration position) async {
    try {
      if (_asmsSegmentsLoading) {
        return;
      }
      _asmsSegmentsLoading = true;
      final BPSubtitlesSource? source = _betterPlayerSubtitlesSource;
      final Duration loadDurationEnd = Duration(
          milliseconds: position.inMilliseconds + 5 * (_betterPlayerSubtitlesSource?.asmsSegmentsTime ?? 5000));

      final segmentsToLoad = _betterPlayerSubtitlesSource?.asmsSegments
          ?.where((segment) {
            return segment.startTime > position &&
                segment.endTime < loadDurationEnd &&
                !_asmsSegmentsLoaded.contains(segment.realUrl);
          })
          .map((segment) => segment.realUrl)
          .toList();

      if (segmentsToLoad != null && segmentsToLoad.isNotEmpty) {
        final subtitlesParsed = await BPSubtitlesFactory.parseSubtitles(BPSubtitlesSource(
          type: _betterPlayerSubtitlesSource!.type,
          headers: _betterPlayerSubtitlesSource!.headers,
          urls: segmentsToLoad,
        ));

        ///Additional check if current source of subtitles is same as source
        ///used to start loading subtitles. It can be different when user
        ///changes subtitles and there was already pending load.
        if (source == _betterPlayerSubtitlesSource) {
          subtitlesLines.addAll(subtitlesParsed);
          _asmsSegmentsLoaded.addAll(segmentsToLoad);
        }
      }
      _asmsSegmentsLoading = false;
    } catch (exception) {
      BPUtils.log("Load ASMS subtitle segments failed: $exception");
    }
  }

  ///Get VideoFormat from BPVideoFormat (adapter method which translates
  ///to video_player supported format).
  VideoFormat? _getVideoFormat(BPVideoFormat? betterPlayerVideoFormat) {
    if (betterPlayerVideoFormat == null) {
      return null;
    }
    switch (betterPlayerVideoFormat) {
      case BPVideoFormat.dash:
        return VideoFormat.dash;
      case BPVideoFormat.hls:
        return VideoFormat.hls;
      case BPVideoFormat.ss:
        return VideoFormat.ss;
      case BPVideoFormat.other:
        return VideoFormat.other;
    }
  }

  ///Internal method which invokes videoPlayerController source setup.
  Future _setupDataSource(BPDataSource betterPlayerDataSource) async {
    switch (betterPlayerDataSource.type) {
      case BPDataSourceType.network:
        await videoPlayerController?.setNetworkDataSource(
          betterPlayerDataSource.url,
          headers: _getHeaders(),
          useCache: _betterPlayerDataSource!.cacheConfiguration?.useCache ?? false,
          maxCacheSize: _betterPlayerDataSource!.cacheConfiguration?.maxCacheSize ?? 0,
          maxCacheFileSize: _betterPlayerDataSource!.cacheConfiguration?.maxCacheFileSize ?? 0,
          cacheKey: _betterPlayerDataSource?.cacheConfiguration?.key,
          showNotification: _betterPlayerDataSource?.notificationConfiguration?.showNotification,
          title: _betterPlayerDataSource?.notificationConfiguration?.title,
          author: _betterPlayerDataSource?.notificationConfiguration?.author,
          imageUrl: _betterPlayerDataSource?.notificationConfiguration?.imageUrl,
          notificationChannelName: _betterPlayerDataSource?.notificationConfiguration?.notificationChannelName,
          overriddenDuration: _betterPlayerDataSource!.overriddenDuration,
          formatHint: _getVideoFormat(_betterPlayerDataSource!.videoFormat),
          licenseUrl: _betterPlayerDataSource?.drmConfiguration?.licenseUrl,
          certificateUrl: _betterPlayerDataSource?.drmConfiguration?.certificateUrl,
          drmHeaders: _betterPlayerDataSource?.drmConfiguration?.headers,
          activityName: _betterPlayerDataSource?.notificationConfiguration?.activityName,
          clearKey: _betterPlayerDataSource?.drmConfiguration?.clearKey,
          videoExtension: _betterPlayerDataSource!.videoExtension,
        );

        break;
      case BPDataSourceType.file:
        final file = File(betterPlayerDataSource.url);
        if (!file.existsSync()) {
          BPUtils.log("File ${file.path} doesn't exists. This may be because "
              "you're acessing file from native path and Flutter doesn't "
              "recognize this path.");
        }

        await videoPlayerController?.setFileDataSource(File(betterPlayerDataSource.url),
            showNotification: _betterPlayerDataSource?.notificationConfiguration?.showNotification,
            title: _betterPlayerDataSource?.notificationConfiguration?.title,
            author: _betterPlayerDataSource?.notificationConfiguration?.author,
            imageUrl: _betterPlayerDataSource?.notificationConfiguration?.imageUrl,
            notificationChannelName: _betterPlayerDataSource?.notificationConfiguration?.notificationChannelName,
            overriddenDuration: _betterPlayerDataSource!.overriddenDuration,
            activityName: _betterPlayerDataSource?.notificationConfiguration?.activityName,
            clearKey: _betterPlayerDataSource?.drmConfiguration?.clearKey);
        break;
      case BPDataSourceType.memory:
        final file =
            await _createFile(_betterPlayerDataSource!.bytes!, extension: _betterPlayerDataSource!.videoExtension);

        if (file.existsSync()) {
          await videoPlayerController?.setFileDataSource(file,
              showNotification: _betterPlayerDataSource?.notificationConfiguration?.showNotification,
              title: _betterPlayerDataSource?.notificationConfiguration?.title,
              author: _betterPlayerDataSource?.notificationConfiguration?.author,
              imageUrl: _betterPlayerDataSource?.notificationConfiguration?.imageUrl,
              notificationChannelName: _betterPlayerDataSource?.notificationConfiguration?.notificationChannelName,
              overriddenDuration: _betterPlayerDataSource!.overriddenDuration,
              activityName: _betterPlayerDataSource?.notificationConfiguration?.activityName,
              clearKey: _betterPlayerDataSource?.drmConfiguration?.clearKey);
          _tempFiles.add(file);
        } else {
          throw ArgumentError("Couldn't create file from memory.");
        }
        break;

      default:
        throw UnimplementedError("${betterPlayerDataSource.type} is not implemented");
    }
    await _initializeVideo();
  }

  ///Create file from provided list of bytes. File will be created in temporary
  ///directory.
  Future<File> _createFile(List<int> bytes, {String? extension = "temp"}) async {
    final String dir = (await getTemporaryDirectory()).path;
    final File temp = File('$dir/better_player_${DateTime.now().millisecondsSinceEpoch}.$extension');
    await temp.writeAsBytes(bytes);
    return temp;
  }

  ///Configure subtitles based on subtitles source.
  void _setupSubtitles() {
    _betterPlayerSubtitlesSourceList.add(
      BetterPlayerSubtitlesSource(type: BetterPlayerSubtitlesSourceType.none),
    );
    final defaultSubtitle =
        _betterPlayerSubtitlesSourceList.firstWhereOrNull((element) => element.selectedByDefault == true);

    ///Setup subtitles (none is default)
    setupSubtitleSource(defaultSubtitle ?? _betterPlayerSubtitlesSourceList.last, sourceInitialize: true);
  }

  ///Check if given [betterPlayerDataSource] is HLS / DASH-type data source.
  bool _isDataSourceAsms(BetterPlayerDataSource betterPlayerDataSource) =>
      (BetterPlayerAsmsUtils.isDataSourceHls(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BetterPlayerVideoFormat.hls) ||
      (BetterPlayerAsmsUtils.isDataSourceDash(betterPlayerDataSource.url) ||
          betterPlayerDataSource.videoFormat == BetterPlayerVideoFormat.dash);

  ///Setup track parameters for currently played video. Can be only used for HLS or DASH
  ///data source.
  void setTrack(BetterPlayerAsmsTrack track) {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    _postEvent(BetterPlayerEvent(BetterPlayerEventType.changedTrack, parameters: <String, dynamic>{
      "id": track.id,
      "width": track.width,
      "height": track.height,
      "bitrate": track.bitrate,
      "frameRate": track.frameRate,
      "codecs": track.codecs,
      "mimeType": track.mimeType,
    }));

    videoPlayerController!.setTrackParameters(track.width, track.height, track.bitrate);
    _betterPlayerAsmsTrack = track;
  }

  ///Set different resolution (quality) for video
  void setResolution(String url) async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    final position = await videoPlayerController!.position;
    final wasPlayingBeforeChange = isPlaying()!;
    pause();
    await setupDataSource(betterPlayerDataSource!.copyWith(url: url));
    seekTo(position!);
    if (wasPlayingBeforeChange) {
      play();
    }
    _postEvent(BetterPlayerEvent(
      BetterPlayerEventType.changedResolution,
      parameters: <String, dynamic>{"url": url},
    ));
  }

  ///Set [audioTrack] in player. Works only for HLS or DASH streams.
  void setAudioTrack(BetterPlayerAsmsAudioTrack audioTrack) {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    if (audioTrack.language == null) {
      _betterPlayerAsmsAudioTrack = null;
      return;
    }

    _betterPlayerAsmsAudioTrack = audioTrack;
    videoPlayerController!.setAudioTrack(audioTrack.label, audioTrack.id);
  }

  ///Build headers map that will be used to setup video player controller. Apply
  ///DRM headers if available.
  Map<String, String?> _getHeaders() {
    final headers = betterPlayerDataSource!.headers ?? {};
    if (betterPlayerDataSource?.drmConfiguration?.drmType == BetterPlayerDrmType.token &&
        betterPlayerDataSource?.drmConfiguration?.token != null) {
      headers[_authorizationHeader] = betterPlayerDataSource!.drmConfiguration!.token!;
    }
    return headers;
  }

  bool isVideoFinished() {
    return duration != null && position!.inMilliseconds != 0 && duration!.inMilliseconds != 0 && position! >= duration!;
  }

  void videoInitialized(Size size, Duration duration) {
    this.size = size;
    this.duration = duration;
    notifyListeners();
  }
}
