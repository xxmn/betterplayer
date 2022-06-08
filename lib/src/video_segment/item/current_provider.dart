import 'package:better_player/src/native_player/np_status_provider.dart';
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
    var start = Duration(seconds: 30);
    var newSegment = Segment(
      id: 9,
      title: "新章节...",
      start: start,
      end: Duration(seconds: 80),
    );
    setItem(newSegment);
    read(npStatusProvider.notifier).seekToAndContinue(start);
    read(itemStatusProvider.notifier)
      ..setNew(true)
      ..setStart();
  }

  void modifySegment(Segment s) {
    setItem(s);
    read(npStatusProvider.notifier).seekToAndContinue(s.start);
    read(itemStatusProvider.notifier)
      ..setNew(false)
      ..setStart();
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

  Duration get start => state.start;
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

  Duration get end => state.end;
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
