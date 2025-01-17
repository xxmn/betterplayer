import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_debounce/easy_debounce.dart';

const _hideControlsTimerId = 'hideControlsTimer';

///
///Has Controls Visible.
///
final bpShowControlsProvider = StateNotifierProvider.autoDispose<_ShowControlsNotifier, bool>(
  (ref) {
    var showControls = ref.watch(bpControlsConfigProvider!.select((v) => v.showControls));
    return _ShowControlsNotifier(showControls);
  },
);

class _ShowControlsNotifier extends StateNotifier<bool> {
  _ShowControlsNotifier(bool isShow) : super(isShow) {
    debounceHideControls();
  }

  void hide() {
    // print("0.hide");
    EasyDebounce.cancel(_hideControlsTimerId);
    state = false;
  }

  void show() {
    // print("2.showDeferHide");
    EasyDebounce.cancel(_hideControlsTimerId);
    state = true;
    debounceHideControls();
  }

  void showNoHide() {
    // print("1.show");
    EasyDebounce.cancel(_hideControlsTimerId);
    state = true;
  }

  void toggleNoHide() {
    // print("3.toggle");
    EasyDebounce.cancel(_hideControlsTimerId);
    state = !state;
  }

  //切换显示状态
  void toggle() {
    // print("3.toggle");
    EasyDebounce.cancel(_hideControlsTimerId);
    state = !state;
    if (state) {
      debounceHideControls();
    }
  }

  //如果显示按钮，延时
  void debounceHideControls() {
    // 显示按钮
    if (state != false) {
      EasyDebounce.debounce(
        _hideControlsTimerId, // <-- An ID for this particular debouncer
        const Duration(seconds: 3), // <-- The debounce duration
        () {
          state = false;
        }, // todo: 需要mounted判断？
      );
    }
  }

  @override
  void dispose() {
    // print("-------execute dispose");
    EasyDebounce.cancel(_hideControlsTimerId);
    super.dispose();
  }
}
