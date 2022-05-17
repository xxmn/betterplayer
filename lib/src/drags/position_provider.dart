import 'package:hooks_riverpod/hooks_riverpod.dart';

final dragChangePositionProvider = StateNotifierProvider<_PositionNotifier, Duration>((ref) {
  return _PositionNotifier();
});

class _PositionNotifier extends StateNotifier<Duration> {
  _PositionNotifier() : super(Duration.zero);

  void setPosition(Duration v) => state = v;
}

final dragIsShowPositionProvider = StateProvider<bool>((ref) {
  return false;
});
