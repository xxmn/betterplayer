import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_fullscreen_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeExpandButton extends HookConsumerWidget {
  const MaybeExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableFullscreen = ref.watch(bpFullscreenProvider.select((v) => v.enableFullscreen));
    return enableFullscreen ? ExpandButton() : const SizedBox();
  }
}

class ExpandButton extends HookConsumerWidget {
  const ExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var disableIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenDisableIcon));
    var enableIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenEnableIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var isFullScreen = ref.watch(bpPlayingStatusProvider!.select((v) => v.isFullScreen));

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: BPMaterialClickableWidget(
        onTap: () => _onExpandCollapse(ref.read),
        child: AnimatedOpacity(
          opacity: controlsVisible ? 1.0 : 0.0,
          duration: controlsHideTime,
          child: Container(
            height: controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Icon(
                isFullScreen ? disableIcon : enableIcon,
                color: iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _onExpandCollapse(T Function<T>(ProviderBase<T>) read) {
  // read(bpShowControlsProvider.notifier).toggle();

  //todo:
  // _betterPlayerController!.toggleFullScreen();
}
