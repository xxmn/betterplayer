import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:better_player/better_player.dart';
import 'package:better_player/src/configuration/better_player_controller_event.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:better_player/src/subtitles/better_player_subtitle.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_factory.dart';
import 'package:better_player/src/video_player/video_player.dart';
import 'package:better_player/src/video_player/video_player_platform_interface.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///Class used to control overall Better Player behavior. Main class to change
///state of Better Player.
class BPController {
  static const String _durationParameter = "duration";
  static const String _progressParameter = "progress";
  static const String _bufferedParameter = "buffered";
  static const String _volumeParameter = "volume";
  static const String _speedParameter = "speed";
  static const String _dataSourceParameter = "dataSource";
  static const String _authorizationHeader = "Authorization";

  ///General configuration used in controller instance.
  final BPConfiguration betterPlayerConfiguration;

  ///Playlist configuration used in controller instance.
  final BPPlaylistConfiguration? betterPlayerPlaylistConfiguration;

  ///List of event listeners, which listen to events.
  final List<Function(BPEvent)?> _eventListeners = [];

  ///List of files to delete once player disposes.
  final List<File> _tempFiles = [];

  ///Stream controller which emits stream when control visibility changes.
  final StreamController<bool> _controlsVisibilityStreamController = StreamController.broadcast();

  ///Instance of video player controller which is adapter used to communicate
  ///between flutter high level code and lower level native code.
  VideoPlayerController? videoPlayerController;

  ///Controls configuration
  late BPControlsCfg _betterPlayerControlsConfiguration;

  ///Controls configuration
  BPControlsCfg get bpControlsCfg => _betterPlayerControlsConfiguration;

  ///Expose all active eventListeners
  List<Function(BPEvent)?> get eventListeners => _eventListeners.sublist(1);

  /// Defines a event listener where video player events will be send.
  Function(BPEvent)? get eventListener => betterPlayerConfiguration.eventListener;

  ///Flag used to store full screen mode state.
  bool _isFullScreen = false;

  ///Flag used to store full screen mode state.
  bool get isFullScreen => _isFullScreen;

  ///Time when last progress event was sent
  int _lastPositionSelection = 0;

  ///Currently used data source in player.
  BPDataSource? _betterPlayerDataSource;

  ///Currently used data source in player.
  BPDataSource? get betterPlayerDataSource => _betterPlayerDataSource;

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

  ///Timer for next video. Used in playlist.
  Timer? _nextVideoTimer;

  ///Time for next video.
  int? _nextVideoTime;

  ///Stream controller which emits next video time.
  final StreamController<int?> _nextVideoTimeStreamController = StreamController.broadcast();

  Stream<int?> get nextVideoTimeStream => _nextVideoTimeStreamController.stream;

  ///Has player been disposed.
  bool _disposed = false;

  ///Was player playing before automatic pause.
  bool? _wasPlayingBeforePause;

  ///Currently used translations
  BPTranslations translations = BPTranslations();

  ///Has current data source started
  bool _hasCurrentDataSourceStarted = false;

  ///Has current data source initialized
  bool _hasCurrentDataSourceInitialized = false;

  ///Stream which sends flag whenever visibility of controls changes
  Stream<bool> get controlsVisibilityStream => _controlsVisibilityStreamController.stream;

  ///Current app lifecycle state.
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool _controlsEnabled = true;

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool get controlsEnabled => _controlsEnabled;

  ///Overridden aspect ratio which will be used instead of aspect ratio passed
  ///in configuration.
  double? _overriddenAspectRatio;

  ///Overridden fit which will be used instead of fit passed in configuration.
  BoxFit? _overriddenFit;

  ///Was Picture in Picture opened.
  bool _wasInPipMode = false;

  ///Was player in fullscreen before Picture in Picture opened.
  bool _wasInFullScreenBeforePiP = false;

  ///Was controls enabled before Picture in Picture opened.
  bool _wasControlsEnabledBeforePiP = false;

  ///GlobalKey of the BP widget
  GlobalKey? _betterPlayerGlobalKey;

  ///Getter of the GlobalKey
  GlobalKey? get betterPlayerGlobalKey => _betterPlayerGlobalKey;

