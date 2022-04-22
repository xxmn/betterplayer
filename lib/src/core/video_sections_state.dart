import 'package:flutter/material.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class VideoSectionsState with ChangeNotifier {
  VideoSectionsState(this.length);
  late final int length;
  // 当前显示的章节
  int index = 0;

  // 是否显示
  bool isShow = true;

  void setIndex(int idx) {
    index = idx;
    notifyListeners();
  }

  void setIsShow(bool bshow) {
    isShow = bshow;
    notifyListeners();
  }
}
