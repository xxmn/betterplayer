import 'package:better_player/src/video_segment/controls/button.dart';
import 'package:better_player/src/video_segment/is_show_list_provider.dart';
import 'package:better_player/src/video_segment/provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'current_provider.dart';
import 'status_provider.dart';

class VideoSegmentItemBottomButtons extends HookConsumerWidget {
  const VideoSegmentItemBottomButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _SaveButton(),
        _RemoveButton(),
        Spacer(),
        IconButton(
          onPressed: () => ref.read(isShowListProvider.state).state = true,
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}

class _SaveButton extends HookConsumerWidget {
  const _SaveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isUpdated = ref.watch(itemStatusProvider.select((v) => v.isUpdated));
    var isNew = ref.watch(itemStatusProvider.select((v) => v.isNew));
    return MyButton(
      label: Text(isNew ? "保存" : "更新"),
      isEnable: isUpdated,
      onPressed: () {
        var s = ref.read(itemCurrentProvider);
        print("itemCurrentProvider state:${s}");
        ref.read(videoSegmentsProvider.notifier).addOrUpdate(s);
        ref.read(isShowListProvider.state).state = true;
      },
    );
  }
}

class _RemoveButton extends HookConsumerWidget {
  const _RemoveButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyButton(
      label: const Text("删除"),
      isEnable: true,
      onPressed: () {
        var s = ref.read(itemCurrentProvider);
        ref.read(videoSegmentsProvider.notifier).remove(s.id);
        ref.read(isShowListProvider.state).state = true;
      },
    );
  }
}
