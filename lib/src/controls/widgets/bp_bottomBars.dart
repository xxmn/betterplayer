import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/controls/widgets/bp_mute_button.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/progress/bp_progressBar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../fullscreen/bp_expandButton.dart';
import 'bp_play_or_pause.dart';
import 'bp_positon_or_live.dart';
import 'speed_button.dart';

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
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var isLiveStream = ref.watch(bpDataSourceProvider!.select((v) => v?.isLiveStream ?? false));
    var showControls = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    return AnimatedOpacity(
      opacity: showControls ? 1.0 : 0.0,
      duration: controlsHideTime,
      onEnd: () => _onPlayerHide(ref.read),
      child: Container(
        height: controlBarHeight + 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaybePlayOrPause(),
                  // PositonOrLive(),
                  // const Spacer(),
                  if (isLiveStream)
                    const Spacer()
                  else
                    Expanded(
                      flex: 1,
                      child: MaybeProgressBar(),
                    ),
                  SpeedButton(),
                  MaybeMuteButton(),
                  MaybeExpandButton(),
                ],
              ),
            ),
            // if (isLiveStream) const SizedBox() else MaybeProgressBar(),
          ],
        ),
      ),
    );
  }
}

void _onPlayerHide(T Function<T>(ProviderBase<T>) read) {
  // read(bpShowControlsProvider.notifier).toggle();
}
