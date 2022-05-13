import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/locked/buttons.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LockedPage extends HookConsumerWidget {
  const LockedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlBarColor = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarColor));
    var isVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: controlsHideTime,
      child: Container(
        color: controlBarColor,
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LockedButton(),
          ],
        ),
      ),
    );
  }
}
