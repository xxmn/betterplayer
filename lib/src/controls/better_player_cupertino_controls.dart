// import 'dart:async';
// import 'package:better_player/src/configuration/better_player_controls_configuration.dart';
// import 'package:better_player/src/controls/better_player_controls_state.dart';
// import 'package:better_player/src/controls/better_player_cupertino_progress_bar.dart';
// import 'package:better_player/src/controls/better_player_multiple_gesture_detector.dart';
// import 'package:better_player/src/controls/better_player_progress_colors.dart';
// import 'package:better_player/src/core/controller.dart';
// import 'package:better_player/src/utils/better_player_utils.dart';
// import 'package:better_player/src/video_player/native_player_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BPCupertinoControls extends StatefulWidget {
//   ///Callback used to send information if player bar is hidden or not
//   final Function(bool visbility) onControlsVisibilityChanged;

//   ///Controls config
//   final BPControlsCfg controlsCfg;

//   const BPCupertinoControls({
//     required this.onControlsVisibilityChanged,
//     required this.controlsCfg,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _BPCupertinoControlsState();
//   }
// }

// class _BPCupertinoControlsState extends BPControlsState<BPCupertinoControls> {
//   final marginSize = 5.0;
//   VideoPlayerValue? _latestValue;
//   double? _latestVolume;
//   Timer? _hideTimer;
//   Timer? _expandCollapseTimer;
//   Timer? _initTimer;
//   bool _wasLoading = false;

//   VideoPlayerController? _controller;
//   BPController? _bpController;
//   StreamSubscription? _controlsVisibilityStreamSubscription;

//   BPControlsCfg get _controlsCfg => widget.controlsCfg;

//   @override
//   VideoPlayerValue? get latestValue => _latestValue;

//   @override
//   BPController? get bpController => _bpController;

//   @override
//   BPControlsCfg get bpControlsCfg => _controlsCfg;

//   @override
//   Widget build(BuildContext context) {
//     return buildLTRDirectionality(_buildMainWidget());
//   }

//   ///Builds main widget of the controls.
//   Widget _buildMainWidget() {
//     _bpController = BPController.of(context);

//     if (_latestValue?.hasError == true) {
//       return Container(
//         color: Colors.black,
//         child: _buildErrorWidget(),
//       );
//     }

//     _bpController = BPController.of(context);
//     _controller = _bpController!.videoPlayerController;
//     final backgroundColor = _controlsCfg.controlBarColor;
//     final iconColor = _controlsCfg.iconsColor;
//     final orientation = MediaQuery.of(context).orientation;
//     final barHeight =
//         orientation == Orientation.portrait ? _controlsCfg.controlBarHeight : _controlsCfg.controlBarHeight + 10;
//     const buttonPadding = 10.0;
//     final isFullScreen = _bpController?.isFullScreen == true;

//     _wasLoading = isLoading(_latestValue);
//     final controlsColumn = Column(children: <Widget>[
//       _buildTopBar(
//         backgroundColor,
//         iconColor,
//         barHeight,
//         buttonPadding,
//       ),
//       if (_wasLoading) Expanded(child: Center(child: _buildLoadingWidget())) else _buildHitArea(),
//       _buildNextVideoWidget(),
//       _buildBottomBar(
//         backgroundColor,
//         iconColor,
//         barHeight,
//       ),
//     ]);
//     return GestureDetector(
//       onTap: () {
//         if (BPMultipleGestureDetector.of(context) != null) {
//           BPMultipleGestureDetector.of(context)!.onTap?.call();
//         }
//         controlsNotVisible ? cancelAndRestartTimer() : changePlayerControlsNotVisible(true);
//       },
//       onDoubleTap: () {
//         if (BPMultipleGestureDetector.of(context) != null) {
//           BPMultipleGestureDetector.of(context)!.onDoubleTap?.call();
//         }
//         cancelAndRestartTimer();
//         _onPlayPause();
//       },
//       onLongPress: () {
//         if (BPMultipleGestureDetector.of(context) != null) {
//           BPMultipleGestureDetector.of(context)!.onLongPress?.call();
//         }
//       },
//       child: AbsorbPointer(
//           absorbing: controlsNotVisible, child: isFullScreen ? SafeArea(child: controlsColumn) : controlsColumn),
//     );
//   }

