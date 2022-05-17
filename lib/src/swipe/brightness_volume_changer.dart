import 'package:better_player/src/swipe/brightness_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:brightness_volume/brightness_volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'volumn_provider.dart';

class BrightnessVolumeChanger {
  BrightnessVolumeChanger({
    required this.size,
    required this.isLocked,
    required this.read,
  }) : _width = size.width;
  Reader read;
  Size size;
  bool isLocked;
  bool _brightnessOk = false;
  bool _volumeOk = false;
  double _width;

  double _newVolume = 0;
  double _newBrightness = 0;

  void onStart(DragStartDetails details) {
    if (isLocked) return;
    // todo: 视频是否初始化判断

    var _startPanOffset = details.globalPosition;
    if (_startPanOffset.dx < _width * 0.5) {
      // 左边调整亮度
      _brightnessOk = true;
      read(dragIsShowBrightnessProvider.state).state = true;
    } else {
      // 右边调整声音
      _volumeOk = true;
      read(dragIsShowVolumnProvider.state).state = true;
    }
  }

  void onUpdate(DragUpdateDetails details) async {
    if (isLocked) return;
    // 累计计算偏移量(下滑减少百分比，上滑增加百分比)
    var dy = (-details.delta.dy);
    if (_brightnessOk) {
      var bn = await BVUtils.brightness;
      _newBrightness = _getVerticalNewValue(dy, bn);

      //todo: 亮度过高提示
      BVUtils.setBrightness(_newBrightness);
      read(dragChangeBrightnessProvider.notifier).setBrightness(_newBrightness);
    }
    if (_volumeOk) {
      // 这个方法获取的volume不稳定，未知原因
      // var lastVolume = await BVUtils.volume;
      var lastVolume = await read(npStatusProvider.notifier).getVolume();
      _newVolume = _getVerticalNewValue(dy, lastVolume);
      await read(npStatusProvider.notifier).setVolume(_newVolume);

      read(dragChangeVolumnProvider.notifier).setVolumn(_newVolume);
      // await BVUtils.setVolume(_newVolume);
    }
  }

  void onEnd(DragEndDetails _) async {
    if (isLocked) return;

    if (_volumeOk) {
      _volumeOk = false;
      read(dragIsShowVolumnProvider.state).state = false;
    }
    if (_brightnessOk) {
      _brightnessOk = false;
      read(dragIsShowBrightnessProvider.state).state = false;
    }
  }

  // 计算亮度百分比
  double _getVerticalNewValue(double dh, double lastV) {
    double value = double.parse(((dh / 300) + lastV).toStringAsFixed(2));
    if (value >= 1.00) {
      value = 1.00;
    } else if (value <= 0.00) {
      value = 0.00;
    }
    return value;
  }
}

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
