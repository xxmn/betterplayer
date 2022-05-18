import 'package:hooks_riverpod/hooks_riverpod.dart';

final bpLockedProvider = StateNotifierProvider.autoDispose<_LockedNotifier, bool>((ref) {
  return _LockedNotifier();
});

class _LockedNotifier extends StateNotifier<bool> {
  _LockedNotifier() : super(false);

  void lock() => state = true;
  void unlock() => state = false;
}
