import 'package:hooks_riverpod/hooks_riverpod.dart';

final dragChangeBrightnessProvider =
    StateNotifierProvider.autoDispose<_BrightnessNotifier, double>((ref) {
  return _BrightnessNotifier();
});

class _BrightnessNotifier extends StateNotifier<double> {
  _BrightnessNotifier() : super(0.0);

  void setBrightness(double v) => state = v;
}

final dragIsShowBrightnessProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
