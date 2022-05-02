import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'app_lifecycle_provider.freezed.dart';

final appLifecycleProvider = StateNotifierProvider<AppLifeCycleNotifier, AppLifecycle>(
  (ref) => AppLifeCycleNotifier(),
);

class AppLifeCycleNotifier extends StateNotifier<AppLifecycle> {
  AppLifeCycleNotifier() : super(AppLifecycle(isHandleLifecycle: true));

  void set isHandleLifecycle(bool isHandleLifecycle) {
    if (state.isHandleLifecycle != isHandleLifecycle) {
      state = state.copyWith(isHandleLifecycle: isHandleLifecycle);
    }
  }

  void set appLifecycleState(AppLifecycleState lifeState) {
    // print("appLifecycleState change: $lifeState");
    state = state.copyWith(appLifecycleState: lifeState);
  }
}

@freezed
class AppLifecycle with _$AppLifecycle {
  const factory AppLifecycle({
    ///当前app life cycle状态
    @Default(AppLifecycleState.resumed) AppLifecycleState appLifecycleState,

    ///Defines flag which enables/disables lifecycle handling (pause on app closed,
    ///play on app resumed). Default value is true.
    required bool isHandleLifecycle,
  }) = _AppLifecycle;
}
