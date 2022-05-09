import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/widgets/bp_mute_button.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_expandButton.dart';
import 'bp_play_or_pause.dart';
import 'bp_positon_or_live.dart';
import 'bp_progressBar.dart';

class MaybeBottomBars extends HookConsumerWidget {
  const MaybeBottomBars({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsEnabled = ref.watch(bpConfigProvider!.select((v) => v.controlsEnabled));
    return controlsEnabled ? _BottomBars() : const SizedBox();
  }
}

class _BottomBars extends HookConsumerWidget {
  const _BottomBars({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlBarHeight = ref.watch(bpControlsProvider!.select((v) => v.controlBarHeight));
    var isLiveStream = ref.watch(bpDataSourceProvider!.select((v) => v?.isLiveStream ?? false));
    var controlsVisible = ref.watch(bpControlsVisibleProvider);
    var controlsHideTime = ref.watch(bpControlsProvider!.select((v) => v.controlsHideTime));
    return AnimatedOpacity(
      opacity: controlsVisible ? 1.0 : 0.0,
      duration: controlsHideTime,
      onEnd: () => _onPlayerHide(ref.read),
      child: Container(
        height: controlBarHeight + 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 75,
              child: Row(
                children: [
                  MaybePlayOrPause(),
                  PositonOrLive(),
                  const Spacer(),
                  MaybeMuteButton(),
                  MaybeExpandButton(),
                ],
              ),
            ),
            if (isLiveStream) const SizedBox() else MaybeProgressBar(),
          ],
        ),
      ),
    );
  }
}

void _onPlayerHide(T Function<T>(ProviderBase<T>) read) {
  read(bpControlsVisibleProvider.notifier).setVisible(false);
}
