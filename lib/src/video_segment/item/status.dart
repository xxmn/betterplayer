import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/video_segment/item/status.freezed.dart';

@freezed
class VideoSegmentItemStatus with _$VideoSegmentItemStatus {
  const factory VideoSegmentItemStatus({
    @Default(Duration(seconds: 0)) Duration progressStart,
    @Default(Duration(minutes: 10)) Duration progressDuration,
    @Default(false) bool selectStart,
    @Default(false) bool selectEnd,

    // 是否新增segment
    @Default(false) bool isNew,
    @Default(false) bool isUpdated,
  }) = _VideoSegmentItemStatus;
}
