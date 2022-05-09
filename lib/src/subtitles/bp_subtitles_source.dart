import 'package:better_player/src/subtitles/bp_asms_subtitle_segment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bp_subtitles_source.freezed.dart';

///Representation of subtitles source. Used to define subtitles in Better
/// Player.
@freezed
class BPSubtitlesSource with _$BPSubtitlesSource {
  // Added constructor. Must not have any parameter
  const BPSubtitlesSource._();

  const factory BPSubtitlesSource({
    ///Source type
    BPSubtitlesSourceType? type,

    ///Name of the subtitles, default value is "Default subtitles"
    @Default("Default subtitles") String? name,

    ///Url of the subtitles, used with file or network subtitles
    List<String?>? urls,

    ///Content of subtitles, used when type is memory
    String? content,

    ///Subtitles selected by default, without user interaction
    bool? selectedByDefault,

    //Additional headers used in HTTP request. Works only for
    // [BPSubtitlesSourceType.memory] source type.
    Map<String, String>? headers,

    ///Is ASMS segmented source (more than 1 subtitle file). This shouldn't be
    ///configured manually.
    bool? asmsIsSegmented,

    ///Max. time between segments in milliseconds. This shouldn't be configured
    /// manually.
    int? asmsSegmentsTime,

    ///List of segments (start,end,url of the segment). This shouldn't be
    ///configured manually.
    final List<BPAsmsSubtitleSegment>? asmsSegments,
  }) = _BPSubtitlesSource;

  ///Creates list with only one subtitles
  static List<BPSubtitlesSource> single({
    BPSubtitlesSourceType? type,
    String name = "Default subtitles",
    String? url,
    String? content,
    bool? selectedByDefault,
    Map<String, String>? headers,
  }) =>
      [
        BPSubtitlesSource(
          type: type,
          name: name,
          urls: [url],
          content: content,
          selectedByDefault: selectedByDefault,
          headers: headers,
        )
      ];
}

///Representation of possible source types of subtitles.
enum BPSubtitlesSourceType { file, network, memory, none }
