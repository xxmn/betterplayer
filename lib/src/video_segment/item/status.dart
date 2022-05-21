import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/video_segment/item/status.freezed.dart';

@freezed
class VideoSegmentItemStatus with _$VideoSegmentItemStatus {
  const factory VideoSegmentItemStatus({
    required double start,
    required double end,
    @Default(false) bool selectStart,
    @Default(false) bool selectEnd,
  }) = _VideoSegmentItemStatus;
}
