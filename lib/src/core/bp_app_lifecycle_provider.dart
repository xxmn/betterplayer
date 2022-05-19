import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '../../generated/core/bp_app_lifecycle_provider.freezed.dart';

final bpAppLifecycleProvider = StateNotifierProvider.autoDispose<_Notifier, BPAppLifecycle>(
  (ref) {
    return _Notifier(ref.read);
  },
);

class _Notifier extends StateNotifier<BPAppLifecycle> {
  Reader read;
  _Notifier(this.read) : super(BPAppLifecycle(isHandleLifecycle: true));

  void set isHandleLifecycle(bool isHandleLifecycle) {
    if (state.isHandleLifecycle != isHandleLifecycle) {
      state = state.copyWith(isHandleLifecycle: isHandleLifecycle);
    }
  }

  void setState(AppLifecycleState lifeState) {
    var controller = read(npStatusProvider.notifier);

    if (state.isHandleLifecycle) {
      var wasPlaying = state.wasPlayingBeforePause;
      if (lifeState == AppLifecycleState.resumed && wasPlaying) {
        controller.play();
      }
      if (lifeState == AppLifecycleState.paused) {
        var isPlaying = controller.isPlaying();
        if (isPlaying) controller.pause();
        state = state.copyWith(
          appLifecycleState: lifeState,
          wasPlayingBeforePause: isPlaying,
        );
        return;
      }
    }
    state = state.copyWith(appLifecycleState: lifeState);
  }
}

@freezed
class BPAppLifecycle with _$BPAppLifecycle {
  const factory BPAppLifecycle({
    ///当前app life cycle状态
    @Default(AppLifecycleState.resumed) AppLifecycleState appLifecycleState,

    ///Defines flag which enables/disables lifecycle handling (pause on app closed,
    ///play on app resumed). Default value is true.

    @Default(true) bool isHandleLifecycle,

    //
    @Default(false) bool wasPlayingBeforePause,
  }) = _BPAppLifecycle;
}
