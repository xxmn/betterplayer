import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bp_notification_provider.freezed.dart';

final bpNotificationProvider =
    StateNotifierProvider<_BPNotificationNotifier, _BPNotificationConfig>(
  (ref) => _BPNotificationNotifier(),
);

class _BPNotificationNotifier extends StateNotifier<_BPNotificationConfig> {
  _BPNotificationNotifier() : super(_BPNotificationConfig());
}

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class _BPNotificationConfig with _$_BPNotificationConfig {
  const factory _BPNotificationConfig({
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
  }) = __BPNotificationConfig;
}
