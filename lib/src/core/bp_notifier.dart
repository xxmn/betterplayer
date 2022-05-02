import 'package:better_player/src/configuration/bp_configuration.dart';
import 'package:better_player/src/core/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPNotifier with ChangeNotifier {
  BPNotifier() {}

  BPConfiguration bpConfiguration = BPConfiguration();

  ///Was player playing before automatic pause.
  bool? _wasPlayingBeforePause;

  ///Flag which holds information about player visibility
  bool _isPlayerVisible = true;

  ///Has player been disposed.
  bool _disposed = false;

  ///Overridden aspect ratio which will be used instead of aspect ratio passed
  ///in configuration.
  double? _overriddenAspectRatio;

  // ignore: use_setters_to_change_properties
  ///Setup overridden aspect ratio.
  void setOverriddenAspectRatio(double aspectRatio) {
    _overriddenAspectRatio = aspectRatio;
  }

  ///Get aspect ratio used in current video. If aspect ratio is null, then
  ///aspect ratio from BetterPlayerConfiguration will be used. Otherwise
  ///[_overriddenAspectRatio] will be used.
  double? getAspectRatio() {
    return _overriddenAspectRatio ?? betterPlayerConfiguration.aspectRatio;
  }

  /// The Aspect Ratio of the Video. Important to get the correct size of the
  /// video!
  ///
  /// Will fallback to fitting within the space allowed.
  double? aspectRatio;

  /// Defines aspect ratio which will be used in fullscreen
  double? fullScreenAspectRatio;

  ///Overridden fit which will be used instead of fit passed in configuration.
  BoxFit? _overriddenFit;

  // ignore: use_setters_to_change_properties
  ///Setup overridden fit.
  void setOverriddenFit(BoxFit fit) {
    _overriddenFit = fit;
  }

  ///Get fit used in current video. If fit is null, then fit from
  ///BetterPlayerConfiguration will be used. Otherwise [_overriddenFit] will be
  ///used.
  BoxFit getFit() {
    return _overriddenFit ?? betterPlayerConfiguration.fit;
  }

  ///Is in Picture in Picture Mode
  bool isPip;

  ///Was Picture in Picture opened.
  bool _wasInPipMode = false;

  ///Was player in fullscreen before Picture in Picture opened.
  bool _wasInFullScreenBeforePiP = false;

  ///Was controls enabled before Picture in Picture opened.
  bool _wasControlsEnabledBeforePiP = false;

  ///GlobalKey of the BetterPlayer widget
  GlobalKey? _betterPlayerGlobalKey;

  ///Getter of the GlobalKey
  GlobalKey? get betterPlayerGlobalKey => _betterPlayerGlobalKey;
  // ignore: use_setters_to_change_properties
  ///Set GlobalKey of BetterPlayer. Used in PiP methods called from controls.
  void setBetterPlayerGlobalKey(GlobalKey betterPlayerGlobalKey) {
    _betterPlayerGlobalKey = betterPlayerGlobalKey;
  }

  ///Check if player can be played/paused automatically
  bool _isAutomaticPlayPauseHandled() {
    return !(_betterPlayerDataSource?.notificationConfiguration?.showNotification == true) &&
        betterPlayerConfiguration.handleLifecycle;
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
      // _postEvent(BetterPlayerEvent(BetterPlayerEventType.play));
      // _postControllerEvent(BetterPlayerControllerEvent.play);
    }
  }

  ///Setup new data source in Better Player.
  Future setupDataSource(BetterPlayerDataSource betterPlayerDataSource) async {
    postEvent(BetterPlayerEvent(BetterPlayerEventType.setupDataSource, parameters: <String, dynamic>{
      _dataSourceParameter: betterPlayerDataSource,
    }));
    _postControllerEvent(BetterPlayerControllerEvent.setupDataSource);
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
    final List<BetterPlayerSubtitlesSource>? betterPlayerSubtitlesSourceList = betterPlayerDataSource.subtitles;
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
    setTrack(BetterPlayerAsmsTrack.defaultTrack());
  }

  ///Internal method which invokes videoPlayerController source setup.
  Future _setupDataSource(BetterPlayerDataSource betterPlayerDataSource) async {
    switch (betterPlayerDataSource.type) {
      case BetterPlayerDataSourceType.network:
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
      case BetterPlayerDataSourceType.file:
        final file = File(betterPlayerDataSource.url);
        if (!file.existsSync()) {
          BetterPlayerUtils.log("File ${file.path} doesn't exists. This may be because "
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
      case BetterPlayerDataSourceType.memory:
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
    _postControllerEvent(BetterPlayerControllerEvent.openFullscreen);
  }

  ///Disables full screen mode in player. This will trigger route change.
  void exitFullScreen() {
    _isFullScreen = false;
    _postControllerEvent(BetterPlayerControllerEvent.hideFullscreen);
  }

  ///Enables/disables full screen mode based on current fullscreen state.
  void toggleFullScreen() {
    _isFullScreen = !_isFullScreen;
    if (_isFullScreen) {
      _postControllerEvent(BetterPlayerControllerEvent.openFullscreen);
    } else {
      _postControllerEvent(BetterPlayerControllerEvent.hideFullscreen);
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
      _postEvent(BetterPlayerEvent(BetterPlayerEventType.play));
      _postControllerEvent(BetterPlayerControllerEvent.play);
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
    _postEvent(BetterPlayerEvent(BetterPlayerEventType.pause));
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
        BetterPlayerEvent(BetterPlayerEventType.seekTo, parameters: <String, dynamic>{_durationParameter: moment}));

    final Duration? currentDuration = videoPlayerController!.value.duration;
    if (currentDuration == null) {
      return;
    }
    if (moment > currentDuration) {
      _postEvent(BetterPlayerEvent(BetterPlayerEventType.finished));
    } else {
      cancelNextVideoTimer();
    }
  }

  ///Set volume of player. Allows values from 0.0 to 1.0.
  Future<void> setVolume(double volume) async {
    if (volume < 0.0 || volume > 1.0) {
      BetterPlayerUtils.log("Volume must be between 0.0 and 1.0");
      throw ArgumentError("Volume must be between 0.0 and 1.0");
    }
    if (videoPlayerController == null) {
      BetterPlayerUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    await videoPlayerController!.setVolume(volume);
    _postEvent(BetterPlayerEvent(
      BetterPlayerEventType.setVolume,
      parameters: <String, dynamic>{_volumeParameter: volume},
    ));
  }

  ///Set playback speed of video. Allows to set speed value between 0 and 2.
  Future<void> setSpeed(double speed) async {
    if (speed <= 0 || speed > 2) {
      BetterPlayerUtils.log("Speed must be between 0 and 2");
      throw ArgumentError("Speed must be between 0 and 2");
    }
    if (videoPlayerController == null) {
      BetterPlayerUtils.log("The data source has not been initialized");
      throw StateError("The data source has not been initialized");
    }
    await videoPlayerController?.setSpeed(speed);
    _postEvent(
      BetterPlayerEvent(
        BetterPlayerEventType.setSpeed,
        parameters: <String, dynamic>{
          _speedParameter: speed,
        },
      ),
    );
  }

  ///Listener used to handle video player changes.
  void _onVideoPlayerChanged() async {
    final VideoPlayerValue currentVideoPlayerValue =
        videoPlayerController?.value ?? VideoPlayerValue(duration: const Duration());

    if (currentVideoPlayerValue.hasError) {
      _videoPlayerValueOnError ??= currentVideoPlayerValue;
      _postEvent(
        BetterPlayerEvent(
          BetterPlayerEventType.exception,
          parameters: <String, dynamic>{"exception": currentVideoPlayerValue.errorDescription},
        ),
      );
    }
    if (currentVideoPlayerValue.initialized && !_hasCurrentDataSourceInitialized) {
      _hasCurrentDataSourceInitialized = true;
      _postEvent(BetterPlayerEvent(BetterPlayerEventType.initialized));
    }
    if (currentVideoPlayerValue.isPip) {
      _wasInPipMode = true;
    } else if (_wasInPipMode) {
      _postEvent(BetterPlayerEvent(BetterPlayerEventType.pipStop));
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
        BetterPlayerEvent(
          BetterPlayerEventType.progress,
          parameters: <String, dynamic>{
            _progressParameter: currentVideoPlayerValue.position,
            _durationParameter: currentVideoPlayerValue.duration
          },
        ),
      );
    }
  }

  ///Start timer which will trigger next video. Used in playlist. Do not use
  ///manually.
  void startNextVideoTimer() {
    if (_nextVideoTimer == null) {
      if (betterPlayerPlaylistConfiguration == null) {
        BetterPlayerUtils.log("BettterPlayerPlaylistConifugration has not been set!");
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
    _postEvent(BetterPlayerEvent(BetterPlayerEventType.changedPlaylistItem));
    cancelNextVideoTimer();
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
    // _postEvent(BetterPlayerEvent(BetterPlayerEventType.changedPlayerVisibility));

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

  ///Check if picture in picture mode is supported in this device.
  Future<bool> isPictureInPictureSupported() async {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }

    final bool isPipSupported = (await videoPlayerController!.isPictureInPictureSupported()) ?? false;

    return isPipSupported && !_isFullScreen;
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
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.pipStart));
        return;
      }
      if (Platform.isIOS) {
        final RenderBox? renderBox = betterPlayerGlobalKey.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox == null) {
          BetterPlayerUtils.log("Can't show PiP. RenderBox is null. Did you provide valid global"
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
        BetterPlayerUtils.log("Unsupported PiP in current platform.");
      }
    } else {
      BetterPlayerUtils.log("Picture in picture is not supported in this device. If you're "
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

  ///Dispose BetterPlayerController. When [forceDispose] parameter is true, then
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
