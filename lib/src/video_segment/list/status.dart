import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/video_segment/list/status.freezed.dart';

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class VideoSegmentListStatus with _$VideoSegmentListStatus {
  const factory VideoSegmentListStatus({
    required int length,
    @Default(true) bool? isShow,
    @Default(0) int index,
  }) = _VideoSegmentListStatus;
}
