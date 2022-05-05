import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeMuteButton extends HookConsumerWidget {
  const MaybeMuteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableMute = ref.watch(bpControlsProvider.select((v) => v.enableMute));
    return enableMute ? MuteButton() : const SizedBox();
  }
}

class MuteButton extends HookConsumerWidget {
  const MuteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsVisible = ref.watch(bpControlsVisibleProvider);
    var controlsHideTime = ref.watch(bpControlsProvider.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsProvider.select((v) => v.controlBarHeight));
    var muteIcon = ref.watch(bpControlsProvider.select((v) => v.muteIcon));
    var unMuteIcon = ref.watch(bpControlsProvider.select((v) => v.unMuteIcon));
    var iconsColor = ref.watch(bpControlsProvider.select((v) => v.iconsColor));
    var volume = ref.watch(bpPlayingStatusProvider.select((v) => v.volume));
    return BPMaterialClickableWidget(
      onTap: () {
        print("MuteButton on tap");
        // cancelAndRestartTimer();
        // if (_latestValue!.volume == 0) {
        //   _betterPlayerController!.setVolume(_latestVolume ?? 0.5);
        // } else {
        //   _latestVolume = controller!.value.volume;
        //   _betterPlayerController!.setVolume(0.0);
        // }
      },
      child: AnimatedOpacity(
        opacity: controlsVisible ? 1.0 : 0.0,
        duration: controlsHideTime,
        child: ClipRect(
          child: Container(
            height: controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              volume > 0 ? muteIcon : unMuteIcon,
              color: iconsColor,
            ),
          ),
        ),
      ),
    );
  }
}