//   @override
//   void dispose() {
//     _dispose();
//     super.dispose();
//   }

//   void _dispose() {
//     _controller!.removeListener(_updateState);
//     _hideTimer?.cancel();
//     _expandCollapseTimer?.cancel();
//     _initTimer?.cancel();
//     _controlsVisibilityStreamSubscription?.cancel();
//   }

//   @override
//   void didChangeDependencies() {
//     final _oldController = _bpController;
//     _bpController = BPController.of(context);
//     _controller = _bpController!.videoPlayerController;

//     if (_oldController != _bpController) {
//       _dispose();
//       _initialize();
//     }

//     super.didChangeDependencies();
//   }

//   Widget _buildBottomBar(
//     Color backgroundColor,
//     Color iconColor,
//     double barHeight,
//   ) {
//     if (!bpController!.controlsEnabled) {
//       return const SizedBox();
//     }
//     return AnimatedOpacity(
//       opacity: controlsNotVisible ? 0.0 : 1.0,
//       duration: _controlsCfg.controlsHideTime,
//       onEnd: _onPlayerHide,
//       child: Container(
//         alignment: Alignment.bottomCenter,
//         margin: EdgeInsets.all(marginSize),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             height: barHeight,
//             decoration: BoxDecoration(
//               color: backgroundColor,
//             ),
//             child: _bpController!.isLiveStream()
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       const SizedBox(width: 8),
//                       if (_controlsCfg.enablePlayPause)
//                         _buildPlayPause(_controller!, iconColor, barHeight)
//                       else
//                         const SizedBox(),
//                       const SizedBox(width: 8),
//                       _buildLiveWidget(),
//                     ],
//                   )
//                 : Row(
//                     children: <Widget>[
//                       if (_controlsCfg.enableSkips) _buildSkipBack(iconColor, barHeight) else const SizedBox(),
//                       if (_controlsCfg.enablePlayPause)
//                         _buildPlayPause(_controller!, iconColor, barHeight)
//                       else
//                         const SizedBox(),
//                       if (_controlsCfg.enableSkips) _buildSkipForward(iconColor, barHeight) else const SizedBox(),
//                       if (_controlsCfg.enableProgressText) _buildPosition() else const SizedBox(),
//                       if (_controlsCfg.enableProgressBar) _buildProgressBar() else const SizedBox(),
//                       if (_controlsCfg.enableProgressText) _buildRemaining() else const SizedBox()
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLiveWidget() {
//     return Expanded(
//       child: Text(
//         _bpController!.translations.controlsLive,
//         style: TextStyle(color: _controlsCfg.liveTextColor, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   GestureDetector _buildExpandButton(
//     Color backgroundColor,
//     Color iconColor,
//     double barHeight,
//     double iconSize,
//     double buttonPadding,
//   ) {
//     return GestureDetector(
//       onTap: _onExpandCollapse,
//       child: AnimatedOpacity(
//         opacity: controlsNotVisible ? 0.0 : 1.0,
//         duration: _controlsCfg.controlsHideTime,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             height: barHeight,
//             padding: EdgeInsets.symmetric(
//               horizontal: buttonPadding,
//             ),
//             decoration: BoxDecoration(color: backgroundColor),
//             child: Center(
//               child: Icon(
//                 _bpController!.isFullScreen ? _controlsCfg.fullscreenDisableIcon : _controlsCfg.fullscreenEnableIcon,
//                 color: iconColor,
//                 size: iconSize,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Expanded _buildHitArea() {
//     return Expanded(
//       child: GestureDetector(
//         onTap: _latestValue != null && _latestValue!.isPlaying
//             ? () {
//                 if (controlsNotVisible == true) {
//                   cancelAndRestartTimer();
//                 } else {
//                   _hideTimer?.cancel();
//                   changePlayerControlsNotVisible(true);
//                 }
//               }
//             : () {
//                 _hideTimer?.cancel();
//                 changePlayerControlsNotVisible(false);
//               },
//         child: Container(
//           color: Colors.transparent,
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildMoreButton(
//     // VideoPlayerController? controller,
//     Color backgroundColor,
//     Color iconColor,
//     double barHeight,
//     double iconSize,
//     double buttonPadding,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         onShowMoreClicked();
//       },
//       child: AnimatedOpacity(
//         opacity: controlsNotVisible ? 0.0 : 1.0,
//         duration: _controlsCfg.controlsHideTime,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: backgroundColor,
//             ),
//             child: Container(
//               height: barHeight,
//               padding: EdgeInsets.symmetric(
//                 horizontal: buttonPadding,
//               ),
//               child: Icon(
//                 _controlsCfg.overflowMenuIcon,
//                 color: iconColor,
//                 size: iconSize,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildMuteButton(
//     VideoPlayerController? controller,
//     Color backgroundColor,
//     Color iconColor,
//     double barHeight,
//     double iconSize,
//     double buttonPadding,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         cancelAndRestartTimer();

//         if (_latestValue!.volume == 0) {
//           controller!.setVolume(_latestVolume ?? 0.5);
//         } else {
//           _latestVolume = controller!.value.volume;
//           controller.setVolume(0.0);
//         }
//       },
//       child: AnimatedOpacity(
//         opacity: controlsNotVisible ? 0.0 : 1.0,
//         duration: _controlsCfg.controlsHideTime,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: backgroundColor,
//             ),
//             child: Container(
//               height: barHeight,
//               padding: EdgeInsets.symmetric(
//                 horizontal: buttonPadding,
//               ),
//               child: Icon(
//                 (_latestValue != null && _latestValue!.volume > 0) ? _controlsCfg.muteIcon : _controlsCfg.unMuteIcon,
//                 color: iconColor,
//                 size: iconSize,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildPlayPause(
//     VideoPlayerController controller,
//     Color iconColor,
//     double barHeight,
//   ) {
//     return GestureDetector(
//       onTap: _onPlayPause,
//       child: Container(
//         height: barHeight,
//         color: Colors.transparent,
//         padding: const EdgeInsets.symmetric(horizontal: 6),
//         child: Icon(
//           controller.value.isPlaying ? _controlsCfg.pauseIcon : _controlsCfg.playIcon,
//           color: iconColor,
//           size: barHeight * 0.6,
//         ),
//       ),
//     );
//   }

//   Widget _buildPosition() {
//     final position = _latestValue != null ? _latestValue!.position : const Duration();

//     return Padding(
//       padding: const EdgeInsets.only(right: 12.0),
//       child: Text(
//         BPUtils.formatDuration(position),
//         style: TextStyle(
//           color: _controlsCfg.textColor,
//           fontSize: 12.0,
//         ),
//       ),
//     );
//   }

//   Widget _buildRemaining() {
//     final position = _latestValue != null && _latestValue!.duration != null
//         ? _latestValue!.duration! - _latestValue!.position
//         : const Duration();

//     return Padding(
//       padding: const EdgeInsets.only(right: 12.0),
//       child: Text(
//         '-${BPUtils.formatDuration(position)}',
//         style: TextStyle(color: _controlsCfg.textColor, fontSize: 12.0),
//       ),
//     );
//   }

//   GestureDetector _buildSkipBack(Color iconColor, double barHeight) {
//     return GestureDetector(
//       onTap: skipBack,
//       child: Container(
//         height: barHeight,
//         color: Colors.transparent,
//         margin: const EdgeInsets.only(left: 10.0),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 8,
//         ),
//         child: Icon(
//           _controlsCfg.skipBackIcon,
//           color: iconColor,
//           size: barHeight * 0.4,
//         ),
//       ),
//     );
//   }

//   GestureDetector _buildSkipForward(Color iconColor, double barHeight) {
//     return GestureDetector(
//       onTap: skipForward,
//       child: Container(
//         height: barHeight,
//         color: Colors.transparent,
//         padding: const EdgeInsets.symmetric(horizontal: 6),
//         margin: const EdgeInsets.only(right: 8.0),
//         child: Icon(
//           _controlsCfg.skipForwardIcon,
//           color: iconColor,
//           size: barHeight * 0.4,
//         ),
//       ),
//     );
//   }

//   Widget _buildTopBar(
//     Color backgroundColor,
//     Color iconColor,
//     double topBarHeight,
//     double buttonPadding,
//   ) {
//     if (!bpController!.controlsEnabled) {
//       return const SizedBox();
//     }
//     final barHeight = topBarHeight * 0.8;
//     final iconSize = topBarHeight * 0.4;
//     return Container(
//       height: barHeight,
//       margin: EdgeInsets.only(
//         top: marginSize,
//         right: marginSize,
//         left: marginSize,
//       ),
//       child: Row(
//         children: <Widget>[
//           if (_controlsCfg.enableFullscreen)
//             _buildExpandButton(
//               backgroundColor,
//               iconColor,
//               barHeight,
//               iconSize,
//               buttonPadding,
//             )
//           else
//             const SizedBox(),
//           const SizedBox(
//             width: 4,
//           ),
//           if (_controlsCfg.enablePip)
//             _buildPipButton(
//               backgroundColor,
//               iconColor,
//               barHeight,
//               iconSize,
//               buttonPadding,
//             )
//           else
//             const SizedBox(),
//           const Spacer(),
//           if (_controlsCfg.enableMute)
//             _buildMuteButton(
//               _controller,
//               backgroundColor,
//               iconColor,
//               barHeight,
//               iconSize,
//               buttonPadding,
//             )
//           else
//             const SizedBox(),
//           const SizedBox(
//             width: 4,
//           ),
//           if (_controlsCfg.enableOverflowMenu)
//             _buildMoreButton(
//               _controller,
//               backgroundColor,
//               iconColor,
//               barHeight,
//               iconSize,
//               buttonPadding,
//             )
//           else
//             const SizedBox(),
//         ],
//       ),
//     );
//   }

//   Widget _buildNextVideoWidget() {
//     return StreamBuilder<int?>(
//       stream: _bpController!.nextVideoTimeStream,
//       builder: (context, snapshot) {
//         final time = snapshot.data;
//         if (time != null && time > 0) {
//           return InkWell(
//             onTap: () {
//               _bpController!.playNextVideo();
//             },
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 4, right: 8),
//                 decoration: BoxDecoration(
//                   color: _controlsCfg.controlBarColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Text(
//                     "${_bpController!.translations.controlsNextVideoIn} $time ...",
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }

