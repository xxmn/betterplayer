import 'package:better_player/src/asms/bp_asms_audio_track.dart';
import 'package:better_player/src/asms/bp_asms_data_holder.dart';
import 'package:better_player/src/subtitles/bp_asms_subtitle.dart';
import 'package:better_player/src/asms/bp_asms_track.dart';
import 'package:better_player/src/asms/bp_asms_utils.dart';
import 'package:better_player/src/subtitles/bp_source.dart';
import 'package:better_player/src/defines/bp_drm_config.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/defines/bp_data_source.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bpAsmsDatasProvider = StateNotifierProvider.autoDispose<BPAsmsNotifier, AsmsDatas>((ref) {
  var ds = ref.watch(bpDataSourceProvider!);
  return BPAsmsNotifier(dataSource: ds!);
});

class BPAsmsNotifier extends StateNotifier<AsmsDatas> {
  BPAsmsNotifier({required BPDataSource dataSource}) : super(AsmsDatas()) {
    if (BPAsmsUtils.isDataSourceAsms2(dataSource.url, dataSource.videoFormat)) {
      _setupAsmsDataSource(dataSource).then((d) => state = d);
    }
  }
}

class AsmsDatas {
  final bool isDataSourceAsms;

  ///List of tracks available for current data source. Used only for HLS / DASH.
  final List<BPAsmsTrack> asmsTracks;

  ///List of BPSubtitlesSources.
  final List<BPSubtitlesSource> subtitlesSources;

  ///List of all possible audio tracks returned from ASMS stream
  final List<BPAsmsAudioTrack> asmsAudioTracks;

  AsmsDatas({
    this.isDataSourceAsms = false,
    this.asmsTracks = const <BPAsmsTrack>[],
    this.subtitlesSources = const <BPSubtitlesSource>[],
    this.asmsAudioTracks = const <BPAsmsAudioTrack>[],
  });

  AsmsDatas copyWith({
    bool? isDataSourceAsms,
    List<BPAsmsTrack>? asmsTracks,
    List<BPSubtitlesSource>? subtitlesSources,
    List<BPAsmsAudioTrack>? asmsAudioTracks,
  }) {
    return AsmsDatas(
      isDataSourceAsms: isDataSourceAsms ?? this.isDataSourceAsms,
      asmsTracks: asmsTracks ?? this.asmsTracks,
      subtitlesSources: subtitlesSources ?? this.subtitlesSources,
      asmsAudioTracks: asmsAudioTracks ?? this.asmsAudioTracks,
    );
  }
}

///Configure HLS / DASH data source based on provided data source and configuration.
///This method configures tracks, subtitles and audio tracks from given
///master playlist.
Future<AsmsDatas> _setupAsmsDataSource(BPDataSource dataSource) async {
  List<BPAsmsTrack> bpAsmsTracks = [];
  List<BPSubtitlesSource> bpSubtitlesSources = [];
  List<BPAsmsAudioTrack> bpAsmsAudioTracks = [];

  final String? data = await BPAsmsUtils.getDataFromUrl(
    dataSource.url,
    getHeaders(dataSource.headers, dataSource.drmConfig),
  );
  if (data != null) {
    final BPAsmsDataHolder _response = await BPAsmsUtils.parse(data, dataSource.url);

    /// Load tracks
    if (dataSource.useAsmsTracks == true) {
      bpAsmsTracks = _response.tracks ?? [];
    }

    /// Load subtitles
    if (dataSource.useAsmsSubtitles == true) {
      final List<BPAsmsSubtitle> asmsSubtitles = _response.subtitles ?? [];
      asmsSubtitles.forEach((BPAsmsSubtitle asmsSubtitle) {
        bpSubtitlesSources.add(
          BPSubtitlesSource(
            type: BPSubtitlesSourceType.network,
            name: asmsSubtitle.name,
            urls: asmsSubtitle.realUrls,
            asmsIsSegmented: asmsSubtitle.isSegmented,
            asmsSegmentsTime: asmsSubtitle.segmentsTime,
            asmsSegments: asmsSubtitle.segments,
            selectedByDefault: asmsSubtitle.isDefault,
          ),
        );
      });
    }

    ///Load audio tracks
    if (dataSource.useAsmsAudioTracks == true) {
      bpAsmsAudioTracks = _response.audios ?? [];
    }
  }
  return AsmsDatas(
    isDataSourceAsms: true,
    asmsTracks: bpAsmsTracks,
    subtitlesSources: bpSubtitlesSources,
    asmsAudioTracks: bpAsmsAudioTracks,
  );
}

// ///Set [audioTrack] in player. Works only for HLS or DASH streams.
// void setAudioTrack(BetterPlayerAsmsAudioTrack audioTrack) {
//   if (audioTrack.language == null) {
//     _betterPlayerAsmsAudioTrack = null;
//     return;
//   }

//   _betterPlayerAsmsAudioTrack = audioTrack;
//   videoPlayerController!.setAudioTrack(audioTrack.label, audioTrack.id);
// }

///Build headers map that will be used to setup video player controller. Apply
///DRM headers if available.
///static const String _authorizationHeader = "Authorization";
Map<String, String?> _getHeaders(Map<String, String>? dsheaders, BPDrmConfig? drmConfig) {
  final headers = dsheaders ?? {};
  if (drmConfig?.drmType == BPDrmType.token && drmConfig?.token != null) {
    headers["Authorization"] = drmConfig!.token!;
  }
  return headers;
}
