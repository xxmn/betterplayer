import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybePlayOrPause extends HookConsumerWidget {
  const MaybePlayOrPause({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enablePlayPause = ref.watch(bpControlsConfigProvider!.select((v) => v.enablePlayPause));
    return enablePlayPause ? PlayOrPause() : const SizedBox();
  }
}

class PlayOrPause extends HookConsumerWidget {
  const PlayOrPause({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo: 视频未初始化时，按钮不可用
    // var initialized = ref.watch(npStatusProvider.select((v) => v.initialized));
    var isPlaying = ref.watch(npStatusProvider.select((v) => v.isPlaying));
    var isCompleted = ref.watch(npStatusProvider.select((v) => v.isCompleted));
    return isCompleted
        ? _ReplayIconButton()
        : isPlaying
            ? _PauseIconButton()
            : _PlayIconButton();
  }
}

class _PlayIconButton extends HookConsumerWidget {
  const _PlayIconButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var icon = ref.watch(bpControlsConfigProvider!.select((v) => v.playIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      key: const Key("better_player_material_controls_play_button"),
      onTap: ref.read(npStatusProvider.notifier).play,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(icon, color: iconsColor),
      ),
    );
  }
}

class _PauseIconButton extends HookConsumerWidget {
  const _PauseIconButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var icon = ref.watch(bpControlsConfigProvider!.select((v) => v.pauseIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      key: const Key("better_player_material_controls_pause_button"),
      onTap: ref.read(npStatusProvider.notifier).pause,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(icon, color: iconsColor),
      ),
    );
  }
}

class _ReplayIconButton extends HookConsumerWidget {
  const _ReplayIconButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      key: const Key("better_player_material_controls_replay_button"),
      onTap: ref.read(npStatusProvider.notifier).replay,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(Icons.replay, color: iconsColor),
      ),
    );
  }
}
