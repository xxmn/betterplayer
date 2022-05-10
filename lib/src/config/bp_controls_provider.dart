import 'package:better_player/src/types/bp_theme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bp_controls_provider.freezed.dart';

StateNotifierProvider<BPControlsNotifier, BPControlsConfig>? bpControlsConfigProvider;

void initBpControlsProvider(BPControlsConfig controlsConfig) {
  if (bpControlsConfigProvider == null) {
    bpControlsConfigProvider = StateNotifierProvider<BPControlsNotifier, BPControlsConfig>(
      (ref) => BPControlsNotifier(
        bpControlsConfig: controlsConfig,
      ),
    );
  }
}

void disposeBpControlsProvider() => bpControlsConfigProvider = null;

class BPControlsNotifier extends StateNotifier<BPControlsConfig> {
  BPControlsNotifier({
    BPControlsConfig? bpControlsConfig,
  }) : super(bpControlsConfig ?? BPControlsConfig());
}

///UI configuration of Better Player. Allows to change colors/icons/behavior
///of controls. Used in BPConfig. Config applies only
///for player displayed in app, not in notification or PiP mode.

@freezed
class BPControlsConfig with _$BPControlsConfig {
  // ///Custom items of overflow menu
  // List<BPOverflowMenuItem> overflowMenuCustomItems,

  const factory BPControlsConfig({
    ///Color of the control bars
    @Default(Colors.black87) Color controlBarColor,

    ///Color of texts
    @Default(Colors.white) Color textColor,

    ///Color of icons
    @Default(Colors.white) Color iconsColor,

    ///Icon of play
    @Default(Icons.play_arrow_outlined) IconData playIcon,

    ///Icon of pause
    @Default(Icons.pause_outlined) IconData pauseIcon,

    ///Icon of mute
    @Default(Icons.volume_up_outlined) IconData muteIcon,

    ///Icon of unmute
    @Default(Icons.volume_off_outlined) IconData unMuteIcon,

    ///Icon of fullscreen mode enable
    @Default(Icons.fullscreen_outlined) IconData fullscreenEnableIcon,

    ///Icon of fullscreen mode disable
    @Default(Icons.fullscreen_exit_outlined) IconData fullscreenDisableIcon,

    ///Cupertino only icon, icon of skip
    @Default(Icons.replay_10_outlined) IconData skipBackIcon,

    ///Cupertino only icon, icon of forward
    @Default(Icons.forward_10_outlined) IconData skipForwardIcon,

    ///Flag used to enable/disable mute
    @Default(true) bool enableMute,

    ///Flag used to enable/disable progress texts
    @Default(true) bool enableProgressText,

    ///Flag used to enable/disable progress bar
    @Default(true) bool enableProgressBar,

    ///Flag used to enable/disable progress bar drag
    @Default(true) bool enableProgressBarDrag,

    ///Flag used to enable/disable play-pause
    @Default(true) bool enablePlayPause,

    ///Flag used to enable skip forward and skip back
    @Default(true) bool enableSkips,

    ///Flag used to show/hide audio tracks
    @Default(true) bool enableAudioTracks,

    ///Progress bar played color
    @Default(Colors.white) Color progressBarPlayedColor,

    ///Progress bar circle color
    @Default(Colors.white) Color progressBarHandleColor,

    ///Progress bar buffered video color
    @Default(Colors.white70) Color progressBarBufferedColor,

    ///Progress bar background color
    @Default(Colors.white60) Color progressBarBackgroundColor,

    ///Time to hide controls

    @Default(Duration(milliseconds: 300)) Duration controlsHideTime,

    ///Parameter used to build custom controls
    Widget Function(Function(bool) onPlayerVisibilityChanged)? customControlsBuilder,

    ///Parameter used to change theme of the player
    BPTheme? playerTheme,

    ///Flag used to show/hide controls
    @Default(true) bool showControls,

    ///Flag used to show controls on init
    @Default(true) bool showControlsOnInitialize,

    ///Control bar height
    @Default(48.0) double controlBarHeight,

    ///Live text color,
    @Default(Colors.red) Color liveTextColor,

    ///Flag used to show/hide overflow menu which contains playback, subtitles,
    ///qualities options.
    @Default(true) bool enableOverflowMenu,

    ///Flag used to show/hide playback speed
    @Default(true) bool enablePlaybackSpeed,

    ///Flag used to show/hide subtitles
    @Default(true) bool enableSubtitles,

    ///Flag used to show/hide qualities
    @Default(true) bool enableQualities,

    ///Flag used to show/hide PiP mode
    @Default(true) bool enablePip,

    ///Flag used to enable/disable retry feature
    @Default(true) bool enableRetry,
    // this.overflowMenuCustomItems = const [],

    ///Icon of the overflow menu
    @Default(Icons.more_vert_outlined) IconData overflowMenuIcon,

    ///Icon of the PiP menu
    @Default(Icons.picture_in_picture_outlined) IconData pipMenuIcon,

    ///Icon of the playback speed menu item from overflow menu
    @Default(Icons.shutter_speed_outlined) IconData playbackSpeedIcon,

    ///Icon of the subtitles menu item from overflow menu
    @Default(Icons.closed_caption_outlined) IconData subtitlesIcon,

    ///Icon of the qualities menu item from overflow menu
    @Default(Icons.hd_outlined) IconData qualitiesIcon,

    ///Icon of the audios menu item from overflow menu
    @Default(Icons.audiotrack_outlined) IconData audioTracksIcon,

    ///Color of overflow menu icons
    @Default(Colors.black) Color overflowMenuIconsColor,

    ///Time which will be used once user uses forward
    @Default(10000) int forwardSkipTimeInMs,

    ///Time which will be used once user uses backward
    @Default(10000) int backwardSkipTimeInMs,

    ///Color of default loading indicator
    @Default(Colors.white) Color loadingColor,

    ///Widget which can be used instead of default progress
    Widget? loadingWidget,

    ///Color of the background, when no frame is displayed.
    @Default(Colors.black) Color backgroundColor,

    ///Color of the bottom modal sheet used for overflow menu items.
    @Default(Colors.white) Color overflowModalColor,

    ///Color of text in bottom modal sheet used for overflow menu items.
    @Default(Colors.black) Color overflowModalTextColor,
  }) = _BPControlsConfig;
}
