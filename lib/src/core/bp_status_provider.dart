import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/native_player/np_set_data_source_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
///Has player been init.
///
final bpIsInitializedProvider = StateProvider(
  (ref) => ref.watch(npStatusProvider.select((v) => v.initialized)),
);

/// 显示 _MaybeBPVideoFitWidget-->NativePlayer，观看视频
final bpShouldShowVideoProvider = StateProvider((ref) {
  var showholder = ref.watch(bpConfigProvider!.select((v) => v.showPlaceholderUntilPlay));
  // if (!showholder) return true;
  var setDS = ref.watch(npSetDataSourceProvider);
  return setDS;
});

///
/// better player width、 height
///
final bpSizeProvider = Provider<Size>((ref) {
  var size = ref.watch(npStatusProvider.select((v) => v.size));
  return size == null ? Size(0, 0) : size;
});

///
///Has player visible.
///播放器是否可见
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

class ControlsVisible extends StateNotifier<bool> {
  ControlsVisible(bool isVisible) : super(isVisible);

  void setVisible(bool isVisible) {
    state = isVisible;
  }

  void toggle() {
    state = !state;
  }
}


// /// Play the video as soon as it's displayed  false
//   @Default(false) bool autoPlay;

//   /// Whether or not the video should loop
//   @Default(false) bool looping;