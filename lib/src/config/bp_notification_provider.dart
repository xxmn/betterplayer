import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_notification.dart';

final bpNotificationProvider = StateNotifierProvider.autoDispose<_BPNtNotifier, BPNtConfig>(
  (ref) => _BPNtNotifier(),
);

class _BPNtNotifier extends StateNotifier<BPNtConfig> {
  _BPNtNotifier() : super(BPNtConfig());
}
