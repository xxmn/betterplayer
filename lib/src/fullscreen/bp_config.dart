import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/fullscreen/bp_config.freezed.dart';

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class BPFullScreenConfig with _$BPFullScreenConfig {
  const factory BPFullScreenConfig({
    /// Defines a custom RoutePageBuilder for the fullscreen
    final BPRoutePageBuilder? routePageBuilder,

    ///Flag used to enable/disable fullscreen
    @Default(true)
        bool enableFullScreen,

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
    /// 自动检查全屏方向
    @Default(true)
        bool autoDetectFullScreenDeviceOrientation,

    ///Defines if player should auto detect full screen aspect ration of the video.
    ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
    /// 自动检查全屏时的比例
    @Default(true)
        bool autoDetectFullScreenAspectRatio,
  }) = _BPFullScreenConfig;
}

///Page route builder used in fullscreen mode.
typedef BPRoutePageBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
);