//   @override
//   void cancelAndRestartTimer() {
//     _hideTimer?.cancel();
//     changePlayerControlsNotVisible(false);
//     _startHideTimer();
//   }

//   Future<void> _initialize() async {
//     _controller!.addListener(_updateState);

//     _updateState();

//     if ((_controller!.value.isPlaying) || _bpController!.bpCfg.autoPlay) {
//       _startHideTimer();
//     }

//     if (_controlsCfg.showControlsOnInitialize) {
//       _initTimer = Timer(const Duration(milliseconds: 200), () {
//         changePlayerControlsNotVisible(false);
//       });
//     }
//     _controlsVisibilityStreamSubscription = _bpController!.controlsVisibilityStream.listen((state) {
//       changePlayerControlsNotVisible(!state);

//       if (!controlsNotVisible) {
//         cancelAndRestartTimer();
//       }
//     });
//   }

//   void _onExpandCollapse() {
//     changePlayerControlsNotVisible(true);
//     _bpController!.toggleFullScreen();
//     _expandCollapseTimer = Timer(_controlsCfg.controlsHideTime, () {
//       setState(() {
//         cancelAndRestartTimer();
//       });
//     });
//   }

//   Widget _buildProgressBar() {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 12.0),
//         child: BPCupertinoVideoProgressBar(
//           _controller,
//           _bpController,
//           onDragStart: () {
//             _hideTimer?.cancel();
//           },
//           onDragEnd: () {
//             _startHideTimer();
//           },
//           onTapDown: () {
//             cancelAndRestartTimer();
//           },
//           colors: BPProgressColors(
//               playedColor: _controlsCfg.progressBarPlayedColor,
//               handleColor: _controlsCfg.progressBarHandleColor,
//               bufferedColor: _controlsCfg.progressBarBufferedColor,
//               backgroundColor: _controlsCfg.progressBarBackgroundColor),
//         ),
//       ),
//     );
//   }

