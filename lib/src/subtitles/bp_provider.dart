import 'package:better_player/src/asms/bp_asms_datas_provider.dart';
import 'package:better_player/src/subtitles/bp_config_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitle.dart';
import 'package:better_player/src/subtitles/bp_factory.dart';
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bp_source.dart';

final bpSubtitlesProvider = StateNotifierProvider.autoDispose<_Notifier, SubtitlesDatas>(
  (ref) {
    var ds = ref.watch(bpSubtitlesConfigProvider!.select((v) => v.subtitlesSources ?? []));
    var asmsDs = ref.watch(bpAsmsDatasProvider.select((v) => v.subtitlesSources));
    var source = _selectSubtitlesSource([...ds, ...asmsDs]);
    return _Notifier(source: source);
  },
);

class _Notifier extends StateNotifier<SubtitlesDatas> {
  _Notifier({required BPSubtitlesSource source}) : super(SubtitlesDatas(subtitlesSource: source)) {
    fetchSubtitles(source).then((d) => state = d);
  }
}

class SubtitlesDatas {
  ///Currently used subtitles source.
  BPSubtitlesSource? subtitlesSource;

  ///Flag which determines whether are ASMS segments loading
  bool _asmsSegmentsLoading;

  ///List of loaded ASMS segments
  List<String> _asmsSegmentsLoaded;

  ///Subtitles lines for current data source.
  List<BPSubtitle> subtitlesLines = [];

  SubtitlesDatas({
    this.subtitlesSource,
    bool asmsSegmentsLoading = false,
    List<String> asmsSegmentsLoaded = const [],
    this.subtitlesLines = const [],
  })  : this._asmsSegmentsLoading = asmsSegmentsLoading,
        this._asmsSegmentsLoaded = asmsSegmentsLoaded;

  // SubtitlesDatas copyWith({
  //   List<BPAsmsTrack>? bpAsmsTracks,
  // }) {
  //   return AsmsDatas(
  //     bpAsmsTracks: bpAsmsTracks ?? this.bpAsmsTracks,
  //   );
  // }
}

///Configure subtitles based on subtitles source.
BPSubtitlesSource _selectSubtitlesSource(List<BPSubtitlesSource> subtitlesSources) {
  subtitlesSources.add(
    BPSubtitlesSource(type: BPSubtitlesSourceType.none),
  );
  final defaultSubtitle = subtitlesSources.firstWhereOrNull(
    (element) => element.selectedByDefault == true,
  );

  ///Setup subtitles (none is default)
  return defaultSubtitle ?? subtitlesSources.last;
}

///Setup subtitles to be displayed from given subtitle source.
///If subtitles source is segmented then don't load videos at start. Videos
///will load with just in time policy.
Future<SubtitlesDatas> fetchSubtitles(BPSubtitlesSource subtitlesSource) async {
  List<BPSubtitle> subtitlesLines = [];

  if (subtitlesSource.type != BPSubtitlesSourceType.none) {
    if (subtitlesSource.asmsIsSegmented != true) {
      final subtitlesParsed = await BPSubtitlesFactory.parseSubtitles(subtitlesSource);
      subtitlesLines.addAll(subtitlesParsed);
    }
  }
  return SubtitlesDatas(
    subtitlesSource: subtitlesSource,
    asmsSegmentsLoading: false,
    asmsSegmentsLoaded: <String>[],
    subtitlesLines: subtitlesLines,
  );
}
