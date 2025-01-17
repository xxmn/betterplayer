// import 'package:better_player/src/defines/duration_range.dart';
// import 'package:flutter/material.dart';

// /// Displays the play/buffering status of the video controlled by [controller].
// ///
// /// If [allowScrubbing] is true, this widget will detect taps and drags and
// /// seek the video accordingly.
// ///
// /// [padding] allows to specify some extra padding around the progress indicator
// /// that will also detect the gestures.
// class VideoProgressIndicator extends StatefulWidget {
//   /// Construct an instance that displays the play/buffering status of the video
//   /// controlled by [controller].
//   ///
//   /// Defaults will be used for everything except [controller] if they're not
//   /// provided. [allowScrubbing] defaults to false, and [padding] will default
//   /// to `top: 5.0`.
//   VideoProgressIndicator(
//     this.controller, {
//     VideoProgressColors? colors,
//     this.allowScrubbing,
//     this.padding = const EdgeInsets.only(top: 5.0),
//     Key? key,
//   })  : colors = colors ?? VideoProgressColors(),
//         super(key: key);

//   /// The [VideoPlayerController] that actually associates a video with this
//   /// widget.
//   final VideoPlayerController controller;

//   /// The default colors used throughout the indicator.
//   ///
//   /// See [VideoProgressColors] for default values.
//   final VideoProgressColors colors;

//   /// When true, the widget will detect touch input and try to seek the video
//   /// accordingly. The widget ignores such input when false.
//   ///
//   /// Defaults to false.
//   final bool? allowScrubbing;

//   /// This allows for visual padding around the progress indicator that can
//   /// still detect gestures via [allowScrubbing].
//   ///
//   /// Defaults to `top: 5.0`.
//   final EdgeInsets padding;

//   @override
//   _VideoProgressIndicatorState createState() => _VideoProgressIndicatorState();
// }

// class _VideoProgressIndicatorState extends State<VideoProgressIndicator> {
//   _VideoProgressIndicatorState() {
//     listener = () {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     };
//   }

//   late VoidCallback listener;

//   VideoPlayerController get controller => widget.controller;

//   VideoProgressColors get colors => widget.colors;

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(listener);
//   }

//   @override
//   void deactivate() {
//     controller.removeListener(listener);
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget progressIndicator;
//     if (controller.value.initialized) {
//       final int duration = controller.value.duration!.inMilliseconds;
//       final int position = controller.value.position.inMilliseconds;

//       int maxBuffering = 0;
//       for (final DurationRange range in controller.value.buffered) {
//         final int end = range.end.inMilliseconds;
//         if (end > maxBuffering) {
//           maxBuffering = end;
//         }
//       }

//       progressIndicator = Stack(
//         fit: StackFit.passthrough,
//         children: <Widget>[
//           LinearProgressIndicator(
//             value: maxBuffering / duration,
//             valueColor: AlwaysStoppedAnimation<Color>(colors.bufferedColor),
//             backgroundColor: colors.backgroundColor,
//           ),
//           LinearProgressIndicator(
//             value: position / duration,
//             valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
//             backgroundColor: Colors.transparent,
//           ),
//         ],
//       );
//     } else {
//       progressIndicator = LinearProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
//         backgroundColor: colors.backgroundColor,
//       );
//     }
//     final Widget paddedProgressIndicator = Padding(
//       padding: widget.padding,
//       child: progressIndicator,
//     );
//     if (widget.allowScrubbing!) {
//       return _VideoScrubber(
//         controller: controller,
//         child: paddedProgressIndicator,
//       );
//     } else {
//       return paddedProgressIndicator;
//     }
//   }
// }

// class _VideoScrubber extends StatefulWidget {
//   const _VideoScrubber({
//     required this.child,
//     required this.controller,
//   });

//   final Widget child;
//   final VideoPlayerController controller;

//   @override
//   _VideoScrubberState createState() => _VideoScrubberState();
// }

// class _VideoScrubberState extends State<_VideoScrubber> {
//   bool _controllerWasPlaying = false;

//   VideoPlayerController get controller => widget.controller;

//   @override
//   Widget build(BuildContext context) {
//     void seekToRelativePosition(Offset globalPosition) {
//       final RenderObject? renderObject = context.findRenderObject();
//       if (renderObject != null) {
//         final RenderBox box = renderObject as RenderBox;
//         final Offset tapPos = box.globalToLocal(globalPosition);
//         final double relative = tapPos.dx / box.size.width;
//         final Duration position = controller.value.duration! * relative;
//         controller.seekTo(position);
//       }
//     }

//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onHorizontalDragStart: (DragStartDetails details) {
//         if (!controller.value.initialized) {
//           return;
//         }
//         _controllerWasPlaying = controller.value.isPlaying;
//         if (_controllerWasPlaying) {
//           controller.pause();
//         }
//       },
//       onHorizontalDragUpdate: (DragUpdateDetails details) {
//         if (!controller.value.initialized) {
//           return;
//         }
//         seekToRelativePosition(details.globalPosition);
//       },
//       onHorizontalDragEnd: (DragEndDetails details) {
//         if (_controllerWasPlaying) {
//           controller.play();
//         }
//       },
//       onTapDown: (TapDownDetails details) {
//         if (!controller.value.initialized) {
//           return;
//         }
//         seekToRelativePosition(details.globalPosition);
//       },
//       child: widget.child,
//     );
//   }
// }

// /// Used to configure the [VideoProgressIndicator] widget's colors for how it
// /// describes the video's status.
// ///
// /// The widget uses default colors that are customizeable through this class.
// class VideoProgressColors {
//   /// Any property can be set to any color. They each have defaults.
//   ///
//   /// [playedColor] defaults to red at 70% opacity. This fills up a portion of
//   /// the [VideoProgressIndicator] to represent how much of the video has played
//   /// so far.
//   ///
//   /// [bufferedColor] defaults to blue at 20% opacity. This fills up a portion
//   /// of [VideoProgressIndicator] to represent how much of the video has
//   /// buffered so far.
//   ///
//   /// [backgroundColor] defaults to gray at 50% opacity. This is the background
//   /// color behind both [playedColor] and [bufferedColor] to denote the total
//   /// size of the video compared to either of those values.
//   VideoProgressColors({
//     this.playedColor = const Color.fromRGBO(255, 0, 0, 0.7),
//     this.bufferedColor = const Color.fromRGBO(50, 50, 200, 0.2),
//     this.backgroundColor = const Color.fromRGBO(200, 200, 200, 0.5),
//   });

//   /// [playedColor] defaults to red at 70% opacity. This fills up a portion of
//   /// the [VideoProgressIndicator] to represent how much of the video has played
//   /// so far.
//   final Color playedColor;

//   /// [bufferedColor] defaults to blue at 20% opacity. This fills up a portion
//   /// of [VideoProgressIndicator] to represent how much of the video has
//   /// buffered so far.
//   final Color bufferedColor;

//   /// [backgroundColor] defaults to gray at 50% opacity. This is the background
//   /// color behind both [playedColor] and [bufferedColor] to denote the total
//   /// size of the video compared to either of those values.
//   final Color backgroundColor;
// }
