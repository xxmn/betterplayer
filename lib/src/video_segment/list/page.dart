import 'package:better_player/src/utils/bp_utils.dart' show BPUtils;
import 'package:better_player/src/video_segment/is_show_list_provider.dart';
import 'package:better_player/src/video_segment/item/current_provider.dart';
import 'package:better_player/src/video_segment/item/status_provider.dart';
import 'package:better_player/src/video_segment/provider.dart';
import 'package:better_player/src/video_segment/segment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'buttons.dart';

class VideoSegmentListPage extends HookConsumerWidget {
  final List<Segment> segments;

  VideoSegmentListPage(this.segments, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Head(),
        Expanded(child: _Items(segments)),
      ],
    );
  }
}

class _Head extends HookConsumerWidget {
  const _Head({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: 10),
          child: Text(
            "章节",
            style: TextStyle(fontSize: 24),
          ),
        ),
        AddVideoSegmentItemButton(),
        Expanded(child: SizedBox()),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}

class _Items extends HookConsumerWidget {
  final List<Segment> segments;
  const _Items(this.segments, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: segments.length,
      itemBuilder: (ctx, index) => _SlidableSegment(
        segment: segments[index],
      ),
      separatorBuilder: (ctx, inx) => Divider(color: Colors.black26, height: 10),
    );
  }
}

class _SlidableSegment extends HookConsumerWidget {
  final Segment segment;
  const _SlidableSegment({required this.segment, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(segment.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => ref.read(videoSegmentsProvider.notifier).remove(segment.id),
        ),
        children: [
          SlidableAction(
            onPressed: (ctx) => ref.read(videoSegmentsProvider.notifier).remove(segment.id),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(5),
            icon: Icons.delete,
            label: 'Delete',
          ),
          // SlidableAction(
          //   onPressed: (ctx) {},
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.share,
          //   label: 'Share',
          // ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: _Segment(segment: segment),
    );
  }
}

class _Segment extends HookConsumerWidget {
  final Segment segment;
  const _Segment({Key? key, required this.segment}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(itemCurrentProvider.notifier).modifySegment(segment);
                ref.read(itemStatusProvider.notifier)
                  ..setProgressStart(segment.start - Duration(seconds: 30))
                  ..setProgressDuration(segment.end - segment.start + Duration(seconds: 60));
                ref.read(isShowListProvider.state).state = false;
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MaybeImage(imgUrl: segment.imgUrl),
                  _Content(segment: segment),
                ],
              ),
            ),
          ),
          _ShareButton(),
        ],
      ),
    );
  }
}

class _MaybeImage extends HookConsumerWidget {
  final String? imgUrl;
  const _MaybeImage({this.imgUrl, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return imgUrl == null
        ? Container(
            color: Colors.white,
            width: 100,
            height: 50,
          )
        : Container(
            child: _CachedImg(url: imgUrl!),
            margin: EdgeInsetsDirectional.only(start: 10),
          );
  }
}

class _Content extends HookConsumerWidget {
  final Segment segment;
  const _Content({required this.segment, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            segment.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(222, 241, 255, 1.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              BPUtils.formatDuration(segment.start),
              style: TextStyle(
                color: Color.fromRGBO(6, 95, 212, 1.0), //仿youtube
              ),
            ),
          ),
          segment.desc != null ? Text(segment.desc!) : SizedBox(),
        ],
      ),
    );
  }
}

class _ShareButton extends HookConsumerWidget {
  const _ShareButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10),
      alignment: Alignment.centerRight,
      child: IconButton(onPressed: () {}, icon: Icon(Icons.share)),
    );
  }
}

class _CachedImg extends StatelessWidget {
  const _CachedImg({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          width: 100,
          fit: BoxFit.fitWidth,
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, dynamic error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
