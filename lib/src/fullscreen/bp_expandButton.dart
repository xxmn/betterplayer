import 'package:better_player/src/config/bp_controls_provider.dart';
import 'page.dart';
import 'bp_config_provider.dart';
import 'bp_fullscreen_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeExpandButton extends HookConsumerWidget {
  const MaybeExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    var enableFullscreen = ref.watch(bpFullscreenConfigProvider.select((v) => v.enableFullscreen));
    return enableFullscreen ? ExpandButton() : const SizedBox();
  }
}

class ExpandButton extends HookConsumerWidget {
  const ExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    var controlsVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var exitIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenDisableIcon));
    var enterIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenEnableIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var isFullScreen = ref.watch(bpFullscreenProvider);

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: BPMaterialClickableWidget(
        onTap: () => isFullScreen ? exitFullscreenPage(ctx) : enterFullScreenPage(ctx, ref.read),
        child: AnimatedOpacity(
          opacity: controlsVisible ? 1.0 : 0.0,
          duration: controlsHideTime,
          child: Container(
            height: controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Icon(
                isFullScreen ? exitIcon : enterIcon,
                color: iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
