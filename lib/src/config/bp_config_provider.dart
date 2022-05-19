import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config.dart';

AutoDisposeStateNotifierProvider<_Notifier, BPConfig>? bpConfigProvider;

void initBpConfigProvider(BPConfig? config) {
  if (bpConfigProvider == null) {
    bpConfigProvider = StateNotifierProvider.autoDispose<_Notifier, BPConfig>(
      (ref) => _Notifier(config: config),
    );
  }
}

void disposeBpConfigProvider() => bpConfigProvider = null;

class _Notifier extends StateNotifier<BPConfig> {
  _Notifier({BPConfig? config}) : super(config ?? BPConfig());
}
