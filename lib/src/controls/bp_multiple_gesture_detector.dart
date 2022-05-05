import 'package:flutter/material.dart';

///Helper class for GestureDetector used within Better Player. Used to pass
///gestures to upper GestureDetectors.
class BPMultipleGestureDetector extends InheritedWidget {
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;

  const BPMultipleGestureDetector({
    Key? key,
    required Widget child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  }) : super(key: key, child: child);

  static BPMultipleGestureDetector? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BPMultipleGestureDetector>();
  }

  @override
  bool updateShouldNotify(BPMultipleGestureDetector oldWidget) => false;
}
