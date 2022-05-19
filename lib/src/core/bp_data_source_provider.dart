import 'package:better_player/src/defines/bp_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

AutoDisposeStateNotifierProvider<_Notifier, BPDataSource?>? bpDataSourceProvider;

void initBpDataSourceProvider(BPDataSource dataSource) {
  if (bpDataSourceProvider == null) {
    bpDataSourceProvider = StateNotifierProvider.autoDispose<_Notifier, BPDataSource?>(
      (ref) {
        return _Notifier(dataSource: dataSource);
      },
    );
  }
}

void disposeBpDataSourceProvider() => bpDataSourceProvider = null;

class _Notifier extends StateNotifier<BPDataSource?> {
  _Notifier({BPDataSource? dataSource}) : super(dataSource);

  void setBpDataSource(BPDataSource dataSource) {
    state = dataSource;
  }
}

// ///Setup new data source in Better Player.
//   Future setupDataSource(BetterPlayerDataSource betterPlayerDataSource) async {

//     ///Setup subtitles
//     _betterPlayerSubtitlesSourceList.clear();
//     final List<BetterPlayerSubtitlesSource>? betterPlayerSubtitlesSourceList =
//         betterPlayerDataSource.subtitles;
//     if (betterPlayerSubtitlesSourceList != null) {
//       _betterPlayerSubtitlesSourceList
//           .addAll(betterPlayerDataSource.subtitles!);
//     }

//     _betterPlayerAsmsTrack
//     ///Clear asms tracks
//     betterPlayerAsmsTracks.clear();
//     if (_isDataSourceAsms(betterPlayerDataSource)) {
//       _setupAsmsDataSource(betterPlayerDataSource).then((dynamic value) {
//         _setupSubtitles();
//       });
//     } else {
//       _setupSubtitles();
//     }

//     ///Process data source
//     await _setupDataSource(betterPlayerDataSource);
//     setTrack(BetterPlayerAsmsTrack.defaultTrack());
//   }