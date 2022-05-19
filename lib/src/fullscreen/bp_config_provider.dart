import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config.dart';

AutoDisposeStateNotifierProvider<_Notifier, BPFullScreenConfig>? bpFullScreenConfigProvider;

void initBpFullScreenConfigProvider(BPFullScreenConfig? config) {
  if (bpFullScreenConfigProvider == null) {
    bpFullScreenConfigProvider = StateNotifierProvider.autoDispose<_Notifier, BPFullScreenConfig>(
      (ref) => _Notifier(config: config),
    );
  }
}

void disposeBpFullScreenConfigProvider() => bpFullScreenConfigProvider = null;

class _Notifier extends StateNotifier<BPFullScreenConfig> {
  _Notifier({BPFullScreenConfig? config}) : super(config ?? BPFullScreenConfig());

  List<SystemUiOverlay> getOverlaysAfter() => state.systemOverlaysAfterFullScreen;
  List<DeviceOrientation> getOrientationsAfter() => state.deviceOrientationsAfterFullScreen;
  List<DeviceOrientation> getOrientations() => state.deviceOrientationsOnFullScreen;
  bool autoDetectOrientations() => state.autoDetectFullScreenDeviceOrientation;
  bool allowedSleep() => state.allowedScreenSleep;
}
