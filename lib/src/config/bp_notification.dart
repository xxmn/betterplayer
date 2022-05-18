import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/config/bp_notification.freezed.dart';

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class BPNtConfig with _$BPNtConfig {
  const factory BPNtConfig({
    ///Is player controls notification enabled
    @Default(false) bool? isShow,

    ///Title of the given data source, used in controls notification
    String? title,

    ///Author of the given data source, used in controls notification
    String? author,

    ///Image of the video, used in controls notification
    String? imageUrl,

    ///Name of the notification channel. Used only in Android.
    String? channelName,

    ///Name of activity used to open application from notification. Used only
    ///in Android.
    String? activityName,
  }) = _BPNtConfig;
}
