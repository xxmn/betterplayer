import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
part '../../generated/config/bp_video_sction_provider.freezed.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.

final bpVideoSectionProvider = StateNotifierProvider<_BPVideoSctionNotifier, _BPVideoSctionConfig>(
  (ref) => _BPVideoSctionNotifier(10),
);

class _BPVideoSctionNotifier extends StateNotifier<_BPVideoSctionConfig> {
  _BPVideoSctionNotifier(int length) : super(_BPVideoSctionConfig(length: length));
  void setIndex(int index) {
    state = state.copyWith(index: index);
  }

  void setIsShow(bool isShow) {
    state = state.copyWith(isShow: isShow);
  }
}

///Configuration of notification which is displayed once user moves app to
///background.
@freezed
class _BPVideoSctionConfig with _$_BPVideoSctionConfig {
  const factory _BPVideoSctionConfig({
    required int length,
    @Default(true) bool? isShow,
    @Default(0) int index,
  }) = __BPVideoSctionConfig;
}
