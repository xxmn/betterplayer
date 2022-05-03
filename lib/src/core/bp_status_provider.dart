import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
///Has player been init.
///
final bpIsInitializedProvider = StateProvider((ref) => false);

///
/// better player width、 height
///
final bpSizeProvider = StateProvider((ref) => Size(0, 0));

///
///Has player been init.
///
final bpIsFullScreenProvider = StateProvider((ref) => false);

///
///Has player visible.
///

final bpIsVisibleProvider = StateNotifierProvider<IsVisibleNotifier, bool>(
  (ref) => IsVisibleNotifier(true),
);

class IsVisibleNotifier extends StateNotifier<bool> {
  IsVisibleNotifier(bool isVisible) : super(isVisible);

  void setIsVisible(double visibilityFraction) {
    var isVisible = visibilityFraction > 0;
    if (state != isVisible) {
      state = isVisible;
    }
  }
}

///
///Has player been disposed.
///
final bpIsDisposedProvider = StateProvider((ref) => false);


// /// Play the video as soon as it's displayed  false
//   @Default(false) bool autoPlay;

//   /// Whether or not the video should loop
//   @Default(false) bool looping;