import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/video_segment/segment.freezed.dart';

@freezed
class Segment with _$Segment {
  const factory Segment({
    @Default(0) int id,
    @Default(Duration.zero) Duration start, // in millisecond
    required Duration end, // in millisecond

    required String title,
    String? desc,
    String? imgUrl,
  }) = _Segment;
  // {
  //   if (duration != null) {
  //     end = start + duration!;
  //   }
  //   if (end != null) {
  //     duration = end! - start;
  //   }
  // }
}