//   void _onPlayPause() {
//     bool isFinished = false;

//     if (_latestValue?.position != null && _latestValue?.duration != null) {
//       isFinished = _latestValue!.position >= _latestValue!.duration!;
//     }

//     if (_controller!.value.isPlaying) {
//       changePlayerControlsNotVisible(false);
//       _hideTimer?.cancel();
//       _bpController!.pause();
//     } else {
//       cancelAndRestartTimer();

//       if (!_controller!.value.initialized) {
//         if (_bpController!.bpDataSource?.liveStream == true) {
//           _bpController!.play();
//           _bpController!.cancelNextVideoTimer();
//         }
//       } else {
//         if (isFinished) {
//           _bpController!.seekTo(const Duration());
//         }
//         _bpController!.play();
//         _bpController!.cancelNextVideoTimer();
//       }
//     }
//   }

//   void _startHideTimer() {
//     if (_bpController!.controlsAlwaysVisible) {
//       return;
//     }
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       changePlayerControlsNotVisible(true);
//     });
//   }

//   void _updateState() {
//     if (mounted) {
//       if (!controlsNotVisible || isVideoFinished(_controller!.value) || _wasLoading || isLoading(_controller!.value)) {
//         setState(() {
//           _latestValue = _controller!.value;
//           if (isVideoFinished(_latestValue)) {
//             changePlayerControlsNotVisible(false);
//           }
//         });
//       }
//     }
//   }

