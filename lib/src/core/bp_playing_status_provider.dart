import 'package:better_player/src/types/duration_range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bp_playing_status_provider.freezed.dart';

late final StateNotifierProvider<BPPlayingStatusNotifier, BPPlayingStatus> bpPlayingStatusProvider;

void initBpPlayingStatusProvider() {
  bpPlayingStatusProvider = StateNotifierProvider<BPPlayingStatusNotifier, BPPlayingStatus>(
    (ref) => BPPlayingStatusNotifier(),
  );
}

class BPPlayingStatusNotifier extends StateNotifier<BPPlayingStatus> {
  BPPlayingStatusNotifier({
    BPPlayingStatus? bpPlayingStatus,
  }) : super(bpPlayingStatus ?? BPPlayingStatus());
}

/// The playing status, The current position, buffering state...
@freezed
class BPPlayingStatus with _$BPPlayingStatus {
  const factory BPPlayingStatus({
    /// The current playback position.
    @Default(Duration()) Duration position,

    /// The current absolute playback position.
    ///
    /// Is null when is not available.
    //todo: 这个是干什么用的？
    DateTime? absolutePosition,

    /// True if the video is isLoading.
    @Default(false) bool isLoading,

    /// True if the video is isFinished.
    @Default(false) bool isFinished,

    /// True if the video is playing.
    @Default(false) bool isPlaying,

    /// True if it's paused.
    @Default(false) bool isPaused,

    /// True if the video is looping.
    @Default(false) bool isLooping,

    /// True if the video is currently buffering.
    @Default(false) bool isBuffering,

    /// The currently buffered ranges.
    @Default(false) bool isBuffered,

    ///是否错误
    @Default(false) bool hasError,

    /// A description of the error if present.
    ///
    /// If [hasError] is false this is [null].
    String? errorDescription,

    /// The current volume of the playback.
    @Default(1.0) double volume,

    /// The current speed of the playback
    @Default(1.0) double speed,

    ///Is in Picture in Picture Mode
    @Default(false) bool isPip,

    ///Is in Picture in full screenB Mode
    @Default(false) bool isFullScreen,
  }) = _BPPlayingStatus;
}
