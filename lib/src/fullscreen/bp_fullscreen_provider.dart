import 'package:hooks_riverpod/hooks_riverpod.dart';

///Check if picture in picture mode is supported in this device.
///
final bpFullscreenProvider = StateNotifierProvider<_BPFullscreenNotifier, bool>(
  (ref) => _BPFullscreenNotifier(),
);

class _BPFullscreenNotifier extends StateNotifier<bool> {
  _BPFullscreenNotifier() : super(false);

  void exit() => state = false;
  void enter() => state = true;
  bool isFullscreen() => state;
}
