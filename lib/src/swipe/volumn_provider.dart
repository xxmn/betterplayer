import 'package:hooks_riverpod/hooks_riverpod.dart';

final dragChangeVolumnProvider = StateNotifierProvider<_VolumnNotifier, double>((ref) {
  return _VolumnNotifier();
});

class _VolumnNotifier extends StateNotifier<double> {
  _VolumnNotifier() : super(0.0);

  void setVolumn(double v) => state = v;
}

final dragIsShowVolumnProvider = StateProvider<bool>((ref) {
  return false;
});
