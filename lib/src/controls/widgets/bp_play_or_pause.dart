import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybePlayOrPause extends HookConsumerWidget {
  const MaybePlayOrPause({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enablePlayPause = ref.watch(bpControlsProvider!.select((v) => v.enablePlayPause));
    return enablePlayPause ? PlayOrPause() : const SizedBox();
  }
}

class PlayOrPause extends HookConsumerWidget {
  const PlayOrPause({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isPlaying = ref.watch(bpPlayingStatusProvider!.select((v) => v.isPlaying));
    var pauseIcon = ref.watch(bpControlsProvider!.select((v) => v.pauseIcon));
    var playIcon = ref.watch(bpControlsProvider!.select((v) => v.playIcon));
    var iconsColor = ref.watch(bpControlsProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      key: const Key("better_player_material_controls_play_pause_button"),
      onTap: _onPlayPause,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(
          isPlaying ? pauseIcon : playIcon,
          color: iconsColor,
        ),
      ),
    );
  }
}

void _onPlayPause() {
  print("_onPlayPause");
  // bool isFinished = false;

  // if (_latestValue?.position != null && _latestValue?.duration != null) {
  //   isFinished = _latestValue!.position >= _latestValue!.duration!;
  // }

  // if (_controller!.value.isPlaying) {
  //   changePlayerControlsNotVisible(false);
  //   _hideTimer?.cancel();
  //   _betterPlayerController!.pause();
  // } else {
  //   cancelAndRestartTimer();

  //   if (!_controller!.value.initialized) {
  //   } else {
  //     if (isFinished) {
  //       _betterPlayerController!.seekTo(const Duration());
  //     }
  //     _betterPlayerController!.play();
  //     _betterPlayerController!.cancelNextVideoTimer();
  //   }
  // }
}
