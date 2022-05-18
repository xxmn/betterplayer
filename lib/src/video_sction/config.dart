import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../generated/video_sction/config.freezed.dart';

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class BPVideoSctionConfig with _$BPVideoSctionConfig {
  const factory BPVideoSctionConfig({
    required int length,
    @Default(true) bool? isShow,
    @Default(0) int index,
  }) = _BPVideoSctionConfig;
}
