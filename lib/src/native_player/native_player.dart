import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';

/// Widget that displays the video controlled by [controller].
class NativePlayer extends HookConsumerWidget {
  const NativePlayer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textureId = ref.watch(npCreateProvider!.select((v) => v.textureId));
    return textureId != null ? npPlatform.buildView(textureId) : SizedBox();
  }
}
