import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeMuteButton extends HookConsumerWidget {
  const MaybeMuteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableMute = ref.watch(bpControlsConfigProvider!.select((v) => v.enableMute));
    return enableMute ? MuteButton() : const SizedBox();
  }
}

class MuteButton extends StatefulHookConsumerWidget {
  const MuteButton({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MuteButtonState();
}

class _MuteButtonState extends ConsumerState<MuteButton> {
  double? _latestVolume;

  @override
  Widget build(BuildContext context) {
    var controlsVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var muteIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.muteIcon));
    var unMuteIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.unMuteIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var volume = ref.watch(npStatusProvider.select((v) => v.volume));
    return BPMaterialClickableWidget(
      onTap: () {
        if (volume < 0.001) {
          ref.read(npStatusProvider.notifier).setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = volume;
          ref.read(npStatusProvider.notifier).setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: controlsVisible ? 1.0 : 0.0,
        duration: controlsHideTime,
        child: ClipRect(
          child: Container(
            height: controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              volume > 0.001 ? muteIcon : unMuteIcon,
              color: iconsColor,
            ),
          ),
        ),
      ),
    );
  }
}
