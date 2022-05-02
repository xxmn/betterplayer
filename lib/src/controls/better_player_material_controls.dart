import 'dart:async';
import 'package:better_player/src/configuration/better_player_controls_configuration.dart';
import 'package:better_player/src/controls/better_player_clickable_widget.dart';
import 'package:better_player/src/controls/better_player_controls_state.dart';
import 'package:better_player/src/controls/better_player_material_progress_bar.dart';
import 'package:better_player/src/controls/better_player_multiple_gesture_detector.dart';
import 'package:better_player/src/controls/better_player_progress_colors.dart';
import 'package:better_player/src/controls/better_player_mydrag.dart';
import 'package:better_player/src/core/controller.dart';
import 'package:better_player/src/utils/better_player_utils.dart';
import 'package:better_player/src/video_player/native_player_controller.dart';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BPMaterialControls extends StatefulWidget {
  ///Callback used to send information if player bar is hidden or not
  final Function(bool visbility) onControlsVisibilityChanged;

  ///Controls config
  final BPControlsCfg controlsCfg;

  const BPMaterialControls({
    Key? key,
    required this.onControlsVisibilityChanged,
    required this.controlsCfg,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BPMaterialControlsState();
  }
}

class _BPMaterialControlsState extends BPControlsState<BPMaterialControls> {
  VideoPlayerValue? _latestValue;
  double? _latestVolume;
  Timer? _hideTimer;
  Timer? _initTimer;
  Timer? _showAfterExpandCollapseTimer;
  bool _displayTapped = false;
  bool _wasLoading = false;
  VideoPlayerController? _controller;
  BPController? _bpController;
  StreamSubscription? _controlsVisibilityStreamSubscription;

  BPControlsCfg get _controlsCfg => widget.controlsCfg;

  @override
  VideoPlayerValue? get latestValue => _latestValue;

  @override
  BPController? get bpController => _bpController;

  @override
  BPControlsCfg get bpControlsCfg => _controlsCfg;

  @override
  Widget build(BuildContext context) {
    return buildLTRDirectionality(_buildMainWidget());
  }

  ///Builds main widget of the controls.
  Widget _buildMainWidget() {
    _wasLoading = isLoading(_latestValue);
    if (_latestValue?.hasError == true) {
      return Container(
        color: Colors.black,
        child: _buildErrorWidget(),
      );
    }
    var myDrag = MyDrag(bpController: _bpController, size: MediaQuery.of(context).size, isLocked: isLocked);

    return GestureDetector(
      onTap: () {
        if (BPMultipleGestureDetector.of(context) != null) {
          BPMultipleGestureDetector.of(context)!.onTap?.call();
        }
        controlsNotVisible ? cancelAndRestartTimer() : changePlayerControlsNotVisible(true);
      },
      onDoubleTap: () {
        if (BPMultipleGestureDetector.of(context) != null) {
          BPMultipleGestureDetector.of(context)!.onDoubleTap?.call();
        }
        cancelAndRestartTimer();
      },
      onLongPress: () {
        if (BPMultipleGestureDetector.of(context) != null) {
          BPMultipleGestureDetector.of(context)!.onLongPress?.call();
        }
      },
      onVerticalDragStart: myDrag.onVerticalStart,
      onVerticalDragUpdate: myDrag.onVerticalUpdate,
      onVerticalDragEnd: myDrag.onVerticalEnd,
      child: AbsorbPointer(
        absorbing: controlsNotVisible,
        child: isLocked ? _lockedPage() : _playerControls(),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _controller?.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    _showAfterExpandCollapseTimer?.cancel();
    _controlsVisibilityStreamSubscription?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = _bpController;
    _bpController = BPController.of(context);
    _controller = _bpController!.videoPlayerController;
    _latestValue = _controller!.value;

    if (_oldController != _bpController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  Widget _lockedPage() {
    return Container(
      child: Center(
        child: AnimatedOpacity(
          opacity: controlsNotVisible ? 0.0 : 0.7,
          duration: _controlsCfg.lockedHideTime,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.black54,
              ),
              child: _buildHitAreaClickableButton(
                onClicked: () {
                  setLocked(false);
                  cancelAndRestartTimer();
                },
                icon: Icon(
                  Icons.lock_open_rounded,
                  size: 24,
                  color: _controlsCfg.iconsColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playerControls() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_wasLoading) Center(child: _buildLoadingWidget()) else _buildHitArea(),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildTopBar(),
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
        _buildNextVideoWidget(),
      ],
    );
  }

  Widget _buildErrorWidget() {
    final errorBuilder = _bpController!.bpCfg.errorBuilder;
    if (errorBuilder != null) {
      return errorBuilder(context, _bpController!.videoPlayerController!.value.errorDescription);
    } else {
      final textStyle = TextStyle(color: _controlsCfg.textColor);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: _controlsCfg.iconsColor,
              size: 42,
            ),
            Text(
              _bpController!.translations.generalDefaultError,
              style: textStyle,
            ),
            if (_controlsCfg.enableRetry)
              TextButton(
                onPressed: () {
                  _bpController!.retryDataSource();
                },
                child: Text(
                  _bpController!.translations.generalRetry,
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
      );
    }
  }

  Widget _buildTopBar() {
    if (!bpController!.controlsEnabled) {
      return const SizedBox();
    }
    return Container(
      child: (_controlsCfg.enableOverflowMenu)
          ? AnimatedOpacity(
              opacity: controlsNotVisible ? 0.0 : 1.0,
              duration: _controlsCfg.controlsHideTime,
              onEnd: () => _onPlayerHide("_buildTopBar->AnimatedOpacity->onEnd"),
              child: Container(
                height: _controlsCfg.controlBarHeight,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_controlsCfg.enablePip)
                      _buildPipButtonWrapperWidget(
                        controlsNotVisible,
                        () => _onPlayerHide("_buildPipButtonWrapperWidget onPlayerHide"),
                      )
                    else
                      const SizedBox(),
                    _buildMoreButton(),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildPipButton() {
    return BPMaterialClickableWidget(
      onTap: () {
        bpController!.enablePictureInPicture(bpController!.bpGlobalKey!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          bpControlsCfg.pipMenuIcon,
          color: bpControlsCfg.iconsColor,
        ),
      ),
    );
  }

  Widget _buildPipButtonWrapperWidget(bool hideStuff, void Function() onPlayerHide) {
    return FutureBuilder<bool>(
      future: bpController!.isPictureInPictureSupported(),
      builder: (context, snapshot) {
        final bool isPipSupported = snapshot.data ?? false;
        if (isPipSupported && _bpController!.bpGlobalKey != null) {
          return AnimatedOpacity(
            opacity: hideStuff ? 0.0 : 1.0,
            duration: bpControlsCfg.controlsHideTime,
            onEnd: onPlayerHide,
            child: Container(
              height: bpControlsCfg.controlBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildPipButton(),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildMoreButton() {
    return BPMaterialClickableWidget(
      onTap: () {
        onShowMoreClicked();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          _controlsCfg.overflowMenuIcon,
          color: _controlsCfg.iconsColor,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    if (!bpController!.controlsEnabled) {
      return const SizedBox();
    }
    return AnimatedOpacity(
      opacity: controlsNotVisible ? 0.0 : 1.0,
      duration: _controlsCfg.controlsHideTime,
      onEnd: () => _onPlayerHide("_buildBottomBar->AnimatedOpacity->onEnd"),
      child: Container(
        height: _controlsCfg.controlBarHeight + 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 75,
              // child: Container(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (_controlsCfg.enablePlayPause) _buildPlayPause(_controller!) else const SizedBox(),
                  if (_bpController!.isLiveStream())
                    _buildLiveWidget()
                  else
                    _controlsCfg.enableProgressText ? _buildPosition() : const SizedBox(width: 1),
                  _buildSectionTitle(),
                  const Spacer(),
                  // if (_controlsCfg.enableMute) _buildMuteButton(_controller) else const SizedBox(),
                  if (_controlsCfg.enableFullscreen) _buildExpandButton() else const SizedBox(),
                ],
              ),
            ),
            if (_bpController!.isLiveStream())
              const SizedBox()
            else
              _controlsCfg.enableProgressBar ? _buildProgressBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveWidget() {
    return Text(
      _bpController!.translations.controlsLive,
      style: TextStyle(color: _controlsCfg.liveTextColor, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildExpandButton() {
    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: BPMaterialClickableWidget(
        onTap: _onExpandCollapse,
        child: AnimatedOpacity(
          opacity: controlsNotVisible ? 0.0 : 1.0,
          duration: _controlsCfg.controlsHideTime,
          child: Container(
            height: _controlsCfg.controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Icon(
                _bpController!.isFullScreen ? _controlsCfg.fullscreenDisableIcon : _controlsCfg.fullscreenEnableIcon,
                color: _controlsCfg.iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHitArea() {
    if (!bpController!.controlsEnabled) {
      return const SizedBox();
    }
    return Container(
      child: Center(
        child: AnimatedOpacity(
          opacity: controlsNotVisible ? 0.0 : 1.0,
          duration: _controlsCfg.controlsHideTime,
          child: _buildMiddleRow(),
        ),
      ),
    );
  }

  Widget _buildMiddleRow() {
    return Container(
      color: _controlsCfg.controlBarColor,
      width: double.infinity,
      height: double.infinity,
      child: _bpController?.isLiveStream() == true
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildHitAreaClickableButton(
                    icon: Icon(
                      Icons.lock_rounded,
                      size: 24,
                      color: _controlsCfg.iconsColor,
                    ),
                    onClicked: () {
                      setLocked(true);
                    },
                  ),
                ),
                if (_controlsCfg.enableSkips) Expanded(child: _buildSkipButton()) else const SizedBox(),
                Expanded(child: _buildReplayButton(_controller!)),
                if (_controlsCfg.enableSkips) Expanded(child: _buildForwardButton()) else const SizedBox(),
              ],
            ),
    );
  }

  Widget _buildHitAreaClickableButton({Widget? icon, required void Function() onClicked}) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
      child: BPMaterialClickableWidget(
        onTap: onClicked,
        child: Align(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(48),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [icon!],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return _buildHitAreaClickableButton(
      icon: Icon(
        _controlsCfg.skipBackIcon,
        size: 24,
        color: _controlsCfg.iconsColor,
      ),
      onClicked: skipBack,
    );
  }

  Widget _buildForwardButton() {
    return _buildHitAreaClickableButton(
      icon: Icon(
        _controlsCfg.skipForwardIcon,
        size: 24,
        color: _controlsCfg.iconsColor,
      ),
      onClicked: skipForward,
    );
  }

  Widget _buildReplayButton(VideoPlayerController controller) {
    final bool isFinished = isVideoFinished(_latestValue);
    return _buildHitAreaClickableButton(
      icon: isFinished
          ? Icon(
              Icons.replay,
              size: 42,
              color: _controlsCfg.iconsColor,
            )
          : Icon(
              controller.value.isPlaying ? _controlsCfg.pauseIcon : _controlsCfg.playIcon,
              size: 42,
              color: _controlsCfg.iconsColor,
            ),
      onClicked: () {
        if (isFinished) {
          if (_latestValue != null && _latestValue!.isPlaying) {
            if (_displayTapped) {
              changePlayerControlsNotVisible(true);
            } else {
              cancelAndRestartTimer();
            }
          } else {
            _onPlayPause();
            changePlayerControlsNotVisible(true);
          }
        } else {
          _onPlayPause();
        }
      },
    );
  }

  Widget _buildNextVideoWidget() {
    return StreamBuilder<int?>(
      stream: _bpController!.nextVideoTimeStream,
      builder: (context, snapshot) {
        final time = snapshot.data;
        if (time != null && time > 0) {
          return BPMaterialClickableWidget(
            onTap: () {
              _bpController!.playNextVideo();
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(bottom: _controlsCfg.controlBarHeight + 20, right: 24),
                decoration: BoxDecoration(
                  color: _controlsCfg.controlBarColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "${_bpController!.translations.controlsNextVideoIn} $time...",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildMuteButton(
    VideoPlayerController? controller,
  ) {
    return BPMaterialClickableWidget(
      onTap: () {
        cancelAndRestartTimer();
        if (_latestValue!.volume == 0) {
          _bpController!.setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = controller!.value.volume;
          _bpController!.setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: controlsNotVisible ? 0.0 : 1.0,
        duration: _controlsCfg.controlsHideTime,
        child: ClipRect(
          child: Container(
            height: _controlsCfg.controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              (_latestValue != null && _latestValue!.volume > 0) ? _controlsCfg.muteIcon : _controlsCfg.unMuteIcon,
              color: _controlsCfg.iconsColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayPause(VideoPlayerController controller) {
    return BPMaterialClickableWidget(
      key: const Key("better_player_material_controls_play_pause_button"),
      onTap: _onPlayPause,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(
          controller.value.isPlaying ? _controlsCfg.pauseIcon : _controlsCfg.playIcon,
          color: _controlsCfg.iconsColor,
        ),
      ),
    );
  }

  Widget _buildPosition() {
    final position = _latestValue != null ? _latestValue!.position : Duration.zero;
    final duration = _latestValue != null && _latestValue!.duration != null ? _latestValue!.duration! : Duration.zero;

    return Padding(
      padding: _controlsCfg.enablePlayPause ? const EdgeInsets.only(right: 1) : const EdgeInsets.only(right: 1),
      // : const EdgeInsets.symmetric(horizontal: 22),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: BPUtils.formatDuration(position),
          style: TextStyle(
            fontSize: 12.0,
            color: _controlsCfg.textColor,
            decoration: TextDecoration.none,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' / ${BPUtils.formatDuration(duration)}',
              style: TextStyle(
                fontSize: 12.0,
                color: _controlsCfg.textColor,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    var color = Colors.white;
    var child = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 5),
          FaIcon(FontAwesomeIcons.solidCircle, color: color, size: 2),
          SizedBox(width: 5),
          Text("二进制基础", style: TextStyle(color: color, fontSize: 12.0), textAlign: TextAlign.center),
          SizedBox(width: 5),
          // Icon(Icons.navigate_next, color: color, size: 18),
          FaIcon(FontAwesomeIcons.angleRight, color: color, size: 12),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: BPMaterialClickableWidget(
        onTap: () {},
        child: AnimatedOpacity(
          opacity: controlsNotVisible ? 0.0 : 1.0,
          duration: _controlsCfg.controlsHideTime,
          child: child,
        ),
      ),
    );
  }

  @override
  void cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    changePlayerControlsNotVisible(false);
    _displayTapped = true;
  }

  Future<void> _initialize() async {
    _controller!.addListener(_updateState);

    _updateState();

    if ((_controller!.value.isPlaying) || _bpController!.bpCfg.autoPlay) {
      _startHideTimer();
    }

    if (_controlsCfg.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        changePlayerControlsNotVisible(false);
      });
    }

    _controlsVisibilityStreamSubscription = _bpController!.controlsVisibilityStream.listen(
      (state) {
        // debugPrint("in controls VisibilityStream.listen");
        changePlayerControlsNotVisible(!state);
        if (!controlsNotVisible) {
          cancelAndRestartTimer();
        }
      },
    );
  }

  void _onExpandCollapse() {
    changePlayerControlsNotVisible(true);
    _bpController!.toggleFullScreen();
    _showAfterExpandCollapseTimer = Timer(_controlsCfg.controlsHideTime, () {
      setState(() {
        cancelAndRestartTimer();
      });
    });
  }

  void _onPlayPause() {
    bool isFinished = false;

    if (_latestValue?.position != null && _latestValue?.duration != null) {
      isFinished = _latestValue!.position >= _latestValue!.duration!;
    }

    if (_controller!.value.isPlaying) {
      changePlayerControlsNotVisible(false);
      _hideTimer?.cancel();
      _bpController!.pause();
    } else {
      cancelAndRestartTimer();

      if (!_controller!.value.initialized) {
      } else {
        if (isFinished) {
          _bpController!.seekTo(const Duration());
        }
        _bpController!.play();
        _bpController!.cancelNextVideoTimer();
      }
    }
  }

  void _startHideTimer() {
    if (_bpController!.controlsAlwaysVisible) {
      return;
    }
    _hideTimer = Timer(const Duration(milliseconds: 3000), () {
      changePlayerControlsNotVisible(true);
    });
  }

  void _updateState() {
    if (mounted) {
      if (!controlsNotVisible || isVideoFinished(_controller!.value) || _wasLoading || isLoading(_controller!.value)) {
        setState(() {
          _latestValue = _controller!.value;
          if (isVideoFinished(_latestValue) && _bpController?.isLiveStream() == false) {
            // debugPrint("in _updateState, controlsNotVisible: $controlsNotVisible");
            changePlayerControlsNotVisible(false);
          }
        });
      }
    }
  }

  Widget _buildProgressBar() {
    return Expanded(
      flex: 40,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BPMaterialVideoProgressBar(
          _controller,
          _bpController,
          onDragStart: () {
            _hideTimer?.cancel();
          },
          onDragEnd: () {
            _startHideTimer();
          },
          onTapDown: () {
            cancelAndRestartTimer();
          },
          colors: BPProgressColors(
              playedColor: _controlsCfg.progressBarPlayedColor,
              handleColor: _controlsCfg.progressBarHandleColor,
              bufferedColor: _controlsCfg.progressBarBufferedColor,
              backgroundColor: _controlsCfg.progressBarBackgroundColor),
        ),
      ),
    );
  }

  void _onPlayerHide(String from) {
    // debugPrint("in _on Player hidde from: ${from}, controlsNotVisible: ${controlsNotVisible}");
    _bpController!.toggleControlsVisibility(!controlsNotVisible);
    widget.onControlsVisibilityChanged(!controlsNotVisible);
  }

  Widget? _buildLoadingWidget() {
    if (_controlsCfg.loadingWidget != null) {
      return Container(
        color: _controlsCfg.controlBarColor,
        child: _controlsCfg.loadingWidget,
      );
    }

    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(_controlsCfg.loadingColor),
    );
  }
}
