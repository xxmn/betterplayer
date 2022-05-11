import 'dart:ui';
import 'package:better_player/src/types/duration_range.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'np_event.freezed.dart';

/// Event emitted from the platform implementation.

@freezed
class NPVideoEvent with _$NPVideoEvent {
  /// Creates an instance of [NPVideoEvent].
  ///
  /// The [eventType] argument is required.
  ///
  /// Depending on the [eventType], the [duration], [size] and [buffered]
  /// arguments can be null.
  const factory NPVideoEvent({
    /// The type of the event.
    required NPVideoEventType eventType,

    /// Data source of the video.
    ///
    /// Used to determine which video the event belongs to.
    required String? key,

    /// Duration of the video.
    ///
    /// Only used if [eventType] is [NPVideoEventType.initialized].
    Duration? duration,

    /// Size of the video.
    ///
    /// Only used if [eventType] is [NPVideoEventType.initialized].
    Size? size,

    /// Buffered parts of the video.
    ///
    /// Only used if [eventType] is [NPVideoEventType.bufferingUpdate].
    List<DurationRange>? buffered,

    ///Seek position
    Duration? position,

    // 通用值
    String? value,

    //
    DateTime? absolutePosition,
  }) = _NPVideoEvent;
}

/// Type of the event.
///
/// Emitted by the platform implementation when the video is initialized or
/// completed or to communicate buffering events.
enum NPVideoEventType {
  /// The video has been initialized.
  initialized,

  /// The playback has ended.
  completed,

  /// Updated information on the buffering state.
  bufferingUpdate,

  /// The video started to buffer.
  bufferingStart,

  /// The video stopped to buffer.
  bufferingEnd,

  /// The video is set to play
  play,
  updatePosition,
  playingChanged,

  /// The video is set to pause
  pause,
  screenshot,

  /// The video is set to given to position
  seek,

  /// The video is displayed in Picture in Picture mode
  pipStart,

  /// Picture in picture mode has been dismissed
  pipStop,

  /// An unknown event has been received.
  unknown,
}
