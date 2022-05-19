import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bp_middleRow.dart';

class MaybeHitArea extends HookConsumerWidget {
  const MaybeHitArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsEnabled = ref.watch(bpConfigProvider!.select((v) => v.controlsEnabled));
    return controlsEnabled ? HitArea() : SizedBox();
  }
}

class HitArea extends HookConsumerWidget {
  const HitArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    return Container(
      child: Center(
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: controlsHideTime,
          child: MiddleRow(),
        ),
      ),
    );
  }
}
