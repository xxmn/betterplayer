import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'status.dart';

final itemStatusProvider = StateNotifierProvider<_Notifier, VideoSegmentItemStatus>(
  (ref) {
    return _Notifier(VideoSegmentItemStatus());
  },
);

class _Notifier extends StateNotifier<VideoSegmentItemStatus> {
  _Notifier(VideoSegmentItemStatus r) : super(r);
  void setNew(bool isNew) => state = VideoSegmentItemStatus(isNew: isNew);

  // bool get isSelected => state.selectStart || state.selectEnd;
  void setUpdated() => state.isUpdated ? null : state = state.copyWith(isUpdated: true);

  bool getSelectStart() => state.selectStart;
  void toggleStart() => state = state.copyWith(selectStart: !state.selectStart, selectEnd: false);
  void setStart() => state = state.copyWith(selectStart: true, selectEnd: false);

  bool getSelectEnd() => state.selectEnd;
  void toggleEnd() {
    state = state.copyWith(
      selectEnd: !state.selectEnd,
      selectStart: false,
    );
  }

  void setProgressStart(Duration d) => state = state.copyWith(progressStart: d);
  void setProgressDuration(Duration d) => state = state.copyWith(progressDuration: d);
}
