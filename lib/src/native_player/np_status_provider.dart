import 'dart:async';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/types/np_event.dart';
import 'package:better_player/src/types/np_status.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';

final npStatusProvider = StateNotifierProvider<NPStatusNotifier, NPStatus>(
  (ref) {
    var createStatus = ref.watch(npCreateProvider!);
    return NPStatusNotifier(textureId: createStatus.textureId);
  },
);

class NPStatusNotifier extends StateNotifier<NPStatus> {
  int? textureId;
  StreamSubscription<NPVideoEvent>? _eventSubscription;
  Timer? _updatePositionTimer;
  NPStatusNotifier({this.textureId}) : super(NPStatus()) {
    // print("in NPStatusNotifier constructor, textureId: $textureId");
    if (textureId != null) {
      _eventSubscription = npPlatform.videoEventsFor(textureId!).listen(
            _eventListener,
            onError: _errorListener,
          );
    }
  }

  @override
  void dispose() async {
    _updatePositionTimer?.cancel();
    await _eventSubscription?.cancel();

    super.dispose();
  }

  /// Starts playing the video.
  ///
  /// This method returns a future that completes as soon as the "play" command
  /// has been sent to the platform, not when playback itself is totally
  /// finished.
  Future<void> play() async {
    await npPlatform.play(textureId);
    // print("---------------maybe play video, isPlaying: ${state.isPlaying}---------");
    // if (!mounted) return;
    // if (!state.isPlaying) {
    //   print("---------------play video---------");
    //   state = state.copyWith(isPlaying: true);
    //   await npPlatform.play(textureId);
    // }
  }

  Future<void> pause() async {
    await npPlatform.pause(textureId);
    // if (!mounted) return;

    // if (state.isPlaying) {
    //   print("---------------pause video---------");
    //   state = state.copyWith(isPlaying: false);
    //   await npPlatform.pause(textureId);
    // }
  }

  Future<void> replay() async {
    await seekTo(const Duration(seconds: 0));
    await play();
    // if (!mounted) return;

    // if (state.isPlaying) {
    //   print("---------------pause video---------");
    //   state = state.copyWith(isPlaying: false);
    //   await npPlatform.pause(textureId);
    // }
  }

  /// Sets the video's current timestamp to be at [moment]. The next
  /// time the video is played it will resume from the given [moment].
  ///
  /// If [moment] is outside of the video's full range it will be automatically
  /// and silently clamped.
  Future<void> seekTo(Duration position) async {
    if (!mounted) return;

    Duration? positionToSeek;
    if (position > state.duration!) {
      positionToSeek = state.duration!;
    } else if (position < Duration.zero) {
      positionToSeek = Duration.zero;
    }
    await npPlatform.seekTo(textureId, Duration.zero);
    if (!mounted) return;
    state.isPlaying ? play() : pause();
  }

  void _eventListener(NPVideoEvent event) {
    // print("$event");
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
        state = state.copyWith(isPlaying: false, isCompleted: true);
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
      case NPVideoEventType.playingChanged:
        var isPlaying = event.value == "true";
        // print("playingChanged, event.value: ${event.value}, isPlaying: $isPlaying");
        state = state.copyWith(isPlaying: isPlaying);
        break;
      case NPVideoEventType.updatePosition:
        state = state.copyWith(
          position: event.position,
          absolutePosition: event.absolutePosition,
        );
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

  void _errorListener(Object object) {
    if (object is PlatformException) {
      final PlatformException e = object;
      state = state.copyWith(errorDescription: e.message);
    } else {
      state.copyWith(errorDescription: object.toString());
    }
  }
}
