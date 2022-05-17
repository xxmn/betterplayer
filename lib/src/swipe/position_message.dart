import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'position_provider.dart';

class MaybeShowPositionMessage extends HookConsumerWidget {
  const MaybeShowPositionMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isShow = ref.watch(dragIsShowPositionProvider);
    return isShow ? _PositionMessage() : SizedBox();
  }
}

class _PositionMessage extends HookConsumerWidget {
  const _PositionMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var p = ref.watch(dragChangePositionProvider);
    var duration = ref.watch(npStatusProvider.select((v) => v.duration));
    return Center(
      child: Container(
        width: 120,
        color: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${BPUtils.formatDuration(p)}"),
            Text(" / ${BPUtils.formatDuration(duration ?? Duration.zero)}"),
          ],
        ),
      ),
    );
  }
}
