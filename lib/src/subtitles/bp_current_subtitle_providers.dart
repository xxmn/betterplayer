import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitle.dart';
import 'package:better_player/src/subtitles/bp_subtitles_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bpCurrentSubtitleProvider = Provider<BPSubtitle?>(
  (ref) {
    var position = ref.watch(bpPlayingStatusProvider!.select((v) => v.position));
    return ref.watch(bpSubtitlesProvider.select((v) {
      for (final BPSubtitle subtitle in v.subtitlesLines) {
        if (subtitle.start! <= position && subtitle.end! >= position) {
          return subtitle;
        }
      }
      return null;
    }));
  },
);
