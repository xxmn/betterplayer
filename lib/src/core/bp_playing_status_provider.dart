import 'package:better_player/src/types/duration_range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bp_playing_status_provider.freezed.dart';

final bpPlayingStatusProvider = StateNotifierProvider<BPPlayingStatusNotifier, BPPlayingStatus>(
  (ref) => BPPlayingStatusNotifier(),
);

class BPPlayingStatusNotifier extends StateNotifier<BPPlayingStatus> {
  BPPlayingStatusNotifier() : super(BPPlayingStatus());
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

    /// The currently buffered ranges.
    @Default(<DurationRange>[]) List<DurationRange> buffered,

    /// True if the video is playing. False if it's paused.
    @Default(false) bool isPlayingStatus,

    /// True if the video is looping.
    @Default(false) bool isLooping,

    /// True if the video is currently buffering.
    @Default(false) bool isBuffering,

    /// The current volume of the playback.
    @Default(1.0) double volume,

    /// The current speed of the playback
    @Default(1.0) double speed,

    ///Is in Picture in Picture Mode
    @Default(false) bool isPip,
  }) = _BPPlayingStatus;
}
