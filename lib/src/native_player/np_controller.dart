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

  // Future<void> _applyLooping() async {
  //   if (!_created || _isDisposed) {
  //     return;
  //   }
  //   await npPlatform.setLooping(_textureId, value.isLooping);
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
