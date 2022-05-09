import 'dart:async';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/types/np_event.dart';
import 'package:better_player/src/types/np_status.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';
import 'np_set_data_source_provider.dart';

final npStatusProvider = StateNotifierProvider<NPControllerNotifier, NPStatus>(
  (ref) {
    var createStatus = ref.watch(npCreateProvider!);
    return NPControllerNotifier(
      textureId: createStatus.textureId,
    );
  },
);

class NPControllerNotifier extends StateNotifier<NPStatus> {
  int? textureId;
  StreamSubscription<NPVideoEvent>? _eventSubscription;
  NPControllerNotifier({this.textureId}) : super(NPStatus()) {
    print("in NPControllerNotifier constructor, textureId: $textureId");
    if (textureId != null) {
      _eventSubscription = npPlatform.videoEventsFor(textureId!).listen(
            eventListener,
            onError: errorListener,
          );
    }
  }

  @override
  void dispose() async {
    await _eventSubscription?.cancel();
    super.dispose();
  }

  void eventListener(NPVideoEvent event) {
    print("np status provider recieved a event: $event");
    if (!mounted) return;

    switch (event.eventType) {
      case NPVideoEventType.initialized:
        state = state.copyWith(
          duration: event.duration!,
          size: event.size!,
        );
        npPlatform.play(textureId);
        break;
      case NPVideoEventType.completed:
        state = state.copyWith(isPlaying: false);
        break;
      case NPVideoEventType.bufferingUpdate:
        state = state.copyWith(buffered: event.buffered!);
        break;
      case NPVideoEventType.bufferingStart:
        state = state.copyWith(isBuffering: true);
        break;
      case NPVideoEventType.bufferingEnd:
        if (state.isBuffering) {
          state = state.copyWith(isBuffering: false);
        }
        break;

      case NPVideoEventType.play:
        //todo: 这里有点奇怪 isPlayWhenReady貌似反了
        state = state.copyWith(isPlayWhenReady: false);
        break;
      case NPVideoEventType.pause:
        state = state.copyWith(isPlayWhenReady: true);
        break;
      case NPVideoEventType.seek:
        state = state.copyWith(seekTo: event.position!);
        break;
      case NPVideoEventType.pipStart:
        state = state.copyWith(isPip: true);
        break;
      case NPVideoEventType.pipStop:
        state = state.copyWith(isPip: false);
        break;
      case NPVideoEventType.unknown:
        print("recevied a unknown event: $event");
        break;
      case NPVideoEventType.screenshot:
        print("recevied a screenshot event: $event");
        break;
    }
  }

  void errorListener(Object object) {
    if (object is PlatformException) {
      final PlatformException e = object;
      state = state.copyWith(errorDescription: e.message);
    } else {
      state.copyWith(errorDescription: object.toString());
    }
  }
}