//   void _onPlayerHide() {
//     _bpController!.toggleControlsVisibility(!controlsNotVisible);
//     widget.onControlsVisibilityChanged(!controlsNotVisible);
//   }

//   Widget _buildErrorWidget() {
//     final errorBuilder = _bpController!.bpCfg.errorBuilder;
//     if (errorBuilder != null) {
//       return errorBuilder(context, _bpController!.videoPlayerController!.value.errorDescription);
//     } else {
//       final textStyle = TextStyle(color: _controlsCfg.textColor);
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               CupertinoIcons.exclamationmark_triangle,
//               color: _controlsCfg.iconsColor,
//               size: 42,
//             ),
//             Text(
//               _bpController!.translations.generalDefaultError,
//               style: textStyle,
//             ),
//             if (_controlsCfg.enableRetry)
//               TextButton(
//                 onPressed: () {
//                   _bpController!.retryDataSource();
//                 },
//                 child: Text(
//                   _bpController!.translations.generalRetry,
//                   style: textStyle.copyWith(fontWeight: FontWeight.bold),
//                 ),
//               )
//           ],
//         ),
//       );
//     }
//   }

//   Widget? _buildLoadingWidget() {
//     if (_controlsCfg.loadingWidget != null) {
//       return _controlsCfg.loadingWidget;
//     }

//     return CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(_controlsCfg.loadingColor),
//     );
//   }

//   Widget _buildPipButton(
//     Color backgroundColor,
//     Color iconColor,
//     double barHeight,
//     double iconSize,
//     double buttonPadding,
//   ) {
//     return FutureBuilder<bool>(
//       future: _bpController!.isPictureInPictureSupported(),
//       builder: (context, snapshot) {
//         final isPipSupported = snapshot.data ?? false;
//         if (isPipSupported && _bpController!.bpGlobalKey != null) {
//           return GestureDetector(
//             onTap: () {
//               bpController!.enablePictureInPicture(bpController!.bpGlobalKey!);
//             },
//             child: AnimatedOpacity(
//               opacity: controlsNotVisible ? 0.0 : 1.0,
//               duration: _controlsCfg.controlsHideTime,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   height: barHeight,
//                   padding: EdgeInsets.only(
//                     left: buttonPadding,
//                     right: buttonPadding,
//                   ),
//                   decoration: BoxDecoration(
//                     color: backgroundColor.withOpacity(0.5),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       _controlsCfg.pipMenuIcon,
//                       color: iconColor,
//                       size: iconSize,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }
