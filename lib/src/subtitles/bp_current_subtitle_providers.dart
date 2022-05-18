import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitle.dart';
import 'package:better_player/src/subtitles/bp_subtitles_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bpCurrentSubtitleProvider = Provider.autoDispose<BPSubtitle?>(
  (ref) {
    var position = ref.watch(npStatusProvider.select((v) => v.position ?? Duration.zero));
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
