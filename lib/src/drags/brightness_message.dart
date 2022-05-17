import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'brightness_provider.dart';

class MaybeShowBrightnessMessage extends HookConsumerWidget {
  const MaybeShowBrightnessMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isShow = ref.watch(dragIsShowBrightnessProvider);
    return isShow ? _BrightnessMessage() : SizedBox();
  }
}

class _BrightnessMessage extends HookConsumerWidget {
  const _BrightnessMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var br = ref.watch(dragChangeBrightnessProvider);
    return Center(
      child: Container(
        width: 80,
        color: Colors.white70,
        child: Row(
          children: [
            Text("亮度:"),
            Text("${(br * 100).toInt()} %"),
          ],
        ),
      ),
    );
  }
}
