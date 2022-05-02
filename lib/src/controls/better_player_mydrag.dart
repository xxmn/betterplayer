// import 'package:better_player/better_player.dart';
// import 'package:better_player/src/native_player/controller.dart';
// import 'package:flutter/material.dart';
// import 'package:brightness_volume/brightness_volume.dart';

// class MyDrag {
//   MyDrag({
//     required this.bpController,
//     required this.size,
//     required this.isLocked,
//   })  : _width = size.width,
//         _height = size.height,
//         _controller = bpController?.nativePlayerController;

//   BPController? bpController;
//   Size size;

//   bool isLocked = false;
//   bool _brightnessOk = false;
//   bool _volumeOk = false;
//   double _width;
//   double _height;
//   double _movePan = 0;

//   double _newVolume = 0;
//   double _newBrightness = 0;
//   NativePlayerController? _controller;

//   void onVerticalStart(DragStartDetails details) {
//     debugPrint("onVerticalStart");
//     print("size: ${size.width}, ${size.height}");
//     if (isLocked || _controller == null || bpController == null) return;
//     // if(!VideoPlayerUtils.isInitialized) return; // 视频是否已经完成初始化

//     _movePan = 0;
//     var _startPanOffset = details.globalPosition;
//     if (_startPanOffset.dx < _width * 0.5) {
//       // 左边调整亮度
//       _brightnessOk = true;
//     } else {
//       // 右边调整声音
//       _volumeOk = true;
//     }
//   }

//   void onVerticalUpdate(DragUpdateDetails details) async {
//     if (isLocked || _controller == null || bpController == null) return;
//     // 累计计算偏移量(下滑减少百分比，上滑增加百分比)
//     _movePan += (-details.delta.dy);
//     print("------------------------_movePan: $_movePan, -details.delta.dy: ${-details.delta.dy}");
//     if (_brightnessOk) {
//       // double b = _getNewValue(_movePan, );
//       // _percentageWidget.percentageCallback("亮度：${(b * 100).toInt()}%");
//       // VideoPlayerUtils.setBrightness(b);
//       var bn = await BVUtils.brightness;
//       _newBrightness = _getVerticalNewValue(_movePan, bn);
//       debugPrint("=========new brightness: ${_newBrightness}");
//       BVUtils.setBrightness(_newBrightness);
//     }
//     if (_volumeOk) {
//       var lastVolume = _controller!.value.volume;
//       _newVolume = _getVerticalNewValue(_movePan, lastVolume);
//       // percentageWidget.percentageCallback("音量：${(_newVolume * 100).toInt()}%");
//       debugPrint("-----------------_newVolume use BVUtils : ${_newVolume}");
//       bpController!.setVolume(_newVolume);
//     }
//   }

//   void onVerticalEnd(DragEndDetails _) {
//     debugPrint("onVerticalEnd");
//     if (isLocked || _controller == null || bpController == null) return;
//     // 隐藏
//     // _percentageWidget.offstageCallback(true);
//     if (_volumeOk) {
//       _volumeOk = false;
//     } else if (_brightnessOk) {
//       _brightnessOk = false;
//     }
//   }

//   // 计算亮度百分比
//   double _getVerticalNewValue(double dh, double lastV) {
//     double value = double.parse(((dh / _height) / 5 + lastV).toStringAsFixed(2));
//     if (value >= 1.00) {
//       value = 1.00;
//     } else if (value <= 0.00) {
//       value = 0.00;
//     }
//     return value;
//   }
// }

// // class PercentageWidget extends StatefulWidget {
// //   PercentageWidget({Key? key}) : super(key: key);
// //   late Function(String) percentageCallback; // 百分比
// //   late Function(bool) offstageCallback;

// //   @override
// //   _PercentageWidgetState createState() => _PercentageWidgetState();
// // }

// // class _PercentageWidgetState extends State<PercentageWidget> {
// //   String _percentage = ""; // 具体的百分比信息
// //   bool _offstage = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     widget.percentageCallback = (percentage) {
// //       _percentage = percentage;
// //       _offstage = false;
// //       if (!mounted) return;
// //       setState(() {});
// //     };
// //     widget.offstageCallback = (offstage) {
// //       _offstage = offstage;
// //       if (!mounted) return;
// //       setState(() {});
// //     };
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Offstage(
// //         offstage: _offstage,
// //         child: Container(
// //           padding: const EdgeInsets.all(8.0),
// //           decoration: const BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.all(Radius.circular(5.0))),
// //           child: Text(_percentage, style: const TextStyle(color: Colors.white, fontSize: 14)),
// //         ),
// //       ),
// //     );
// //   }
// // }
