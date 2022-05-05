// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Flutter imports:

import 'package:better_player/src/types/np_data_source.dart';
import 'package:better_player/src/types/duration_range.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'method_channel.dart';

/// The interface that implementations of video_player must implement.
///
/// Platform implementations should extend this class rather than implement it as `video_player`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [NativePlayerPlatform] methods.
abstract class NativePlayerPlatform {
  /// Only mock implementations should set this to true.
  ///
  /// Mockito mocks are implementing this class with `implements` which is forbidden for anything
  /// other than mocks (see class docs). This property provides a backdoor for mockito mocks to
  /// skip the verification that the class isn't implemented with `implements`.
  @visibleForTesting
  bool get isMock => false;

  static NativePlayerPlatform _instance = NativePlayerMethodChannel();

  /// The default instance of [NativePlayerPlatform] to use.
  ///
  /// Platform-specific plugins should override this with their own
  /// platform-specific class that extends [NativePlayerPlatform] when they
  /// register themselves.
  ///
  /// Defaults to [MethodChannelNativePlayer].
  static NativePlayerPlatform get instance => _instance;

  // TODO(amirh): Extract common platform interface logic.
  // https://github.com/flutter/flutter/issues/43368
  static set instance(NativePlayerPlatform instance) {
    if (!instance.isMock) {
      try {
        instance._verifyProvidesDefaultImplementations();
      } catch (_) {
        throw AssertionError('Platform interfaces must not be implemented with `implements`');
      }
    }
    _instance = instance;
  }

  /// Initializes the platform interface and disposes all existing players.
  ///
  /// This method is called when the plugin is first initialized
  /// and on every full restart.
  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  /// Clears one video.
  Future<void> dispose(int? textureId) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  // /// Creates an instance of a video player and returns its textureId.
  // Future<int?> create({BPBufferingCfg? bufferingCfg}) {
  //   throw UnimplementedError('create() has not been implemented.');
  // }

  /// Pre-caches a video.
  Future<void> preCache(NPDataSource dataSource, int preCacheSize) {
    throw UnimplementedError('preCache() has not been implemented.');
  }

  /// Pre-caches a video.
  Future<void> stopPreCache(String url, String? cacheKey) {
    throw UnimplementedError('stopPreCache() has not been implemented.');
  }

  /// Set data source of video.
  Future<void> setDataSource(int? textureId, NPDataSource dataSource) {
    throw UnimplementedError('setDataSource() has not been implemented.');
  }

  /// Returns a Stream of [VideoEventType]s.
  Stream<VideoEvent> videoEventsFor(int? textureId) {
    throw UnimplementedError('videoEventsFor() has not been implemented.');
  }

  /// Sets the looping attribute of the video.
  Future<void> setLooping(int? textureId, bool looping) {
    throw UnimplementedError('setLooping() has not been implemented.');
  }

  /// Starts the video playback.
  Future<void> play(int? textureId) {
    throw UnimplementedError('play() has not been implemented.');
  }

  /// Stops the video playback.
  Future<void> pause(int? textureId) {
    throw UnimplementedError('pause() has not been implemented.');
  }

  /// Stops the video playback.
  Future<Uint8List?> screenshot(int? textureId) {
    throw UnimplementedError('pause() has not been implemented.');
  }

  /// Sets the volume to a range between 0.0 and 1.0.
  Future<void> setVolume(int? textureId, double volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  /// Sets the video speed to a range between 0.0 and 2.0
  Future<void> setSpeed(int? textureId, double speed) {
    throw UnimplementedError('setSpeed() has not been implemented.');
  }

  /// Sets the video track parameters (used to select quality of the video)
  Future<void> setTrackParameters(int? textureId, int? width, int? height, int? bitrate) {
    throw UnimplementedError('setTrackParameters() has not been implemented.');
  }

  /// Sets the video position to a [Duration] from the start.
  Future<void> seekTo(int? textureId, Duration? position) {
    throw UnimplementedError('seekTo() has not been implemented.');
  }

  /// Gets the video position as [Duration] from the start.
  Future<Duration> getPosition(int? textureId) {
    throw UnimplementedError('getPosition() has not been implemented.');
  }

  /// Gets the video position as [DateTime].
  Future<DateTime?> getAbsolutePosition(int? textureId) {
    throw UnimplementedError('getAbsolutePosition() has not been implemented.');
  }

  ///Enables PiP mode.
  Future<void> enablePictureInPicture(
      int? textureId, double? top, double? left, double? width, double? height) {
    throw UnimplementedError('enablePictureInPicture() has not been implemented.');
  }

  ///Disables PiP mode.
  Future<void> disablePictureInPicture(int? textureId) {
    throw UnimplementedError('disablePictureInPicture() has not been implemented.');
  }

  Future<bool?> isPictureInPictureEnabled(int? textureId) {
    throw UnimplementedError('isPictureInPictureEnabled() has not been implemented.');
  }

  Future<void> setAudioTrack(int? textureId, String? name, int? index) {
    throw UnimplementedError('setAudio() has not been implemented.');
  }

  Future<void> setMixWithOthers(int? textureId, bool mixWithOthers) {
    throw UnimplementedError('setMixWithOthers() has not been implemented.');
  }

  Future<void> clearCache() {
    throw UnimplementedError('clearCache() has not been implemented.');
  }

  /// Returns a widget displaying the video with a given textureID.
  Widget buildView(int? textureId) {
    throw UnimplementedError('buildView() has not been implemented.');
  }

  // This method makes sure that NativePlayer isn't implemented with `implements`.
  //
  // See class docs for more details on why implementing this class is forbidden.
  //
  // This private method is called by the instance setter, which fails if the class is
  // implemented with `implements`.
  void _verifyProvidesDefaultImplementations() {}
}

/// Event emitted from the platform implementation.
class VideoEvent {
  /// Creates an instance of [VideoEvent].
  ///
  /// The [eventType] argument is required.
  ///
  /// Depending on the [eventType], the [duration], [size] and [buffered]
  /// arguments can be null.
  VideoEvent({
    required this.eventType,
    required this.key,
    this.duration,
    this.size,
    this.buffered,
    this.position,
  });

  /// The type of the event.
  final VideoEventType eventType;

  /// Data source of the video.
  ///
  /// Used to determine which video the event belongs to.
  final String? key;

  /// Duration of the video.
  ///
  /// Only used if [eventType] is [VideoEventType.initialized].
  final Duration? duration;

  /// Size of the video.
  ///
  /// Only used if [eventType] is [VideoEventType.initialized].
  final Size? size;

  /// Buffered parts of the video.
  ///
  /// Only used if [eventType] is [VideoEventType.bufferingUpdate].
  final List<DurationRange>? buffered;

  ///Seek position
  final Duration? position;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VideoEvent &&
            runtimeType == other.runtimeType &&
            key == other.key &&
            eventType == other.eventType &&
            duration == other.duration &&
            size == other.size &&
            listEquals(buffered, other.buffered);
  }

  @override
  int get hashCode => eventType.hashCode ^ duration.hashCode ^ size.hashCode ^ buffered.hashCode;
}

/// Type of the event.
///
/// Emitted by the platform implementation when the video is initialized or
/// completed or to communicate buffering events.
enum VideoEventType {
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
