import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config.dart';

AutoDisposeStateNotifierProvider<_BPConfigNotifier, BPConfig>? bpConfigProvider;

void initBpConfigProvider(BPConfig bpConfig) {
  if (bpConfigProvider == null) {
    bpConfigProvider = StateNotifierProvider.autoDispose<_BPConfigNotifier, BPConfig>(
      (ref) => _BPConfigNotifier(
        bpConfig: bpConfig,
      ),
    );
  }
}

void disposeBpConfigProvider() => bpConfigProvider = null;

class _BPConfigNotifier extends StateNotifier<BPConfig> {
  _BPConfigNotifier({BPConfig? bpConfig}) : super(bpConfig ?? BPConfig());
}
