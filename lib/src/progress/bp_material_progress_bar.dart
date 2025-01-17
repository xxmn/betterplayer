import 'dart:async';
import 'package:better_player/src/defines/bp_progress_colors.dart';
import 'package:flutter/material.dart';

class BPMaterialVideoProgressBar extends StatefulWidget {
  BPMaterialVideoProgressBar({
    BPProgressColors? colors,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    this.onTapDown,
    Key? key,
  })  : colors = colors ?? BPProgressColors(),
        super(key: key);

  final BPProgressColors colors;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;
  final Function()? onTapDown;

  @override
  _VideoProgressBarState createState() {
    return _VideoProgressBarState();
  }
}

class _VideoProgressBarState extends State<BPMaterialVideoProgressBar> {
  _VideoProgressBarState() {
    listener = () {
      if (mounted) setState(() {});
    };
  }

  late VoidCallback listener;
  bool _controllerWasPlaying = false;

  bool shouldPlayAfterDragEnd = false;
  Duration? lastSeek;
  Timer? _updateBlockTimer;

  @override
  void initState() {
    super.initState();
    // controller!.addListener(listener);
  }

  @override
  void deactivate() {
    // controller!.removeListener(listener);
    // _cancelUpdateBlockTimer();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // final bool enableProgressBarDrag = bpController!.bpCfg.controlsCfg.enableProgressBarDrag;
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        // todo:
        // if (!controller!.value.initialized || !enableProgressBarDrag) {
        //   return;
        // }

        // _controllerWasPlaying = controller!.value.isPlaying;
        // if (_controllerWasPlaying) {
        //   controller!.pause();
        // }

        // if (widget.onDragStart != null) {
        //   widget.onDragStart!();
        // }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        // todo:
        // if (!controller!.value.initialized || !enableProgressBarDrag) {
        //   return;
        // }

        // seekToRelativePosition(details.globalPosition);

        // if (widget.onDragUpdate != null) {
        //   widget.onDragUpdate!();
        // }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        // todo:
        // if (!enableProgressBarDrag) {
        //   return;
        // }

        // if (_controllerWasPlaying) {
        //   bpController?.play();
        //   shouldPlayAfterDragEnd = true;
        // }
        // _setupUpdateBlockTimer();

        // if (widget.onDragEnd != null) {
        //   widget.onDragEnd!();
        // }
      },
      onTapDown: (TapDownDetails details) {
        // todo:
        // if (!controller!.value.initialized || !enableProgressBarDrag) {
        //   return;
        // }
        // seekToRelativePosition(details.globalPosition);
        // _setupUpdateBlockTimer();
        // if (widget.onTapDown != null) {
        //   widget.onTapDown!();
        // }
      },
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Text("_ProgressBarPainter"),
          // child: CustomPaint(
          //   painter: _ProgressBarPainter(
          //     _getValue(),
          //     widget.colors,
          //   ),
          // ),
        ),
      ),
    );
  }

  void _setupUpdateBlockTimer() {
    _updateBlockTimer = Timer(const Duration(milliseconds: 1000), () {
      lastSeek = null;
      _cancelUpdateBlockTimer();
    });
  }

  void _cancelUpdateBlockTimer() {
    _updateBlockTimer?.cancel();
    _updateBlockTimer = null;
  }

  // VideoPlayerValue _getValue() {
  //   if (lastSeek != null) {
  //     return controller!.value.copyWith(position: lastSeek);
  //   } else {
  //     return controller!.value;
  //   }
  // }

  void seekToRelativePosition(Offset globalPosition) async {
    // todo:
    // final RenderObject? renderObject = context.findRenderObject();
    // if (renderObject != null) {
    //   final box = renderObject as RenderBox;
    //   final Offset tapPos = box.globalToLocal(globalPosition);
    //   final double relative = tapPos.dx / box.size.width;
    //   if (relative > 0) {
    //     final Duration position = controller!.value.duration! * relative;
    //     lastSeek = position;
    //     await bpController!.seekTo(position);
    //     onFinishedLastSeek();
    //     if (relative >= 1) {
    //       lastSeek = controller!.value.duration;
    //       await bpController!.seekTo(controller!.value.duration!);
    //       onFinishedLastSeek();
    //     }
    //   }
    // }
  }

  void onFinishedLastSeek() {
    // todo:
    // if (shouldPlayAfterDragEnd) {
    //   shouldPlayAfterDragEnd = false;
    //   bpController?.play();
    // }
  }
}

// class _ProgressBarPainter extends CustomPainter {
//   _ProgressBarPainter(this.value, this.colors);

//   VideoPlayerValue value;
//   BPProgressColors colors;

//   @override
//   bool shouldRepaint(CustomPainter old) {
//     return true;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     const height = 2.0;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromPoints(
//           Offset(0.0, size.height / 2),
//           Offset(size.width, size.height / 2 + height),
//         ),
//         const Radius.circular(4.0),
//       ),
//       colors.backgroundPaint,
//     );
//     if (!value.initialized) {
//       return;
//     }
//     double playedPartPercent = value.position.inMilliseconds / value.duration!.inMilliseconds;
//     if (playedPartPercent.isNaN) {
//       playedPartPercent = 0;
//     }
//     final double playedPart = playedPartPercent > 1 ? size.width : playedPartPercent * size.width;
//     for (final DurationRange range in value.buffered) {
//       double start = range.startFraction(value.duration!) * size.width;
//       if (start.isNaN) {
//         start = 0;
//       }
//       double end = range.endFraction(value.duration!) * size.width;
//       if (end.isNaN) {
//         end = 0;
//       }
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromPoints(
//             Offset(start, size.height / 2),
//             Offset(end, size.height / 2 + height),
//           ),
//           const Radius.circular(4.0),
//         ),
//         colors.bufferedPaint,
//       );
//     }
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromPoints(
//           Offset(0.0, size.height / 2),
//           Offset(playedPart, size.height / 2 + height),
//         ),
//         const Radius.circular(4.0),
//       ),
//       colors.playedPaint,
//     );
//     canvas.drawCircle(
//       Offset(playedPart, size.height / 2 + height / 2),
//       height * 3,
//       colors.handlePaint,
//     );
//   }
// }
