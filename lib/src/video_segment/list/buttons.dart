import 'package:better_player/src/video_segment/is_show_list_provider.dart';
import 'package:better_player/src/video_segment/item/current_provider.dart';
import 'package:better_player/src/video_segment/item/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddVideoSegmentItemButton extends HookConsumerWidget {
  const AddVideoSegmentItemButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AbsorbPointer(
        absorbing: false,
        child: IconButton(
          onPressed: () {
            ref.read(itemCurrentProvider.notifier).newSegment();
            ref.read(itemStatusProvider.notifier)
              ..setProgressStart(Duration.zero)
              ..setProgressDuration(Duration(minutes: 2));
            ref.read(isShowListProvider.state).state = false;
          },
          icon: Icon(Icons.add),
          color: Colors.blueAccent,
          iconSize: 28,
        ),
      ),
    );
  }
}
