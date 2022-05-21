import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'status.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.

final listStatusProvider = StateNotifierProvider.autoDispose<_Notifier, VideoSegmentListStatus>(
  (ref) => _Notifier(10),
);

class _Notifier extends StateNotifier<VideoSegmentListStatus> {
  _Notifier(int length) : super(VideoSegmentListStatus(length: length));
  void setIndex(int index) {
    state = state.copyWith(index: index);
  }

  void setIsShow(bool isShow) {
    state = state.copyWith(isShow: isShow);
  }
}
