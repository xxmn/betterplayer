import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeProgressBar extends HookConsumerWidget {
  const MaybeProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableProgressBar = ref.watch(bpControlsProvider!.select((v) => v.enableProgressBar));
    return enableProgressBar ? ProgressBar() : const SizedBox();
  }
}

class ProgressBar extends HookConsumerWidget {
  const ProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 40,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text("BPMaterialVideoProgressBar"),
        // child: BPMaterialVideoProgressBar(
        //   onDragStart: () {
        //     // _hideTimer?.cancel();
        //   },
        //   onDragEnd: () {
        //     // _startHideTimer();
        //   },
        //   onTapDown: () {
        //     // cancelAndRestartTimer();
        //   },
        //   // colors: BPProgressColors(
        //   //   playedColor: _controlsConfig.progressBarPlayedColor,
        //   //   handleColor: _controlsConfig.progressBarHandleColor,
        //   //   bufferedColor: _controlsConfig.progressBarBufferedColor,
        //   //   backgroundColor: _controlsConfig.progressBarBackgroundColor,
        //   // ),
        // ),
      ),
    );
  }
}
