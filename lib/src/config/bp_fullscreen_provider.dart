import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '../../generated/config/bp_fullscreen_provider.freezed.dart';

final bpFullscreenProvider = StateNotifierProvider<_BPFullscreenNotifier, BPFullscreenConfig>(
  (ref) => _BPFullscreenNotifier(),
);

class _BPFullscreenNotifier extends StateNotifier<BPFullscreenConfig> {
  _BPFullscreenNotifier() : super(BPFullscreenConfig());
}

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class BPFullscreenConfig with _$BPFullscreenConfig {
  const factory BPFullscreenConfig({
    ///Flag used to enable/disable fullscreen
    @Default(true)
        bool enableFullscreen,

    /// Defines if the player will start in fullscreen when play is pressed
    @Default(false)
        bool fullScreenByDefault,

    /// Defines if the player will sleep in fullscreen or not
    @Default(false)
        bool allowedScreenSleep,

    /// Defines the set of allowed device orientations on entering fullscreen
    @Default(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ])
        List<DeviceOrientation> deviceOrientationsOnFullScreen,

    /// Defines the system overlays visible after exiting fullscreen
    @Default(SystemUiOverlay.values)
        List<SystemUiOverlay> systemOverlaysAfterFullScreen,

    /// Defines the set of allowed device orientations after exiting fullscreen
    @Default([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ])
        List<DeviceOrientation> deviceOrientationsAfterFullScreen,

    ///Defines if player should auto detect full screen device orientation based
    ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
    ///video will played in full screen in portrait mode. If aspect ratio is >= 1
    ///then video will be played horizontally. If this parameter is true, then
    ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
    /// ignored.
    @Default(false)
        bool autoDetectFullscreenDeviceOrientation,

    /// Defines aspect ratio which will be used in fullscreen
    double? fullScreenAspectRatio,

    ///Defines if player should auto detect full screen aspect ration of the video.
    ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
    @Default(false)
        bool autoDetectFullscreenAspectRatio,
  }) = _BPFullscreenConfig;
}
