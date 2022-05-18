import 'dart:async';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/defines/np_event.dart';
import 'package:better_player/src/defines/np_status.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';

final npStatusProvider = StateNotifierProvider.autoDispose<_NPStatusNotifier, NPStatus>(
  (ref) {
    var createStatus = ref.watch(npCreateProvider!);
    return _NPStatusNotifier(textureId: createStatus.textureId);
  },
);

class _NPStatusNotifier extends StateNotifier<NPStatus> {
  int? textureId;
  StreamSubscription<NPVideoEvent>? _eventSubscription;
  Timer? _updatePositionTimer;
  _NPStatusNotifier({this.textureId}) : super(NPStatus()) {
    // print("in _NPStatusNotifier constructor, textureId: $textureId");
    if (textureId != null) {
      _eventSubscription = npPlatform.videoEventsFor(textureId!).listen(
            _eventListener,
            onError: _errorListener,
          );
    }
  }

  double getAspectRatio() => state.aspectRatio;
  double getVolume() => state.volume;
  Duration getPosition() => state.position ?? Duration.zero;
  Duration getDuration() => state.duration ?? Duration.zero;
  bool isPlaying() => state.isPlaying;

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
    if (!mounted) return;
    if (!state.isPlaying) {
      await npPlatform.play(textureId);
    }
  }

  Future<void> pause() async {
    if (!mounted) return;
    if (state.isPlaying) {
      await npPlatform.pause(textureId);
    }
  }

  Future<void> replay() async {
    await seekTo(const Duration(seconds: 0));
    await play();
  }

  /// Sets the video's current timestamp to be at [moment]. The next
  /// time the video is played it will resume from the given [moment].
  ///
  /// If [moment] is outside of the video's full range it will be automatically
  /// and silently clamped.
  Future<void> seekTo(Duration position) async {
    if (!mounted) return;
    if (position > state.duration!) {
      position = state.duration!;
    } else if (position < Duration.zero) {
      position = Duration.zero;
    }
    await npPlatform.seekTo(textureId, position);
  }

  Future<void> seekToAndContinue(Duration position) async {
    var isPlaying = state.isPlaying;
    if (isPlaying) await pause();
    await seekTo(position);
    if (isPlaying) await play();
  }

  /// Sets the audio volume of [this].
  ///
  /// [volume] indicates a value between 0.0 (silent) and 1.0 (full volume) on a
  /// linear scale.
  Future<void> setVolume(double volume) async {
    if (!mounted) return;
    volume = volume.clamp(0.0, 1.0);
    await npPlatform.setVolume(textureId, volume);
    if (!mounted) return;
    state = state.copyWith(volume: volume);
  }

  Future<void> _applySpeed() async {
    if (!mounted) return;
    await npPlatform.setSpeed(textureId, state.speed);
  }

  /// Sets the speed of [this].
  ///
  /// [speed] indicates a value between 0.0 and 2.0 on a linear scale.
  Future<void> setSpeed(double speed) async {
    final double previousSpeed = state.speed;
    try {
      state = state.copyWith(speed: speed);
      await _applySpeed();
    } catch (exception) {
      state = state.copyWith(speed: previousSpeed);
      rethrow;
    }
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

        state = isPlaying
            ? state.copyWith(isPlaying: isPlaying, isCompleted: false)
            : state.copyWith(isPlaying: isPlaying);
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
        // todo: 作用未知
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
      case NPVideoEventType.volumeChanged:
        state = state.copyWith(volume: event.dValue!);
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

///Latest value can be null
bool npStatusIsLoading(NPStatus state) {
  if (!state.isPlaying && state.duration == null) return true;

  final Duration position = state.position ?? Duration.zero;
  Duration? bufferedEndPosition;
  if (state.buffered?.isNotEmpty == true) {
    bufferedEndPosition = state.buffered!.last.end;
  }

  if (bufferedEndPosition != null) {
    final difference = bufferedEndPosition - position;

    ///Min. time of buffered video to hide loading timer (in milliseconds)
    const int _bufferingInterval = 20000;
    if (!state.isPlaying && state.isBuffering && difference.inMilliseconds < _bufferingInterval) {
      return true;
    }
  }
  return false;
}
