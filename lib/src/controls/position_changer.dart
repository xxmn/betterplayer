import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionChanger {
  PositionChanger({
    required this.isLocked,
    required this.read,
  });
  Reader read;
  bool isLocked;
  double _sumDx = 0;
  bool _isPlaying = false;
  late Duration _lastPosition;

  void onStart(DragStartDetails details) {
    if (isLocked) return;
    _isPlaying = read(npStatusProvider.notifier).isPlaying();
    if (_isPlaying) read(npStatusProvider.notifier).pause();
    _lastPosition = read(npStatusProvider.notifier).getPosition();
  }

  void onUpdate(DragUpdateDetails details) async {
    if (isLocked) return;

    _sumDx += details.delta.dx;
  }

  void onEnd(DragEndDetails _) async {
    if (isLocked) return;
    var duration = read(npStatusProvider.notifier).getDuration();
    var seekTo = _getPositionNewValue(_sumDx, _lastPosition, duration);
    debugPrint("-----------------seekTo: ${seekTo}, lastPosition: $_lastPosition, _sumDx:$_sumDx");

    read(npStatusProvider.notifier).seekTo(seekTo);
    if (_isPlaying) read(npStatusProvider.notifier).play();
  }
}

// 计算亮度百分比
Duration _getPositionNewValue(double sumDx, Duration lastV, Duration duration) {
  var ms = (sumDx * 200).toInt() + lastV.inMilliseconds;
  if (ms > duration.inMilliseconds) {
    ms = duration.inMilliseconds;
  }
  if (ms < 0) {
    ms = 0;
  }
  return Duration(milliseconds: ms);
}

// class PercentageWidget extends StatefulWidget {
//   PercentageWidget({Key? key}) : super(key: key);
//   late Function(String) percentageCallback; // 百分比
//   late Function(bool) offstageCallback;

//   @override
//   _PercentageWidgetState createState() => _PercentageWidgetState();
// }

// class _PercentageWidgetState extends State<PercentageWidget> {
//   String _percentage = ""; // 具体的百分比信息
//   bool _offstage = true;

//   @override
//   void initState() {
//     super.initState();
//     widget.percentageCallback = (percentage) {
//       _percentage = percentage;
//       _offstage = false;
//       if (!mounted) return;
//       setState(() {});
//     };
//     widget.offstageCallback = (offstage) {
//       _offstage = offstage;
//       if (!mounted) return;
//       setState(() {});
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Offstage(
//         offstage: _offstage,
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           decoration: const BoxDecoration(
//               color: Colors.black87, borderRadius: BorderRadius.all(Radius.circular(5.0))),
//           child: Text(_percentage, style: const TextStyle(color: Colors.white, fontSize: 14)),
//         ),
//       ),
//     );
//   }
// }
