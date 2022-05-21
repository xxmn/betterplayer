import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'status.dart';

final itemStatusProvider = StateNotifierProvider<_Notifier, VideoSegmentItemStatus>(
  (ref) {
    return _Notifier(VideoSegmentItemStatus(start: 10, end: 20));
  },
);

class _Notifier extends StateNotifier<VideoSegmentItemStatus> {
  _Notifier(VideoSegmentItemStatus r) : super(r);
  void setStart(double s) => state = state.copyWith(start: s);
  bool getSelectStart() => state.selectStart;
  void insStart() => state = state.copyWith(start: state.start + 1);
  void decreaseStart() => state = state.copyWith(start: state.start - 1);
  void toggleStart() {
    state = state.copyWith(
      selectStart: !state.selectStart,
      selectEnd: false,
    );
  }

  void setEnd(double s) => state = state.copyWith(end: s);
  bool getSelectEnd() => state.selectEnd;
  void insEnd() => state = state.copyWith(end: state.end + 1);
  void decreaseEnd() => state = state.copyWith(end: state.end - 1);
  void toggleEnd() {
    state = state.copyWith(
      selectEnd: !state.selectEnd,
      selectStart: false,
    );
  }
}
