import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config.dart';

AutoDisposeStateNotifierProvider<_Notifier, BPControlsConfig>? bpControlsConfigProvider;

void initBpControlsConfigProvider(BPControlsConfig? config) {
  if (bpControlsConfigProvider == null) {
    bpControlsConfigProvider = StateNotifierProvider.autoDispose<_Notifier, BPControlsConfig>(
      (ref) => _Notifier(config: config),
    );
  }
}

void disposeBpControlsConfigProvider() => bpControlsConfigProvider = null;

class _Notifier extends StateNotifier<BPControlsConfig> {
  _Notifier({BPControlsConfig? config}) : super(config ?? BPControlsConfig());

  void setConfig(BPControlsConfig config) => state = config;
}
