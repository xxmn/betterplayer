import 'dart:async';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_create_provider.dart';
import 'np_platform_instance.dart';
import 'platform_interface.dart';

class _NPControllerNotifier {
  // /// Sets whether or not the video should loop after playing once. See also
  // /// [NPValue.isLooping].
  // Future<void> setLooping(bool looping) async {
  //   value = value.copyWith(isLooping: looping);
  //   await _applyLooping();
  // }

  // /// Pauses the video.
  // Future<void> pause() async {
  //   value = value.copyWith(isPlaying: false);
  //   await _applyPlayPause();
  // }

  // Future<void> _applyLooping() async {
  //   if (!_created || _isDisposed) {
  //     return;
  //   }
  //   await npPlatform.setLooping(_textureId, value.isLooping);
  // }

  // Future<void> _applyPlayPause() async {
  //   if (!mounted) return;
  //   var isPlaying = read(npStatusProvider.state);
  //   if (isPlaying) {
  //     await npPlatform.play(textureId);
  //   } else {
  //     await npPlatform.pause(textureId);
  //   }
  // }

  // Future<void> _applyVolume() async {
  //   if (!_created || _isDisposed) {
  //     return;
  //   }
  //   await npPlatform.setVolume(_textureId, value.volume);
  // }

  // Future<void> _applySpeed() async {
  //   if (!_created || _isDisposed) {
  //     return;
  //   }
  //   await npPlatform.setSpeed(_textureId, value.speed);
  // }

  // /// Sets the audio volume of [this].
  // ///
  // /// [volume] indicates a value between 0.0 (silent) and 1.0 (full volume) on a
  // /// linear scale.
  // Future<void> setVolume(double volume) async {
  //   value = value.copyWith(volume: volume.clamp(0.0, 1.0));
  //   await _applyVolume();
  // }

  // /// Sets the speed of [this].
  // ///
  // /// [speed] indicates a value between 0.0 and 2.0 on a linear scale.
  // Future<void> setSpeed(double speed) async {
  //   final double previousSpeed = value.speed;
  //   try {
  //     value = value.copyWith(speed: speed);
  //     await _applySpeed();
  //   } catch (exception) {
  //     value = value.copyWith(speed: previousSpeed);
  //     rethrow;
  //   }
  // }

  // /// Sets the video track parameters of [this]
  // ///
  // /// [width] specifies width of the selected track
  // /// [height] specifies height of the selected track
  // /// [bitrate] specifies bitrate of the selected track
  // Future<void> setTrackParameters(int? width, int? height, int? bitrate) async {
  //   await npPlatform.setTrackParameters(_textureId, width, height, bitrate);
  // }

  // Future<void> enablePictureInPicture(
  //     {double? top, double? left, double? width, double? height}) async {
  //   await npPlatform.enablePictureInPicture(textureId, top, left, width, height);
  // }

  // Future<void> disablePictureInPicture() async {
  //   await npPlatform.disablePictureInPicture(textureId);
  // }

  // void _updatePosition(Duration? position, {DateTime? absolutePosition}) {
  //   value = value.copyWith(position: _seekPosition ?? position);
  //   if (_seekPosition == null) {
  //     value = value.copyWith(absolutePosition: absolutePosition);
  //   }
  // }

  // Future<bool?> isPictureInPictureSupported() async {
  //   if (_textureId == null) {
  //     return false;
  //   }
  //   return npPlatform.isPictureInPictureEnabled(_textureId);
  // }

  // void refresh() {
  //   value = value.copyWith();
  // }

  // void setAudioTrack(String? name, int? index) {
  //   npPlatform.setAudioTrack(_textureId, name, index);
  // }

  // void setMixWithOthers(bool mixWithOthers) {
  //   npPlatform.setMixWithOthers(_textureId, mixWithOthers);
  // }

  // static Future clearCache() async {
  //   return npPlatform.clearCache();
  // }

  // static Future preCache(DataSource dataSource, int preCacheSize) async {
  //   return npPlatform.preCache(dataSource, preCacheSize);
  // }

  // static Future stopPreCache(String url, String? cacheKey) async {
  //   return npPlatform.stopPreCache(url, cacheKey);
  // }
}
