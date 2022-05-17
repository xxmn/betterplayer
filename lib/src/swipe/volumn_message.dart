import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'volumn_provider.dart';

class MaybeShowVolumnMessage extends HookConsumerWidget {
  const MaybeShowVolumnMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isShow = ref.watch(dragIsShowVolumnProvider);
    return isShow ? _VolumnMessage() : SizedBox();
  }
}

class _VolumnMessage extends HookConsumerWidget {
  const _VolumnMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var volume = ref.watch(dragChangeVolumnProvider);
    return Center(
      child: Container(
        width: 80,
        color: Colors.white70,
        child: Row(
          children: [
            Text("音量:"),
            Text("${(volume * 100).toInt()} %"),
          ],
        ),
      ),
    );
  }
}
