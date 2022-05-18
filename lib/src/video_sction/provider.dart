import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'config.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.

final bpVideoSectionProvider =
    StateNotifierProvider.autoDispose<_BPVideoSctionNotifier, BPVideoSctionConfig>(
  (ref) => _BPVideoSctionNotifier(10),
);

class _BPVideoSctionNotifier extends StateNotifier<BPVideoSctionConfig> {
  _BPVideoSctionNotifier(int length) : super(BPVideoSctionConfig(length: length));
  void setIndex(int index) {
    state = state.copyWith(index: index);
  }

  void setIsShow(bool isShow) {
    state = state.copyWith(isShow: isShow);
  }
}
