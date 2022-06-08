import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'item/status_provider.dart';
import 'segment.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.

final videoSegmentsProvider = StateNotifierProvider<_Notifier, List<Segment>?>((ref) {
  // var segments = ref.watch(bpDataSourceProvider!.select((v) => v!.segments));

  return _Notifier(sections, ref.read);
});

class _Notifier extends StateNotifier<List<Segment>?> {
  Reader read;
  _Notifier(List<Segment>? segments, this.read) : super(segments);

  void addOrUpdate(Segment s) {
    var isNew = read(itemStatusProvider).isNew;
    isNew ? add(s) : update(s);
  }

  void add(Segment s) => state = state == null || state!.isEmpty ? [s] : [...state!, s];
  void remove(int id) {
    if (state == null || state!.isEmpty) return;
    state = state!.fold<List<Segment>>(
      <Segment>[],
      (acc, e) => e.id == id ? acc : [...acc, e],
    );
  }

  void update(Segment newSegment) {
    if (state == null || state!.isEmpty) return;
    state = state!.fold<List<Segment>>(
      <Segment>[],
      (acc, e) => e.id == newSegment.id ? [...acc, newSegment] : [...acc, e],
    );
  }
}

final List<Segment> sections = [
  Segment(
    id: 1,
    title: "二进制基础",
    start: Duration(milliseconds: 5000),
    end: Duration(milliseconds: 72000),
    desc: "八卦理论类比",
    imgUrl:
        "https://images2015.cnblogs.com/blog/712650/201509/712650-20150901130405528-1386591357.jpg",
  ),
  Segment(
    id: 2,
    title: "股神案例",
    start: Duration(milliseconds: 72000),
    end: Duration(milliseconds: 195000),
    desc: "筛选--大数据时代的股神",
    imgUrl:
        "https://images2015.cnblogs.com/blog/712650/201509/712650-20150901130405528-1386591357.jpg",
  ),
  Segment(
    id: 3,
    title: "计算机存储数据用二进制",
    start: Duration(milliseconds: 196000),
    end: Duration(milliseconds: 214000),
  ),
  Segment(
    id: 4,
    title: "计算机存储数据的方式",
    start: Duration(milliseconds: 214000),
    end: Duration(milliseconds: 245000),
    desc: "磁极存储，磁带和硬盘",
    imgUrl:
        "https://images2015.cnblogs.com/blog/712650/201509/712650-20150901130405528-1386591357.jpg",
  ),
  Segment(
    id: 5,
    title: "常见数据类型",
    start: Duration(milliseconds: 245000),
    end: Duration(milliseconds: 275000),
    desc: "byte、short、int、long",
    imgUrl:
        "https://images2015.cnblogs.com/blog/712650/201509/712650-20150901130405528-1386591357.jpg",
  ),
];
