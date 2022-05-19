// Flutter imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config.dart';

AutoDisposeStateNotifierProvider<_Notifier, BPSubtitlesConfig>? bpSubtitlesConfigProvider;

void initBpSubtitlesConfigProvider(BPSubtitlesConfig? subtitlesConfig) {
  if (bpSubtitlesConfigProvider == null) {
    bpSubtitlesConfigProvider = StateNotifierProvider.autoDispose<_Notifier, BPSubtitlesConfig>(
      (ref) => _Notifier(config: subtitlesConfig),
    );
  }
}

void disposeBpSubtitlesConfigProvider() => bpSubtitlesConfigProvider = null;

class _Notifier extends StateNotifier<BPSubtitlesConfig> {
  _Notifier({BPSubtitlesConfig? config}) : super(config ?? BPSubtitlesConfig());
  void setConfig(BPSubtitlesConfig config) => state = config;
}
