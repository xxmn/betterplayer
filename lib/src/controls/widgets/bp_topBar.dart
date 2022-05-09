import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_more_button.dart';
import 'bp_pip_button.dart';

class MaybeTopBar extends HookConsumerWidget {
  const MaybeTopBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsEnabled = ref.watch(bpConfigProvider!.select((v) => v.controlsEnabled));

    if (!controlsEnabled) {
      return const SizedBox();
    }

    var enableOverflowMenu = ref.watch(bpControlsProvider!.select((v) => v.enableOverflowMenu));
    return Container(
      child: (enableOverflowMenu) ? TopBar() : const SizedBox(),
    );
  }
}

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsVisible = ref.watch(bpControlsVisibleProvider);
    var controlsHideTime = ref.watch(bpControlsProvider!.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsProvider!.select((v) => v.controlBarHeight));
    var enablePip = !ref.watch(bpControlsProvider!.select((v) => v.enablePip));
    return AnimatedOpacity(
      opacity: controlsVisible ? 1.0 : 0.0,
      duration: controlsHideTime,
      onEnd: ref.read(bpControlsVisibleProvider.notifier).toggle,
      child: Container(
        height: controlBarHeight,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (enablePip) MaybePipButton() else const SizedBox(),
            MoreButton(),
          ],
        ),
      ),
    );
  }
}
