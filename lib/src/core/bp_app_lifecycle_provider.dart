import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '../../generated/core/bp_app_lifecycle_provider.freezed.dart';

final bpAppLifecycleProvider = StateNotifierProvider<BPAppLifeCycleNotifier, BPAppLifecycle>(
  (ref) => BPAppLifeCycleNotifier(),
);

class BPAppLifeCycleNotifier extends StateNotifier<BPAppLifecycle> {
  BPAppLifeCycleNotifier() : super(BPAppLifecycle(isHandleLifecycle: true));

  void set isHandleLifecycle(bool isHandleLifecycle) {
    if (state.isHandleLifecycle != isHandleLifecycle) {
      state = state.copyWith(isHandleLifecycle: isHandleLifecycle);
    }
  }

  void set appLifecycleState(AppLifecycleState lifeState) {
    print("appLifecycleState change: $lifeState");
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
  }) = _BPAppLifecycle;
}
