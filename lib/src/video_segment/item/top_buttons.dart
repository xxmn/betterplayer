import 'dart:async';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:better_player/src/video_segment/controls/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'current_provider.dart';
import 'status_provider.dart';

class VideoSegmentItemTopButtons extends HookConsumerWidget {
  Timer? timer;
  VideoSegmentItemTopButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return () => timer?.cancel();
    }, const []);

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
            var p = ref.read(npStatusProvider.notifier).getPosition();
            isStart
                ? ref.read(itemCurrentProvider.notifier).setStart(p)
                : ref.read(itemCurrentProvider.notifier).setEnd(p);
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
          label: const Icon(Icons.replay_5),
          onPressed: () {
            var t = isStart
                ? ref.read(itemCurrentProvider.notifier).start
                : ref.read(itemCurrentProvider.notifier).end;
            var s5 = Duration(seconds: 5);
            var r = t > s5 ? t - s5 : Duration.zero;
            timer?.cancel();
            ref.read(npStatusProvider.notifier).seekToAndPlay(r);
          },
        ),
        MyButton(
          isEnable: true,
          label: const Icon(Icons.play_arrow),
          onPressed: () {
            var t = !isEnd
                ? ref.read(itemCurrentProvider.notifier).start
                : ref.read(itemCurrentProvider.notifier).end;
            !isEnd ? _playStart(t, ref.read) : _playEnd(t, ref.read);
          },
        ),

        //TODO: 截图功能
      ],
    );
  }

  void _playStart(Duration start, Reader read) {
    timer?.cancel();
    read(npStatusProvider.notifier).seekToAndPlay(start);
  }

  void _playEnd(Duration end, Reader read) async {
    var d = Duration(seconds: 5);
    var t = end - d;
    timer?.cancel();
    await read(npStatusProvider.notifier).seekToAndPlay(t);
    timer = Timer(d, read(npStatusProvider.notifier).pause);
  }
}
