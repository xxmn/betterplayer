import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_hit_area_clickable_button.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MiddleRow extends HookConsumerWidget {
  const MiddleRow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlBarColor = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarColor));
    var enableSkips = ref.watch(bpControlsConfigProvider!.select((v) => v.enableSkips));
    var isLiveStream = ref.watch(bpDataSourceProvider!.select((v) => v?.isLiveStream ?? false));

    return Container(
      color: controlBarColor,
      width: double.infinity,
      height: double.infinity,
      child: isLiveStream
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (enableSkips) Expanded(child: SkipButton()) else const SizedBox(),
                Expanded(child: ReplayButton()),
                if (enableSkips) Expanded(child: ForwardButton()) else const SizedBox(),
              ],
            ),
    );
  }
}

class SkipButton extends HookConsumerWidget {
  const SkipButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var skipBackIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.skipBackIcon));
    return HitAreaClickableButton(
      icon: Icon(
        skipBackIcon,
        size: 24,
        color: iconsColor,
      ),
      onClicked: skipBack,
    );
  }
}

void skipBack() {
  print("skipBack");
  // todo:
  // if (latestValue != null) {
  //   cancelAndRestartTimer();
  //   final beginning = const Duration().inMilliseconds;
  //   final skip = (latestValue!.position -
  //           Duration(
  //               milliseconds: betterPlayerControlsConfiguration.backwardSkipTimeInMilliseconds))
  //       .inMilliseconds;
  //   betterPlayerController!.seekTo(Duration(milliseconds: max(skip, beginning)));
  // }
}

class ForwardButton extends HookConsumerWidget {
  const ForwardButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var skipForwardIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.skipForwardIcon));
    return HitAreaClickableButton(
      icon: Icon(
        skipForwardIcon,
        size: 24,
        color: iconsColor,
      ),
      onClicked: skipForward,
    );
  }
}

void skipForward() {
  print("skipForward");
  // todo:
  // if (latestValue != null) {
  //   cancelAndRestartTimer();
  //   final end = latestValue!.duration!.inMilliseconds;
  //   final skip = (latestValue!.position +
  //           Duration(
  //               milliseconds: betterPlayerControlsConfiguration
  //                   .forwardSkipTimeInMilliseconds))
  //       .inMilliseconds;
  //   betterPlayerController!.seekTo(Duration(milliseconds: min(skip, end)));
  // }
}

class ReplayButton extends HookConsumerWidget {
  const ReplayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var initialized = ref.watch(npStatusProvider.select((v) => v.initialized));
    var isPlaying = ref.watch(npStatusProvider.select((v) => v.isPlaying));
    var isCompleted = ref.watch(npStatusProvider.select((v) => v.isCompleted));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var pauseIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.pauseIcon));
    var playIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.playIcon));
    return HitAreaClickableButton(
      icon: isCompleted
          ? Icon(
              Icons.replay,
              size: 42,
              color: iconsColor,
            )
          : isPlaying
              ? Icon(
                  pauseIcon,
                  size: 42,
                  color: iconsColor,
                )
              : Icon(
                  playIcon,
                  size: 42,
                  color: iconsColor,
                ),
      onClicked: () {
        if (!initialized) return;
        var notifier = ref.read(npStatusProvider.notifier);
        isCompleted
            ? notifier.replay()
            : isPlaying
                ? notifier.pause()
                : notifier.play();
      },
    );
  }
}