  ///StreamSubscription for VideoEvent listener
  StreamSubscription<VideoEvent>? _videoEventStreamSubscription;

  ///Are controls always visible
  bool _controlsAlwaysVisible = false;

  ///Are controls always visible
  bool get controlsAlwaysVisible => _controlsAlwaysVisible;

  ///List of all possible audio tracks returned from ASMS stream
  List<BPAsmsAudioTrack>? _betterPlayerAsmsAudioTracks;

  ///List of all possible audio tracks returned from ASMS stream
  List<BPAsmsAudioTrack>? get betterPlayerAsmsAudioTracks => _betterPlayerAsmsAudioTracks;

  ///Selected ASMS audio track
  BPAsmsAudioTrack? _betterPlayerAsmsAudioTrack;

  ///Selected ASMS audio track
  BPAsmsAudioTrack? get betterPlayerAsmsAudioTrack => _betterPlayerAsmsAudioTrack;

  ///Selected videoPlayerValue when error occurred.
  VideoPlayerValue? _videoPlayerValueOnError;

  ///Flag which holds information about player visibility
  bool _isPlayerVisible = true;

  final StreamController<BPControllerEvent> _controllerEventStreamController = StreamController.broadcast();

  ///Stream of internal controller events. Shouldn't be used inside app. For
  ///normal events, use eventListener.
  Stream<BPControllerEvent> get controllerEventStream => _controllerEventStreamController.stream;

  ///Flag which determines whether are ASMS segments loading
  bool _asmsSegmentsLoading = false;

  ///List of loaded ASMS segments
  final List<String> _asmsSegmentsLoaded = [];

  ///Currently displayed [BPSubtitle].
  BPSubtitle? renderedSubtitle;

  BPController(
    this.betterPlayerConfiguration, {
    this.betterPlayerPlaylistConfiguration,
    BPDataSource? betterPlayerDataSource,
  }) {
    this._betterPlayerControlsConfiguration = betterPlayerConfiguration.controlsConfiguration;
    _eventListeners.add(eventListener);
    if (betterPlayerDataSource != null) {
      setupDataSource(betterPlayerDataSource);
    }
  }

  ///Get BPController from context. Used in InheritedWidget.
  static BPController of(BuildContext context) {
    final bpProvider = BPControllerProvider.of(context);
    return bpProvider.controller;
  }

