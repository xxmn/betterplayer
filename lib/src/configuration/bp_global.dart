import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/bp_data_source_notifier.dart';
import 'package:better_player/src/core/bp_notifier.dart';
import 'package:better_player/src/core/bp_translations_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///Cfg of Better Player. Allows to setup general behavior of player.
///Master configuration which contains children that configure specific part
///of player.
///全局变量，不能多次修改

class BPGlobal {
  static late final BPNotifier g_bpNotifier;
  static void setGlobalBpNotifier(BuildContext context) {
    // context.read<BPNotifier>();
    g_bpNotifier = Provider.of<BPNotifier>(context, listen: false);
  }

  static late final BPTranslationsNotifier g_translationsNotifier;
  static void setGlobalTranslationsNotifier(BuildContext context) {
    // context.read<BPNotifier>();
    g_translationsNotifier = Provider.of<BPTranslationsNotifier>(context, listen: false);
  }

  static late final BPDataSourceNotifier g_bpDataSourceNotifier;
  static void setGlobalBPDataSourceNotifier(BuildContext context) {
    // context.read<BPNotifier>();
    g_bpDataSourceNotifier = Provider.of<BPDataSourceNotifier>(context, listen: false);
  }

  /// When the video playback runs  into an error; you can build a custom
  /// error message.
  static late final Widget Function(BuildContext context, String? errorMessage)? g_errorBuilder;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  static late final Widget? g_placeholder;

  /// Should the placeholder be shown until play is pressed
  static late final bool g_showPlaceholderUntilPlay;

  /// Placeholder position of player stack. If false; then placeholder will be
  /// displayed on the bottom; so user need to hide it manually. Default is
  /// true.
  static late final bool g_placeholderOnTop;

  /// A widget which is placed between the video and the controls
  static late final Widget? g_overlay;

  /// Defines if the player will start in fullscreen when play is pressed
  static late final bool g_fullScreenByDefault;

  /// Defines if the player will sleep in fullscreen or not
  static late final bool g_allowedScreenSleep;

  /// Defines the set of allowed device orientations on entering fullscreen
  static late final List<DeviceOrientation> g_deviceOrientationsOnFullScreen;

  /// Defines the system overlays visible after exiting fullscreen
  static late final List<SystemUiOverlay> g_systemOverlaysAfterFullScreen;

  /// Defines the set of allowed device orientations after exiting fullscreen
  static late final List<DeviceOrientation> g_deviceOrientationsAfterFullScreen;

  /// Defines a custom RoutePageBuilder for the fullscreen
  static late final BPRoutePageBuilder? g_routePageBuilder;

  /// Defines a event listener where video player events will be send
  static late final Function(BPEvent)? g_eventListener;

  ///Defines fit of the video; allows to fix video stretching; see possible
  ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
  static late final BoxFit g_fit;

  ///Defines rotation of the video in degrees. Default value is 0. Can be 0; 90; 180; 270.
  ///Angle will rotate only video box; controls will be in the same place.
  static late final double g_rotation;

  ///Defines function which will react on player visibility changed
  static late final Function(double visibilityFraction)? g_playerVisibilityChangedBehavior;

  ///Defines translations used in player. If null; then default english translations
  ///will be used.
  static late final List<BPTranslations>? g_translations;

  ///Defines if player should auto detect full screen device orientation based
  ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
  ///video will played in full screen in portrait mode. If aspect ratio is >= 1
  ///then video will be played horizontally. If this parameter is true; then
  ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
  /// ignored.
  static late final bool g_autoDetectFullscreenDeviceOrientation;

  ///Defines if player should auto detect full screen aspect ration of the video.
  ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
  static late final bool g_autoDetectFullscreenAspectRatio;

  ///Defines flag which enabled/disabled auto dispose of
  ///[BPController] on [BP] dispose. When it's true and
  ///[BPController] instance has been attached to [BP] widget
  ///and dispose has been called on [BP] instance; then
  ///[BPController] will be disposed.
  ///Default value is true.
  static late final bool g_autoDispose;

  ///Flag which causes to player expand to fill all remaining space. Set to false
  ///to use minimum constraints
  static late final bool g_expandToFill;

  ///Flag which causes to player use the root navigator to open new pages.
  ///Default value is false.
  static late final bool g_useRootNavigator;

  BPGlobal({
    bool fullScreenByDefault = false,
    Widget? placeholder,
    bool showPlaceholderUntilPlay = false,
    bool placeholderOnTop = true,
    Widget? overlay,
    Widget Function(BuildContext context, String? errorMessage)? errorBuilder,
    bool allowedScreenSleep = true,
    double? fullScreenAspectRatio,
    List<DeviceOrientation> deviceOrientationsOnFullScreen = const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
    List<SystemUiOverlay> systemOverlaysAfterFullScreen = SystemUiOverlay.values,
    List<DeviceOrientation> deviceOrientationsAfterFullScreen = const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
    BPRoutePageBuilder? routePageBuilder,
    Function(BPEvent)? eventListener,
    BoxFit fit = BoxFit.fill,
    double rotation = 0,
    Function(double visibilityFraction)? playerVisibilityChangedBehavior,
    List<BPTranslations>? translations,
    bool autoDetectFullscreenDeviceOrientation = false,
    bool autoDetectFullscreenAspectRatio = false,
    bool autoDispose = true,
    bool expandToFill = true,
    bool useRootNavigator = false,
  }) {
    g_fullScreenByDefault = fullScreenByDefault;
    g_placeholder = placeholder;
    g_showPlaceholderUntilPlay = showPlaceholderUntilPlay;
    g_placeholderOnTop = placeholderOnTop;
    g_overlay = overlay;
    g_errorBuilder = errorBuilder;
    g_allowedScreenSleep = allowedScreenSleep;
    g_deviceOrientationsOnFullScreen = deviceOrientationsOnFullScreen;
    g_systemOverlaysAfterFullScreen = systemOverlaysAfterFullScreen;
    g_deviceOrientationsAfterFullScreen = deviceOrientationsAfterFullScreen;
    g_routePageBuilder = routePageBuilder;
    g_eventListener = eventListener;
    g_fit = fit;
    g_rotation = rotation;
    g_playerVisibilityChangedBehavior = playerVisibilityChangedBehavior;
    g_translations = translations;
    g_autoDetectFullscreenDeviceOrientation = autoDetectFullscreenDeviceOrientation;
    g_autoDetectFullscreenAspectRatio = autoDetectFullscreenAspectRatio;
    g_autoDispose = autoDispose;
    g_expandToFill = expandToFill;
    g_useRootNavigator = useRootNavigator;
  }
}
