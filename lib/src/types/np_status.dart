import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'duration_range.dart';
part 'np_status.freezed.dart';

@freezed
class NPStatus with _$NPStatus {
  const NPStatus._();

  const factory NPStatus({
    /// The total duration of the video.
    ///
    /// Is null when [initialized] is false.
    Duration? duration,

    /// The current playback position.
    Duration? position,

    /// seek 动作
    Duration? seekTo,

    /// The current absolute playback position.
    ///
    /// Is null when is not available.
    DateTime? absolutePosition,

    /// The currently buffered ranges.
    List<DurationRange>? buffered,

    /// True if the video is playing. False if it's paused.
    @Default(false) bool isPlaying,
    @Default(true) bool isPlayWhenReady,

    /// True if the video is looping.
    @Default(false) bool isLooping,

    /// True if the video is currently buffering.
    @Default(false) bool isBuffering,

    /// The current volume of the playback.
    @Default(1.0) double volume,

    /// The current speed of the playback
    @Default(1.0) double speed,

    /// A description of the error if present.
    ///
    /// If [hasError] is false this is [null].
    String? errorDescription,

    /// The [size] of the currently loaded video.
    ///
    /// Is null when [initialized] is false.
    Size? size,

    ///Is in Picture in Picture Mode
    @Default(false) bool isPip,
  }) = _NPStatus;

  /// Indicates whether or not the video has been loaded and is ready to play.
  bool get initialized => duration != null;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != null;

  /// Returns [size.width] / [size.height] when size is non-null, or `1.0.` when
  /// size is null or the aspect ratio would be less than or equal to 0.0.
  double get aspectRatio {
    if (size == null) return 1.0;
    if (size!.height < 0.0001) return 1.0; //height为0
    double aspectRatio = size!.width / size!.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }
}