  ///Setup new data source in Better Player.
  Future setupDataSource(BPDataSource betterPlayerDataSource) async {
    postEvent(
      BPEvent(
        BPEventType.setupDataSource,
        parameters: <String, dynamic>{_dataSourceParameter: betterPlayerDataSource},
      ),
    );
    _postControllerEvent(BPControllerEvent.setupDataSource);
    _hasCurrentDataSourceStarted = false;
    _hasCurrentDataSourceInitialized = false;
    _betterPlayerDataSource = betterPlayerDataSource;
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

  ///Configure subtitles based on subtitles source.
  void _setupSubtitles() {
    _betterPlayerSubtitlesSourceList.add(
      BPSubtitlesSource(type: BPSubtitlesSourceType.none),
    );
    final defaultSubtitle =
        _betterPlayerSubtitlesSourceList.firstWhereOrNull((element) => element.selectedByDefault == true);

    ///Setup subtitles (none is default)
    setupSubtitleSource(defaultSubtitle ?? _betterPlayerSubtitlesSourceList.last, sourceInitialize: true);
  }

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
          audioUri: betterPlayerDataSource.audioUrl,
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
          start: _betterPlayerDataSource!.start,
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

        final audioFile = betterPlayerDataSource.audioUrl == null ? null : File(betterPlayerDataSource.audioUrl!);
        if (audioFile != null && !audioFile.existsSync()) {
          BPUtils.log("File ${audioFile.path} doesn't exists. This may be because "
              "you're acessing file from native path and Flutter doesn't "
              "recognize this path.");
        }

        await videoPlayerController?.setFileDataSource(
          // File(betterPlayerDataSource.url),
          file,
          audioFile: audioFile,
          showNotification: _betterPlayerDataSource?.notificationConfiguration?.showNotification,
          title: _betterPlayerDataSource?.notificationConfiguration?.title,
          author: _betterPlayerDataSource?.notificationConfiguration?.author,
          imageUrl: _betterPlayerDataSource?.notificationConfiguration?.imageUrl,
          notificationChannelName: _betterPlayerDataSource?.notificationConfiguration?.notificationChannelName,
          overriddenDuration: _betterPlayerDataSource!.overriddenDuration,
          start: _betterPlayerDataSource!.start,
          activityName: _betterPlayerDataSource?.notificationConfiguration?.activityName,
          clearKey: _betterPlayerDataSource?.drmConfiguration?.clearKey,
        );
        break;
      case BPDataSourceType.memory:
        final file =
            await _createFile(_betterPlayerDataSource!.bytes!, extension: _betterPlayerDataSource!.videoExtension);

        if (file.existsSync()) {
          await videoPlayerController?.setFileDataSource(
            file,
            showNotification: _betterPlayerDataSource?.notificationConfiguration?.showNotification,
            title: _betterPlayerDataSource?.notificationConfiguration?.title,
            author: _betterPlayerDataSource?.notificationConfiguration?.author,
            imageUrl: _betterPlayerDataSource?.notificationConfiguration?.imageUrl,
            notificationChannelName: _betterPlayerDataSource?.notificationConfiguration?.notificationChannelName,
            overriddenDuration: _betterPlayerDataSource!.overriddenDuration,
            start: _betterPlayerDataSource!.start,
            activityName: _betterPlayerDataSource?.notificationConfiguration?.activityName,
            clearKey: _betterPlayerDataSource?.drmConfiguration?.clearKey,
          );
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

  ///Initializes video based on configuration. Invoke actions which need to be
  ///run on player start.
  Future _initializeVideo() async {
    setLooping(betterPlayerConfiguration.looping);
    _videoEventStreamSubscription?.cancel();
    _videoEventStreamSubscription = null;

    _videoEventStreamSubscription = videoPlayerController?.videoEventStreamController.stream.listen(_handleVideoEvent);

    final fullScreenByDefault = betterPlayerConfiguration.fullScreenByDefault;
    if (betterPlayerConfiguration.autoPlay) {
      if (fullScreenByDefault && !isFullScreen) {
        enterFullScreen();
      }
      if (_isAutomaticPlayPauseHandled()) {
        if (_appLifecycleState == AppLifecycleState.resumed && _isPlayerVisible) {
          await play();
        } else {
          _wasPlayingBeforePause = true;
        }
      } else {
        await play();
      }
    } else {
      if (fullScreenByDefault) {
        enterFullScreen();
      }
    }

    final startAt = betterPlayerConfiguration.startAt;
    if (startAt != null) {
      seekTo(startAt);
    }
  }

  ///Method which is invoked when full screen changes.
  Future<void> _onFullScreenStateChanged() async {
    if (videoPlayerController?.value.isPlaying == true && !_isFullScreen) {
      enterFullScreen();
      videoPlayerController?.removeListener(_onFullScreenStateChanged);
    }
  }

  ///Enables full screen mode in player. This will trigger route change.
  void enterFullScreen() {
    _isFullScreen = true;
    _postControllerEvent(BPControllerEvent.openFullscreen);
  }

  ///Disables full screen mode in player. This will trigger route change.
  void exitFullScreen() {
    _isFullScreen = false;
    _postControllerEvent(BPControllerEvent.hideFullscreen);
  }

  ///Enables/disables full screen mode based on current fullscreen state.
  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    if (_isFullScreen) {
      _postControllerEvent(BPControllerEvent.openFullscreen);
    } else {
      _postControllerEvent(BPControllerEvent.hideFullscreen);
    }
  }

  ///Start video playback. Play will be triggered only if current lifecycle state
  ///is resumed.
  Future<void> play() async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    if (_appLifecycleState == AppLifecycleState.resumed) {
      await videoPlayerController!.play();
      _hasCurrentDataSourceStarted = true;
      _wasPlayingBeforePause = null;
      _postEvent(BPEvent(BPEventType.play));
      _postControllerEvent(BPControllerEvent.play);
    }
  }

