import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/core/interact_provider.freezed.dart';

final interactProvider = StateNotifierProvider.autoDispose<InteractiveNotifier, int>((ref) {
  return InteractiveNotifier();
});

class InteractiveNotifier extends StateNotifier<int> {
  InteractiveNotifier() : super(0);
}

@freezed
class InteractiveStatus with _$InteractiveStatus {
  const factory InteractiveStatus({
    @Default(0) int count,
    InteractiveEvent? event,
  }) = _InteractiveStatus;
}

@freezed
class InteractiveEvent with _$InteractiveEvent {
  const factory InteractiveEvent({
    required String from,
    required String eventName,
    dynamic args,
  }) = _InteractiveEvent;
}
