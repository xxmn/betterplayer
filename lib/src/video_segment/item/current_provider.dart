import 'package:better_player/src/video_segment/segment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'status_provider.dart';

final itemCurrentProvider = StateNotifierProvider<_Notifier, Segment>(
  (ref) => _Notifier(
    Segment(title: "新章节...", start: Duration.zero, end: Duration(seconds: 0)),
    ref.read,
  ),
);

class _Notifier extends StateNotifier<Segment> {
  Reader read;
  _Notifier(Segment s, this.read) : super(s) {
    print("itemCurrentProvider new _Notifier---------------------");
  }

  void newSegment() {
    var newSegment = Segment(
      id: 9,
      title: "新章节...",
      start: Duration(seconds: 30),
      end: Duration(seconds: 80),
    );
    setItem(newSegment);
    read(itemStatusProvider.notifier).setNew(true);
  }

  void modifySegment(Segment s) {
    setItem(s);
    read(itemStatusProvider.notifier).setNew(false);
  }

  void setItem(Segment s) {
    state = s;
  }

  String get title => state.title;
  void set title(String t) {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(title: t);
  }

  void increaseStart() {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(start: state.start + Duration(milliseconds: 100));
  }

  void decreaseStart() {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(start: state.start - Duration(milliseconds: 100));
  }

  void setStart(Duration start) {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(start: start);
  }

  void increaseEnd() {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(end: state.end + Duration(milliseconds: 100));
  }

  void decreaseEnd() {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(end: state.end - Duration(milliseconds: 100));
  }

  void setEnd(Duration end) {
    read(itemStatusProvider.notifier).setUpdated();
    state = state.copyWith(end: end);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Duration get duration => state.end - state.start;
}
