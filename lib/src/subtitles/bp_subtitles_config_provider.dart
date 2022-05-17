// Flutter imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_subtitles_config.dart';

StateNotifierProvider<BPSubtitlesConfigNotifier, BPSubtitlesConfig>? bpSubtitlesConfigProvider;

void initBpSubtitlesConfigProvider(BPSubtitlesConfig subtitlesConfig) {
  if (bpSubtitlesConfigProvider == null) {
    bpSubtitlesConfigProvider = StateNotifierProvider<BPSubtitlesConfigNotifier, BPSubtitlesConfig>(
      (ref) => BPSubtitlesConfigNotifier(
        bpSubtitlesConfig: subtitlesConfig,
      ),
    );
  }
}

void disposeBpSubtitlesConfigProvider() => bpSubtitlesConfigProvider = null;

class BPSubtitlesConfigNotifier extends StateNotifier<BPSubtitlesConfig> {
  BPSubtitlesConfigNotifier({
    BPSubtitlesConfig? bpSubtitlesConfig,
  }) : super(bpSubtitlesConfig ?? BPSubtitlesConfig());
}