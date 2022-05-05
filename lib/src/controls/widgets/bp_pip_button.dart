import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/core/bp_pip_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybePipButton extends HookConsumerWidget {
  const MaybePipButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: ref.read(bpPIPProvider.notifier).isPictureInPictureSupported(),
      builder: (context, snapshot) {
        // var bpGKey = ref.watch()
        final bool isPipSupported = snapshot.data ?? false;
        // todo:
        // if (isPipSupported && _betterPlayerController!.betterPlayerGlobalKey != null) {
        if (isPipSupported) {
          return _AnimatedPipButton();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _AnimatedPipButton extends HookConsumerWidget {
  const _AnimatedPipButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsHideTime = ref.watch(bpControlsProvider.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsProvider.select((v) => v.controlBarHeight));
    var controlsVisible = ref.watch(bpControlsVisibleProvider);
    return AnimatedOpacity(
      opacity: controlsVisible ? 1.0 : 0.0,
      duration: controlsHideTime,
      onEnd: () => _onPlayerHide(ref.read),
      child: Container(
        height: controlBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PipButton(),
          ],
        ),
      ),
    );
  }
}

class PipButton extends HookConsumerWidget {
  const PipButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pipMenuIcon = ref.watch(bpControlsProvider.select((v) => v.pipMenuIcon));
    var iconsColor = ref.watch(bpControlsProvider.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      onTap: () {
        // todo:
        // betterPlayerController!
        //     .enablePictureInPicture(betterPlayerController!.betterPlayerGlobalKey!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          pipMenuIcon,
          color: iconsColor,
        ),
      ),
    );
  }
}

void _onPlayerHide(T Function<T>(ProviderBase<T>) read) {
  read(bpControlsVisibleProvider.notifier).toggle();
}