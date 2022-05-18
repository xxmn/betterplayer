import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bpController = StateNotifierProvider.autoDispose<_BPController, bool>(
  (ref) => _BPController(ref.read),
);

class _BPController extends StateNotifier<bool> {
  Reader read;
  _BPController(this.read) : super(false);

  void play() => read(npStatusProvider.notifier).play();
  void pause() => read(npStatusProvider.notifier).pause();
  void hideControls() => read(bpShowControlsProvider.notifier).hide();
  void showControls() => read(bpShowControlsProvider.notifier).show();
}
