import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_controls.dart';

StateNotifierProvider<_BPControlsNotifier, BPControlsConfig>? bpControlsConfigProvider;

void initBpControlsProvider(BPControlsConfig controlsConfig) {
  if (bpControlsConfigProvider == null) {
    bpControlsConfigProvider = StateNotifierProvider<_BPControlsNotifier, BPControlsConfig>(
      (ref) => _BPControlsNotifier(
        bpControlsConfig: controlsConfig,
      ),
    );
  }
}

void disposeBpControlsProvider() => bpControlsConfigProvider = null;

class _BPControlsNotifier extends StateNotifier<BPControlsConfig> {
  _BPControlsNotifier({
    BPControlsConfig? bpControlsConfig,
  }) : super(bpControlsConfig ?? BPControlsConfig());
}
