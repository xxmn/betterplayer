import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/better_player_utils.dart' show BPUtils;
import 'package:better_player/src/core/video_sections_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VideoSections extends StatelessWidget {
  VideoSections(this.sections, {Key? key}) : super(key: key);

  List<Section> sections;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
              Expanded(child: Container()),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () => Provider.of<VideoSectionsState>(context, listen: false).setIsShow(false),
                    icon: Icon(Icons.close)),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: sections.length,
              itemBuilder: (ctx, index) => _VideoSection(section: sections[index]),
              separatorBuilder: (ctx, inx) => Divider(color: Colors.black26, height: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoSection extends StatelessWidget {
  const _VideoSection({Key? key, required this.section}) : super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          section.imgUrl == null
              ? Container(
                  color: Colors.white,
                  width: 100,
                  height: 50,
                )
              : Container(
                  child: _CachedImg(url: section.imgUrl!),
                  margin: EdgeInsetsDirectional.only(start: 10),
                ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(222, 241, 255, 1.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      BPUtils.formatMilliSecond(section.start),
                      style: TextStyle(
                        color: Color.fromRGBO(6, 95, 212, 1.0), //仿youtube
                      ),
                    ),
                  ),
                  section.desc != null ? Text(section.desc!) : Container()
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(end: 10),
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          ),
        ],
      ),
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
