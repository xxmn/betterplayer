import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading extends HookConsumerWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loadingWidget = ref.watch(bpControlsConfigProvider!.select((v) => v.loadingWidget));
    var loadingColor = ref.watch(bpControlsConfigProvider!.select((v) => v.loadingColor));
    var controlBarColor = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarColor));
    if (loadingWidget != null) {
      return Container(
        color: controlBarColor,
        child: loadingWidget,
      );
    }

    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
    );
  }
}