  ///Enables/disables looping (infinity playback) mode.
  Future<void> setLooping(bool looping) async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    await videoPlayerController!.setLooping(looping);
  }

  ///Stop video playback.
  Future<void> pause() async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    await videoPlayerController!.pause();
    _postEvent(BPEvent(BPEventType.pause));
  }

  ///Stop video playback.
  Future<Uint8List?> screenshot() async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    _postEvent(BPEvent(BPEventType.screenshot));
    return await videoPlayerController!.screenshot();
  }

  ///Move player to specific position/moment of the video.
  Future<void> seekTo(Duration moment) async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    if (videoPlayerController?.value.duration == null) {
      throw StateError("The video has not been initialized yet.");
    }

    await videoPlayerController!.seekTo(moment);

    _postEvent(
      BPEvent(
        BPEventType.seekTo,
        parameters: <String, dynamic>{_durationParameter: moment},
      ),
    );

    final Duration? currentDuration = videoPlayerController!.value.duration;
    if (currentDuration == null) {
      return;
    }
    if (moment > currentDuration) {
      _postEvent(BPEvent(BPEventType.finished));
    } else {
      cancelNextVideoTimer();
    }
  }

  ///Set volume of player. Allows values from 0.0 to 1.0.
  Future<void> setVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      BPUtils.log("Volume must be between 0.0 and 1.0");
      throw ArgumentError("Volume must be between 0.0 and 1.0");
    }
    if (videoPlayerController == null) {
      BPUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    await videoPlayerController!.setVolume(volume);
    _postEvent(BPEvent(
      BPEventType.setVolume,
      parameters: <String, dynamic>{_volumeParameter: volume},
    ));
  }

  ///Set playback speed of video. Allows to set speed value between 0 and 2.
  Future<void> setSpeed(double speed) async {
    if (speed <= 0 || speed > 2) {
      BPUtils.log("Speed must be between 0 and 2");
      throw ArgumentError("Speed must be between 0 and 2");
    }
    if (videoPlayerController == null) {
      BPUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    await videoPlayerController?.setSpeed(speed);
    _postEvent(
      BPEvent(
        BPEventType.setSpeed,
        parameters: <String, dynamic>{
          _speedParameter: speed,
        },
      ),
    );
  }

  ///Flag which determines whenever player is playing or not.
  bool? isPlaying() {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController!.value.isPlaying;
  }

  ///Flag which determines whenever player is loading video data or not.
  bool? isBuffering() {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController!.value.isBuffering;
  }

  ///Show or hide controls manually
  void setControlsVisibility(bool isVisible) {
    _controlsVisibilityStreamController.add(isVisible);
  }

  ///Enable/disable controls (when enabled = false, controls will be always hidden)
  void setControlsEnabled(bool enabled) {
    if (!enabled) {
      _controlsVisibilityStreamController.add(false);
    }
    _controlsEnabled = enabled;
  }

  ///Internal method, used to trigger CONTROLS_VISIBLE or CONTROLS_HIDDEN event
  ///once controls state changed.
  void toggleControlsVisibility(bool isVisible) {
    _postEvent(isVisible ? BPEvent(BPEventType.controlsVisible) : BPEvent(BPEventType.controlsHiddenEnd));
  }

  ///Send player event. Shouldn't be used manually.
  void postEvent(BPEvent betterPlayerEvent) {
    _postEvent(betterPlayerEvent);
  }

  ///Send player event to all listeners.
  void _postEvent(BPEvent betterPlayerEvent) {
    for (final Function(BPEvent)? eventListener in _eventListeners) {
      if (eventListener != null) {
        eventListener(betterPlayerEvent);
      }
    }
  }

  ///Listener used to handle video player changes.
  void _onVideoPlayerChanged() async {
    final VideoPlayerValue currentVideoPlayerValue =
        videoPlayerController?.value ?? VideoPlayerValue(duration: const Duration());

    if (currentVideoPlayerValue.hasError) {
      _videoPlayerValueOnError ??= currentVideoPlayerValue;
      _postEvent(
        BPEvent(
          BPEventType.exception,
          parameters: <String, dynamic>{"exception": currentVideoPlayerValue.errorDescription},
        ),
      );
    }
    if (currentVideoPlayerValue.initialized && !_hasCurrentDataSourceInitialized) {
      _hasCurrentDataSourceInitialized = true;
      _postEvent(BPEvent(BPEventType.initialized));
    }
    if (currentVideoPlayerValue.isPip) {
      _wasInPipMode = true;
    } else if (_wasInPipMode) {
      _postEvent(BPEvent(BPEventType.pipStop));
      _wasInPipMode = false;
      if (!_wasInFullScreenBeforePiP) {
        exitFullScreen();
      }
      if (_wasControlsEnabledBeforePiP) {
        setControlsEnabled(true);
      }
      videoPlayerController?.refresh();
    }

    if (_betterPlayerSubtitlesSource?.asmsIsSegmented == true) {
      _loadAsmsSubtitlesSegments(currentVideoPlayerValue.position);
    }

    final int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastPositionSelection > 500) {
      _lastPositionSelection = now;
      _postEvent(
        BPEvent(
          BPEventType.progress,
          parameters: <String, dynamic>{
            _progressParameter: currentVideoPlayerValue.position,
            _durationParameter: currentVideoPlayerValue.duration
          },
        ),
      );
    }
  }

  ///Add event listener which listens to player events.
  void addEventsListener(Function(BPEvent) eventListener) {
    _eventListeners.add(eventListener);
  }

  ///Remove event listener. This method should be called once you're disposing
  ///Better Player.
  void removeEventsListener(Function(BPEvent) eventListener) {
    _eventListeners.remove(eventListener);
  }

  ///Flag which determines whenever player is playing live data source.
  bool isLiveStream() {
    if (_betterPlayerDataSource == null) {
      BPUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    return _betterPlayerDataSource!.liveStream == true;
  }

  ///Flag which determines whenever player data source has been initialized.
  bool? isVideoInitialized() {
    if (videoPlayerController == null) {
      BPUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController?.value.initialized;
  }

  ///Start timer which will trigger next video. Used in playlist. Do not use
  ///manually.
  void startNextVideoTimer() {
    if (_nextVideoTimer == null) {
      if (betterPlayerPlaylistConfiguration == null) {
        BPUtils.log("BettterPlayerPlaylistConifugration has not been set!");
        throw StateError("BettterPlayerPlaylistConifugration has not been set!");
      }

      _nextVideoTime = betterPlayerPlaylistConfiguration!.nextVideoDelay.inSeconds;
      _nextVideoTimeStreamController.add(_nextVideoTime);
      if (_nextVideoTime == 0) {
        return;
      }

      _nextVideoTimer = Timer.periodic(const Duration(milliseconds: 1000), (_timer) async {
        if (_nextVideoTime == 1) {
          _timer.cancel();
          _nextVideoTimer = null;
        }
        if (_nextVideoTime != null) {
          _nextVideoTime = _nextVideoTime! - 1;
        }
        _nextVideoTimeStreamController.add(_nextVideoTime);
      });
    }
  }

  ///Cancel next video timer. Used in playlist. Do not use manually.
  void cancelNextVideoTimer() {
    _nextVideoTime = null;
    _nextVideoTimeStreamController.add(_nextVideoTime);
    _nextVideoTimer?.cancel();
    _nextVideoTimer = null;
  }

  ///Play next video form playlist. Do not use manually.
  void playNextVideo() {
    _nextVideoTime = 0;
    _nextVideoTimeStreamController.add(_nextVideoTime);
    _postEvent(BPEvent(BPEventType.changedPlaylistItem));
    cancelNextVideoTimer();
  }

  ///Setup track parameters for currently played video. Can be only used for HLS or DASH
  ///data source.
  void setTrack(BPAsmsTrack track) {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    _postEvent(BPEvent(BPEventType.changedTrack, parameters: <String, dynamic>{
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

  ///Check if player can be played/paused automatically
  bool _isAutomaticPlayPauseHandled() {
    return !(_betterPlayerDataSource?.notificationConfiguration?.showNotification == true) &&
        betterPlayerConfiguration.handleLifecycle;
  }

  ///Listener which handles state of player visibility. If player visibility is
  ///below 0.0 then video will be paused. When value is greater than 0, video
  ///will play again. If there's different handler of visibility then it will be
  ///used. If showNotification is set in data source or handleLifecycle is false
  /// then this logic will be ignored.
  void onPlayerVisibilityChanged(double visibilityFraction) async {
    _isPlayerVisible = visibilityFraction > 0;
    if (_disposed) {
      return;
    }
    _postEvent(BPEvent(BPEventType.changedPlayerVisibility));

    if (_isAutomaticPlayPauseHandled()) {
      if (betterPlayerConfiguration.playerVisibilityChangedBehavior != null) {
        betterPlayerConfiguration.playerVisibilityChangedBehavior!(visibilityFraction);
      } else {
        if (visibilityFraction == 0) {
          _wasPlayingBeforePause ??= isPlaying();
          pause();
        } else {
          if (_wasPlayingBeforePause == true && !isPlaying()!) {
            play();
          }
        }
      }
    }
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
    _postEvent(BPEvent(
      BPEventType.changedResolution,
      parameters: <String, dynamic>{"url": url},
    ));
  }

  ///Setup translations for given locale. In normal use cases it shouldn't be
  ///called manually.
  void setupTranslations(Locale locale) {
    // ignore: unnecessary_null_comparison
    if (locale != null) {
      final String languageCode = locale.languageCode;
      translations = betterPlayerConfiguration.translations
              ?.firstWhereOrNull((translations) => translations.languageCode == languageCode) ??
          _getDefaultTranslations(locale);
    } else {
      BPUtils.log("Locale is null. Couldn't setup translations.");
    }
  }

  ///Setup default translations for selected user locale. These translations
  ///are pre-build in.
  BPTranslations _getDefaultTranslations(Locale locale) {
    final String languageCode = locale.languageCode;
    switch (languageCode) {
      case "pl":
        return BPTranslations.polish();
      case "zh":
        return BPTranslations.chinese();
      case "hi":
        return BPTranslations.hindi();
      case "tr":
        return BPTranslations.turkish();
      case "vi":
        return BPTranslations.vietnamese();
      case "es":
        return BPTranslations.spanish();
      default:
        return BPTranslations();
    }
  }

  ///Flag which determines whenever current data source has started.
  bool get hasCurrentDataSourceStarted => _hasCurrentDataSourceStarted;

  ///Set current lifecycle state. If state is [AppLifecycleState.resumed] then
  ///player starts playing again. if lifecycle is in [AppLifecycleState.paused]
  ///state, then video playback will stop. If showNotification is set in data
  ///source or handleLifecycle is false then this logic will be ignored.
  void setAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (_isAutomaticPlayPauseHandled()) {
      _appLifecycleState = appLifecycleState;
      if (appLifecycleState == AppLifecycleState.resumed) {
        if (_wasPlayingBeforePause == true && _isPlayerVisible) {
          play();
        }
      }
      if (appLifecycleState == AppLifecycleState.paused) {
        _wasPlayingBeforePause ??= isPlaying();
        pause();
      }
    }
  }

  // ignore: use_setters_to_change_properties
  ///Setup overridden aspect ratio.
  void setOverriddenAspectRatio(double aspectRatio) {
    _overriddenAspectRatio = aspectRatio;
  }

  ///Get aspect ratio used in current video. If aspect ratio is null, then
  ///aspect ratio from BPConfiguration will be used. Otherwise
  ///[_overriddenAspectRatio] will be used.
  double? getAspectRatio() {
    return _overriddenAspectRatio ?? betterPlayerConfiguration.aspectRatio;
  }

  // ignore: use_setters_to_change_properties
  ///Setup overridden fit.
  void setOverriddenFit(BoxFit fit) {
    _overriddenFit = fit;
  }

  ///Get fit used in current video. If fit is null, then fit from
  ///BPConfiguration will be used. Otherwise [_overriddenFit] will be
  ///used.
  BoxFit getFit() {
    return _overriddenFit ?? betterPlayerConfiguration.fit;
  }

  ///Enable Picture in Picture (PiP) mode. [betterPlayerGlobalKey] is required
  ///to open PiP mode in iOS. When device is not supported, PiP mode won't be
  ///open.
  Future<void>? enablePictureInPicture(GlobalKey betterPlayerGlobalKey) async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    final bool isPipSupported = (await videoPlayerController!.isPictureInPictureSupported()) ?? false;

    if (isPipSupported) {
      _wasInFullScreenBeforePiP = _isFullScreen;
      _wasControlsEnabledBeforePiP = _controlsEnabled;
      setControlsEnabled(false);
      if (Platform.isAndroid) {
        _wasInFullScreenBeforePiP = _isFullScreen;
        await videoPlayerController?.enablePictureInPicture(left: 0, top: 0, width: 0, height: 0);
        enterFullScreen();
        _postEvent(BPEvent(BPEventType.pipStart));
        return;
      }
      if (Platform.isIOS) {
        final RenderBox? renderBox = betterPlayerGlobalKey.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox == null) {
          BPUtils.log("Can't show PiP. RenderBox is null. Did you provide valid global"
              " key?");
          return;
        }
        final Offset position = renderBox.localToGlobal(Offset.zero);
        return videoPlayerController?.enablePictureInPicture(
          left: position.dx,
          top: position.dy,
          width: renderBox.size.width,
          height: renderBox.size.height,
        );
      } else {
        BPUtils.log("Unsupported PiP in current platform.");
      }
    } else {
      BPUtils.log("Picture in picture is not supported in this device. If you're "
          "using Android, please check if you're using activity v2 "
          "embedding.");
    }
  }

  ///Disable Picture in Picture mode if it's enabled.
  Future<void>? disablePictureInPicture() {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController!.disablePictureInPicture();
  }

  // ignore: use_setters_to_change_properties
  ///Set GlobalKey of BP. Used in PiP methods called from controls.
  void setBPGlobalKey(GlobalKey betterPlayerGlobalKey) {
    _betterPlayerGlobalKey = betterPlayerGlobalKey;
  }

  ///Check if picture in picture mode is supported in this device.
  Future<bool> isPictureInPictureSupported() async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    final bool isPipSupported = (await videoPlayerController!.isPictureInPictureSupported()) ?? false;

    return isPipSupported && !_isFullScreen;
  }

  ///Handle VideoEvent when remote controls notification / PiP is shown
  void _handleVideoEvent(VideoEvent event) async {
    switch (event.eventType) {
      case VideoEventType.play:
        _postEvent(BPEvent(BPEventType.play));
        break;
      case VideoEventType.pause:
        _postEvent(BPEvent(BPEventType.pause));
        break;
      case VideoEventType.seek:
        _postEvent(BPEvent(BPEventType.seekTo));
        break;
      case VideoEventType.completed:
        final VideoPlayerValue? videoValue = videoPlayerController?.value;
        _postEvent(
          BPEvent(
            BPEventType.finished,
            parameters: <String, dynamic>{
              _progressParameter: videoValue?.position,
              _durationParameter: videoValue?.duration
            },
          ),
        );
        break;
      case VideoEventType.bufferingStart:
        _postEvent(BPEvent(BPEventType.bufferingStart));
        break;
      case VideoEventType.bufferingUpdate:
        _postEvent(BPEvent(BPEventType.bufferingUpdate, parameters: <String, dynamic>{
          _bufferedParameter: event.buffered,
        }));
        break;
      case VideoEventType.bufferingEnd:
        _postEvent(BPEvent(BPEventType.bufferingEnd));
        break;
      default:

        ///TODO: Handle when needed
        break;
    }
  }

  ///Setup controls always visible mode
  void setControlsAlwaysVisible(bool controlsAlwaysVisible) {
    _controlsAlwaysVisible = controlsAlwaysVisible;
    _controlsVisibilityStreamController.add(controlsAlwaysVisible);
  }

  ///Retry data source if playback failed.
  Future retryDataSource() async {
    await _setupDataSource(_betterPlayerDataSource!);
    if (_videoPlayerValueOnError != null) {
      final position = _videoPlayerValueOnError!.position;
      await seekTo(position);
      await play();
      _videoPlayerValueOnError = null;
    }
  }

  ///Set [audioTrack] in player. Works only for HLS or DASH streams.
  void setAudioTrack(BPAsmsAudioTrack audioTrack) {
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

  ///Enable or disable audio mixing with other sound within device.
  void setMixWithOthers(bool mixWithOthers) {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    videoPlayerController!.setMixWithOthers(mixWithOthers);
  }

  ///Clear all cached data. Video player controller must be initialized to
  ///clear the cache.
  Future<void> clearCache() async {
    return VideoPlayerController.clearCache();
  }

  ///Build headers map that will be used to setup video player controller. Apply
  ///DRM headers if available.
  Map<String, String?> _getHeaders() {
    final headers = betterPlayerDataSource!.headers ?? {};
    if (betterPlayerDataSource?.drmConfiguration?.drmType == BPDrmType.token &&
        betterPlayerDataSource?.drmConfiguration?.token != null) {
      headers[_authorizationHeader] = betterPlayerDataSource!.drmConfiguration!.token!;
    }
    return headers;
  }

  ///PreCache a video. On Android, the future succeeds when
  ///the requested size, specified in
  ///[BPCacheCfg.preCacheSize], is downloaded or when the
  ///complete file is downloaded if the file is smaller than the requested size.
  ///On iOS, the whole file will be downloaded, since [maxCacheFileSize] is
  ///currently not supported on iOS. On iOS, the video format must be in this
  ///list: https://github.com/sendyhalim/Swime/blob/master/Sources/MimeType.swift
  Future<void> preCache(BPDataSource betterPlayerDataSource) async {
    final cacheConfig = betterPlayerDataSource.cacheConfiguration ?? const BPCacheCfg(useCache: true);

    final dataSource = DataSource(
      sourceType: DataSourceType.network,
      uri: betterPlayerDataSource.url,
      useCache: true,
      headers: betterPlayerDataSource.headers,
      maxCacheSize: cacheConfig.maxCacheSize,
      maxCacheFileSize: cacheConfig.maxCacheFileSize,
      cacheKey: cacheConfig.key,
      videoExtension: betterPlayerDataSource.videoExtension,
    );

    return VideoPlayerController.preCache(dataSource, cacheConfig.preCacheSize);
  }

  ///Stop pre cache for given [betterPlayerDataSource]. If there was no pre
  ///cache started for given [betterPlayerDataSource] then it will be ignored.
  Future<void> stopPreCache(BPDataSource betterPlayerDataSource) async {
    return VideoPlayerController?.stopPreCache(
        betterPlayerDataSource.url, betterPlayerDataSource.cacheConfiguration?.key);
  }

  /// Sets the new [bpControlsCfg] instance in the
  /// controller.
  void setBPControlsConfiguration(BPControlsCfg bpControlsCfg) {
    this._betterPlayerControlsConfiguration = bpControlsCfg;
  }

  /// Add controller internal event.
  void _postControllerEvent(BPControllerEvent event) {
    if (!_controllerEventStreamController.isClosed) {
      _controllerEventStreamController.add(event);
    }
  }

  ///Dispose BPController. When [forceDispose] parameter is true, then
  ///autoDispose parameter will be overridden and controller will be disposed
  ///(if it wasn't disposed before).
  void dispose({bool forceDispose = false}) {
    if (!betterPlayerConfiguration.autoDispose && !forceDispose) {
      return;
    }
    if (!_disposed) {
      if (videoPlayerController != null) {
        pause();
        videoPlayerController!.removeListener(_onFullScreenStateChanged);
        videoPlayerController!.removeListener(_onVideoPlayerChanged);
        videoPlayerController!.dispose();
      }
      _eventListeners.clear();
      _nextVideoTimer?.cancel();
      _nextVideoTimeStreamController.close();
      _controlsVisibilityStreamController.close();
      _videoEventStreamSubscription?.cancel();
      _disposed = true;
      _controllerEventStreamController.close();

      ///Delete files async
      _tempFiles.forEach((file) => file.delete());
    }
  }
}
