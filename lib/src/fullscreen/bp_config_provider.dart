import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '../../generated/fullscreen/bp_config_provider.freezed.dart';

final bpFullscreenConfigProvider = StateNotifierProvider<_BPFullscreenNotifier, BPFullscreenConfig>(
  (ref) => _BPFullscreenNotifier(),
);

class _BPFullscreenNotifier extends StateNotifier<BPFullscreenConfig> {
  _BPFullscreenNotifier() : super(BPFullscreenConfig());

  List<SystemUiOverlay> getOverlaysAfter() => state.systemOverlaysAfterFullScreen;
  List<DeviceOrientation> getOrientationsAfter() => state.deviceOrientationsAfterFullScreen;
  List<DeviceOrientation> getOrientations() => state.deviceOrientationsOnFullScreen;
  bool autoDetectOrientations() => state.autoDetectFullscreenDeviceOrientation;
  bool allowedSleep() => state.allowedScreenSleep;
}

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class BPFullscreenConfig with _$BPFullscreenConfig {
  const factory BPFullscreenConfig({
    /// Defines a custom RoutePageBuilder for the fullscreen
    final BPRoutePageBuilder? routePageBuilder,

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
    /// 自动检查全屏方向
    @Default(true)
        bool autoDetectFullscreenDeviceOrientation,

    ///Defines if player should auto detect full screen aspect ration of the video.
    ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
    /// 自动检查全屏时的比例
    @Default(true)
        bool autoDetectFullscreenAspectRatio,
  }) = _BPFullscreenConfig;
}

///Page route builder used in fullscreen mode.
typedef BPRoutePageBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
);
