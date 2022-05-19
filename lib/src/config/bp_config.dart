import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/config/bp_config.freezed.dart';

///Config of Better Player. Allows to setup general behavior of player.
///Master configuration which contains children that configure specific part
///of player.
@freezed
class BPConfig with _$BPConfig {
  @Assert('rotation <= 360')
  @Assert('rotation % 90 == 0')
  const factory BPConfig({
    /// When the video playback runs  into an error, you can build a custom
    /// error message.
    Widget Function(BuildContext context, String? errorMessage)? errorBuilder,

    /// The placeholder is displayed underneath the Video before it is initialized
    /// or played.
    Widget? placeholder,

    ///Flag which determines if controls (UI interface) is shown. When false,
    ///UI won't be shown (show only player surface).
    @Default(true) bool controlsEnabled,

    /// True if the video is looping.  默认值
    @Default(false) bool isLooping,

    /// Play the video as soon as it's displayed  false，默认值
    @Default(false) bool isAutoPlay,

    /// Placeholder position of player stack. If false, then placeholder will be
    /// displayed on the bottom, so user need to hide it manually. Default is
    /// true.
    @Default(true) bool placeholderOnTop,

    /// Should the placeholder be shown until play is pressed
    @Default(false) bool showPlaceholderUntilPlay,

    /// A widget which is placed between the video and the controls
    Widget? overlay,

    ///Flag which causes to player use the root navigator to open new pages.
    ///Default value is false.
    @Default(false) bool useRootNavigator,

    // /// Defines a event listener where video player events will be send
    // final Function(BPEvent)? eventListener;

    ///Defines fit of the video, allows to fix video stretching, see possible
    ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
    @Default(BoxFit.contain) BoxFit fit,

    /// 强制指定比例
    double? aspectRatio,

    ///Flag which causes to player expand to fill all remaining space. Set to false
    ///to use minimum constraints
    @Default(true) bool expandToFill,

    ///Defines rotation of the video in degrees. Default value is 0. Can be 0, 90, 180, 270.
    ///Angle will rotate only video box, controls will be in the same place.

    // rotation <= 360 && rotation % 90 == 0
    @Default(0) int rotation,

    ///Defines function which will react on player visibility changed
    Function(double visibilityFraction)? playerVisibilityChangedBehavior,

    // ///Defines translations used in player. If null, then default english translations
    // ///will be used.
    // final List<BPTranslations>? translations;

    ///Defines flag which enabled/disabled auto dispose of
    ///[BPController] on [BetterPlayer] dispose. When it's true and
    ///[BPController] instance has been attached to [BetterPlayer] widget
    ///and dispose has been called on [BetterPlayer] instance, then
    ///[BPController] will be disposed.
    ///Default value is true.
    @Default(true) bool autoDispose,

    // this.routePageBuilder,
    // this.eventListener,
    // this.translations,
  }) = _BPConfig;
}
