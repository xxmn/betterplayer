import 'package:better_player/src/drags/position_provider.dart';
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
  Duration _lastPosition = Duration.zero;
  Duration _duration = Duration.zero;

  void onStart(DragStartDetails details) {
    if (isLocked) return;
    // todo: 视频是否初始化判断

    _isPlaying = read(npStatusProvider.notifier).isPlaying();
    if (_isPlaying) read(npStatusProvider.notifier).pause();

    _lastPosition = read(npStatusProvider.notifier).getPosition();
    _duration = read(npStatusProvider.notifier).getDuration();

    read(dragIsShowPositionProvider.state).state = true;
  }

  void onUpdate(DragUpdateDetails details) async {
    if (isLocked) return;
    _sumDx += details.delta.dx;
    var seekTo = _getPositionNewValue(_sumDx, _lastPosition, _duration);
    read(dragChangePositionProvider.notifier).setPosition(seekTo);
  }

  void onEnd(DragEndDetails _) async {
    if (isLocked) return;

    var seekTo = _getPositionNewValue(_sumDx, _lastPosition, _duration);
    read(npStatusProvider.notifier).seekTo(seekTo);

    read(dragChangePositionProvider.notifier).setPosition(seekTo);
    read(dragIsShowPositionProvider.state).state = false;

    if (_isPlaying) read(npStatusProvider.notifier).play();
  }
}

// 计算亮度百分比
Duration _getPositionNewValue(double sumDx, Duration lastV, Duration duration) {
  var ms = (sumDx * 100).toInt() + lastV.inMilliseconds;
  if (ms > duration.inMilliseconds) {
    ms = duration.inMilliseconds;
  }
  if (ms < 0) {
    ms = 0;
  }
  return Duration(milliseconds: ms);
}
