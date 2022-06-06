import 'package:better_player/src/video_segment/controls/button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'current_provider.dart';
import 'status_provider.dart';

class VideoSegmentItemTopButtons extends HookConsumerWidget {
  const VideoSegmentItemTopButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isStart = ref.watch(itemStatusProvider.select((v) => v.selectStart));
    var isEnd = ref.watch(itemStatusProvider.select((v) => v.selectEnd));
    var isEnable = isStart || isEnd;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyButton(
          isEnable: isEnable,
          label: const Text("设置"),
          onPressed: () {
            print("-------------------new-------------------");
          },
        ),

        MyButton(
          isEnable: isEnable,
          label: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isStart) ref.read(itemCurrentProvider.notifier).decreaseStart();
            if (isEnd) ref.read(itemCurrentProvider.notifier).decreaseEnd();
          },
        ),

        MyButton(
          isEnable: isEnable,
          label: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (isStart) ref.read(itemCurrentProvider.notifier).increaseStart();
            if (isEnd) ref.read(itemCurrentProvider.notifier).increaseEnd();
          },
        ),

        MyButton(
          isEnable: isEnable,
          label: const Icon(Icons.replay_10),
          onPressed: () {
            print("-------------------replay_10-------------------");
          },
        ),
        _ReplyButton(),

        //TODO: 截图功能
      ],
    );
  }
}

class _ReplyButton extends HookConsumerWidget {
  const _ReplyButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: replay 调节判断
    // var canReplay = ref.watch(itemCurrentProvider.select((v) => v.start));
    var canReplay = true;
    return MyButton(
      isEnable: canReplay,
      label: const Icon(Icons.replay),
      onPressed: () {
        print("-------------------replay-------------------");
      },
    );
  }
}
