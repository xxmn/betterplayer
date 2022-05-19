import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NextVideo extends HookConsumerWidget {
  const NextVideo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlBarColor = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarColor));
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var nextVideoIn = ref.watch(bpTranslationsProvider!.select((v) => v.controlsNextVideoIn));

    // todo: next video

    return BPMaterialClickableWidget(
      onTap: () {
        print("NextVideo on tap");
        // _betterPlayerController!.playNextVideo();
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(bottom: controlBarHeight + 20, right: 24),
          decoration: BoxDecoration(
            color: controlBarColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "${nextVideoIn}...", // todo: next video time
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
