// import 'dart:async';
// import 'package:better_player/src/config/bp_buffering_config.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'platform_interface.dart';

//   int? _textureId;
//   StreamSubscription<dynamic>? _eventSubscription;

//   Duration? _seekPosition;

//   /// This is just exposed for testing. It shouldn't be used by anyone depending
//   /// on the plugin.
//   @visibleForTesting
//   int? get textureId => _textureId;

//   /// Starts playing the video.
//   ///
//   /// This method returns a future that completes as soon as the "play" command
//   /// has been sent to the platform, not when playback itself is totally
//   /// finished.
//   Future<void> play() async {
//     value = value.copyWith(isPlaying: true);
//     await _applyPlayPause();
//   }

//   /// Sets whether or not the video should loop after playing once. See also
//   /// [NPValue.isLooping].
//   Future<void> setLooping(bool looping) async {
//     value = value.copyWith(isLooping: looping);
//     await _applyLooping();
//   }

//   /// Pauses the video.
//   Future<void> pause() async {
//     value = value.copyWith(isPlaying: false);
//     await _applyPlayPause();
//   }

//   Future<void> _applyLooping() async {
//     if (!_created || _isDisposed) {
//       return;
//     }
//     await _videoPlayerPlatform.setLooping(_textureId, value.isLooping);
//   }

//   Future<void> _applyPlayPause() async {
//     if (!_created || _isDisposed) {
//       return;
//     }
//     _timer?.cancel();
//     if (value.isPlaying) {
//       await _videoPlayerPlatform.play(_textureId);
//       _timer = Timer.periodic(
//         const Duration(milliseconds: 300),
//         (Timer timer) async {
//           if (_isDisposed) {
//             return;
//           }
//           final Duration? newPosition = await position;
//           final DateTime? newAbsolutePosition = await absolutePosition;
//           // ignore: invariant_booleans
//           if (_isDisposed) {
//             return;
//           }
//           _updatePosition(newPosition, absolutePosition: newAbsolutePosition);
//           if (_seekPosition != null && newPosition != null) {
//             final difference = newPosition.inMilliseconds - _seekPosition!.inMilliseconds;
//             if (difference > 0) {
//               _seekPosition = null;
//             }
//           }
//         },
//       );
//     } else {
//       await _videoPlayerPlatform.pause(_textureId);
//     }
//   }

//   Future<void> _applyVolume() async {
//     if (!_created || _isDisposed) {
//       return;
//     }
//     await _videoPlayerPlatform.setVolume(_textureId, value.volume);
//   }

//   Future<void> _applySpeed() async {
//     if (!_created || _isDisposed) {
//       return;
//     }
//     await _videoPlayerPlatform.setSpeed(_textureId, value.speed);
//   }

//   /// The position in the current video.
//   Future<Duration?> get position async {
//     if (!value.initialized && _isDisposed) {
//       return null;
//     }
//     return _videoPlayerPlatform.getPosition(_textureId);
//   }

//   /// The absolute position in the current video stream
//   /// (i.e. EXT-X-PROGRAM-DATE-TIME in HLS).
//   Future<DateTime?> get absolutePosition async {
//     if (!value.initialized && _isDisposed) {
//       return null;
//     }
//     return _videoPlayerPlatform.getAbsolutePosition(_textureId);
//   }

//   /// Sets the video's current timestamp to be at [moment]. The next
//   /// time the video is played it will resume from the given [moment].
//   ///
//   /// If [moment] is outside of the video's full range it will be automatically
//   /// and silently clamped.
//   Future<void> seekTo(Duration? position) async {
//     _timer?.cancel();
//     bool isPlaying = value.isPlaying;
//     final int positionInMs = value.position.inMilliseconds;
//     final int durationInMs = value.duration?.inMilliseconds ?? 0;

//     if (positionInMs >= durationInMs && position?.inMilliseconds == 0) {
//       isPlaying = true;
//     }
//     if (_isDisposed) {
//       return;
//     }

//     Duration? positionToSeek = position;
//     if (position! > value.duration!) {
//       positionToSeek = value.duration;
//     } else if (position < const Duration()) {
//       positionToSeek = const Duration();
//     }
//     _seekPosition = positionToSeek;

//     await _videoPlayerPlatform.seekTo(_textureId, positionToSeek);
//     _updatePosition(position);

//     if (isPlaying) {
//       play();
//     } else {
//       pause();
//     }
//   }

//   /// Sets the audio volume of [this].
//   ///
//   /// [volume] indicates a value between 0.0 (silent) and 1.0 (full volume) on a
//   /// linear scale.
//   Future<void> setVolume(double volume) async {
//     value = value.copyWith(volume: volume.clamp(0.0, 1.0));
//     await _applyVolume();
//   }

//   /// Sets the speed of [this].
//   ///
//   /// [speed] indicates a value between 0.0 and 2.0 on a linear scale.
//   Future<void> setSpeed(double speed) async {
//     final double previousSpeed = value.speed;
//     try {
//       value = value.copyWith(speed: speed);
//       await _applySpeed();
//     } catch (exception) {
//       value = value.copyWith(speed: previousSpeed);
//       rethrow;
//     }
//   }

//   /// Sets the video track parameters of [this]
//   ///
//   /// [width] specifies width of the selected track
//   /// [height] specifies height of the selected track
//   /// [bitrate] specifies bitrate of the selected track
//   Future<void> setTrackParameters(int? width, int? height, int? bitrate) async {
//     await _videoPlayerPlatform.setTrackParameters(_textureId, width, height, bitrate);
//   }

//   Future<void> enablePictureInPicture(
//       {double? top, double? left, double? width, double? height}) async {
//     await _videoPlayerPlatform.enablePictureInPicture(textureId, top, left, width, height);
//   }

//   Future<void> disablePictureInPicture() async {
//     await _videoPlayerPlatform.disablePictureInPicture(textureId);
//   }

//   void _updatePosition(Duration? position, {DateTime? absolutePosition}) {
//     value = value.copyWith(position: _seekPosition ?? position);
//     if (_seekPosition == null) {
//       value = value.copyWith(absolutePosition: absolutePosition);
//     }
//   }

//   Future<bool?> isPictureInPictureSupported() async {
//     if (_textureId == null) {
//       return false;
//     }
//     return _videoPlayerPlatform.isPictureInPictureEnabled(_textureId);
//   }

//   void refresh() {
//     value = value.copyWith();
//   }

//   void setAudioTrack(String? name, int? index) {
//     _videoPlayerPlatform.setAudioTrack(_textureId, name, index);
//   }

//   void setMixWithOthers(bool mixWithOthers) {
//     _videoPlayerPlatform.setMixWithOthers(_textureId, mixWithOthers);
//   }

//   static Future clearCache() async {
//     return _videoPlayerPlatform.clearCache();
//   }

//   static Future preCache(DataSource dataSource, int preCacheSize) async {
//     return _videoPlayerPlatform.preCache(dataSource, preCacheSize);
//   }

//   static Future stopPreCache(String url, String? cacheKey) async {
//     return _videoPlayerPlatform.stopPreCache(url, cacheKey);
//   }
// }