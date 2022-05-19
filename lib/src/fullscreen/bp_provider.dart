import 'package:hooks_riverpod/hooks_riverpod.dart';

///Check if picture in picture mode is supported in this device.
///
final bpFullScreenProvider = StateNotifierProvider.autoDispose<_BPFullScreenNotifier, bool>(
  (ref) => _BPFullScreenNotifier(),
);

class _BPFullScreenNotifier extends StateNotifier<bool> {
  _BPFullScreenNotifier() : super(false);

  void exit() => state = false;
  void enter() => state = true;
  bool isFullScreen() => state;
}
