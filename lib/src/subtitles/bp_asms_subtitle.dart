import 'package:better_player/src/subtitles/bp_asms_subtitle_segment.dart';

///Representation of HLS / DASH subtitle element.
class BPAsmsSubtitle {
  ///Language of the subtitle
  final String? language;

  ///Name of the subtitle
  final String? name;

  ///MimeType of the subtitle (DASH only)
  final String? mimeType;

  ///Segment alignment (DASH only)
  final bool? segmentAlignment;

  ///Url of the subtitle (master playlist)
  final String? url;

  ///Urls of specific files
  final List<String>? realUrls;

  ///Should subtitles be loaded with segments.
  final bool? isSegmented;

  ///Max value between segments. In HLS defined as #EXT-X-TARGETDURATION.
  ///Only used when [isSegmented] is true.
  final int? segmentsTime;

  ///List of subtitle segments. Only used when [isSegmented] is true.
  final List<BPAsmsSubtitleSegment>? segments;

  ///If the subtitle is the default
  final bool? isDefault;

  BPAsmsSubtitle({
    this.language,
    this.name,
    this.mimeType,
    this.segmentAlignment,
    this.url,
    this.realUrls,
    this.isSegmented,
    this.segmentsTime,
    this.segments,
    this.isDefault,
  });
}
