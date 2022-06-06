import 'package:better_player/src/video_segment/provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'is_show_list_provider.dart';
import 'item/page.dart';
import 'list/page.dart';

class VideoSegmentListOrItemPage extends HookConsumerWidget {
  const VideoSegmentListOrItemPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isList = ref.watch(isShowListProvider);
    if (isList) {
      var segments = ref.watch(videoSegmentsProvider);
      return segments == null || segments.isEmpty ? SizedBox() : VideoSegmentListPage(segments);
    } else {
      return VideoSegmentItemPage();
    }
  }
}
