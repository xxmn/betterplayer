// import 'dart:async';
// import 'package:better_player/src/native_player/platform_interface.dart';
// import 'package:flutter/material.dart';

// final NativePlayerPlatform _videoPlayerPlatform = NativePlayerPlatform.instance
// // This will clear all open videos on the platform when a full restart is
// // performed.
//   ..init();

// class NPNotifer with ChangeNotifier {
//   /// Constructs a video with the given values. Only [duration] is required. The
//   /// rest will initialize with default values when unset.
//   NPNotifer();

//   final Completer<void> _creatingCompleter = Completer<void>();
//   int? _textureId;

//   /// This is just exposed for testing. It shouldn't be used by anyone depending
//   /// on the plugin.
//   @visibleForTesting
//   int? get textureId => _textureId;

//   Timer? _timer;
//   bool _isDisposed = false;
//   late Completer<void> _initializingCompleter;

//   bool get _created => _creatingCompleter.isCompleted;

//   /// Attempts to open the given [dataSource] and load metadata about the video.
//   Future<void> _create() async {
//     _textureId = await _videoPlayerPlatform.create(
//       bufferingConfiguration: bufferingConfiguration,
//     );
//     _creatingCompleter.complete(null);

//     unawaited(_applyLooping());
//     unawaited(_applyVolume());

//     void eventListener(VideoEvent event) {
//       if (_isDisposed) {
//         return;
//       }
//       videoEventStreamController.add(event);
//       switch (event.eventType) {
//         case VideoEventType.initialized:
//           value = value.copyWith(
//             duration: event.duration,
//             size: event.size,
//           );
//           _initializingCompleter.complete(null);
//           _applyPlayPause();
//           break;
//         case VideoEventType.completed:
//           value = value.copyWith(isPlaying: false, position: value.duration);
//           _timer?.cancel();
//           break;
//         case VideoEventType.bufferingUpdate:
//           value = value.copyWith(buffered: event.buffered);
//           break;
//         case VideoEventType.bufferingStart:
//           value = value.copyWith(isBuffering: true);
//           break;
//         case VideoEventType.bufferingEnd:
//           if (value.isBuffering) {
//             value = value.copyWith(isBuffering: false);
//           }
//           break;

//         case VideoEventType.play:
//           play();
//           break;
//         case VideoEventType.pause:
//           pause();
//           break;
//         case VideoEventType.seek:
//           seekTo(event.position);
//           break;
//         case VideoEventType.pipStart:
//           value = value.copyWith(isPip: true);
//           break;
//         case VideoEventType.pipStop:
//           value = value.copyWith(isPip: false);
//           break;
//         case VideoEventType.unknown:
//           break;
//       }
//     }

//     void errorListener(Object object) {
//       if (object is PlatformException) {
//         final PlatformException e = object;
//         value = value.copyWith(errorDescription: e.message);
//       } else {
//         value.copyWith(errorDescription: object.toString());
//       }
//       _timer?.cancel();
//       if (!_initializingCompleter.isCompleted) {
//         _initializingCompleter.completeError(object);
//       }
//     }

//     _eventSubscription = _videoPlayerPlatform.videoEventsFor(_textureId).listen(eventListener, onError: errorListener);
//   }

//   /// Set data source for playing a video from an asset.
//   ///
//   /// The name of the asset is given by the [dataSource] argument and must not be
//   /// null. The [package] argument must be non-null when the asset comes from a
//   /// package and null otherwise.
//   Future<void> setAssetDataSource(
//     String dataSource, {
//     String? package,
//     bool? showNotification,
//     String? title,
//     String? author,
//     String? imageUrl,
//     String? notificationChannelName,
//     Duration? overriddenDuration,
//     String? activityName,
//   }) {
//     return _setDataSource(
//       DataSource(
//         sourceType: DataSourceType.asset,
//         asset: dataSource,
//         package: package,
//         showNotification: showNotification,
//         title: title,
//         author: author,
//         imageUrl: imageUrl,
//         notificationChannelName: notificationChannelName,
//         overriddenDuration: overriddenDuration,
//         activityName: activityName,
//       ),
//     );
//   }

//   /// Set data source for playing a video from obtained from
//   /// the network.
//   ///
//   /// The URI for the video is given by the [dataSource] argument and must not be
//   /// null.
//   /// **Android only**: The [formatHint] option allows the caller to override
//   /// the video format detection code.
//   /// ClearKey DRM only supported on Android.
//   Future<void> setNetworkDataSource(
//     String dataSource, {
//     VideoFormat? formatHint,
//     Map<String, String?>? headers,
//     bool useCache = false,
//     int? maxCacheSize,
//     int? maxCacheFileSize,
//     String? cacheKey,
//     bool? showNotification,
//     String? title,
//     String? author,
//     String? imageUrl,
//     String? notificationChannelName,
//     Duration? overriddenDuration,
//     String? licenseUrl,
//     String? certificateUrl,
//     Map<String, String>? drmHeaders,
//     String? activityName,
//     String? clearKey,
//     String? videoExtension,
//   }) {
//     return _setDataSource(
//       DataSource(
//         sourceType: DataSourceType.network,
//         uri: dataSource,
//         formatHint: formatHint,
//         headers: headers,
//         useCache: useCache,
//         maxCacheSize: maxCacheSize,
//         maxCacheFileSize: maxCacheFileSize,
//         cacheKey: cacheKey,
//         showNotification: showNotification,
//         title: title,
//         author: author,
//         imageUrl: imageUrl,
//         notificationChannelName: notificationChannelName,
//         overriddenDuration: overriddenDuration,
//         licenseUrl: licenseUrl,
//         certificateUrl: certificateUrl,
//         drmHeaders: drmHeaders,
//         activityName: activityName,
//         clearKey: clearKey,
//         videoExtension: videoExtension,
//       ),
//     );
//   }

//   /// Set data source for playing a video from a file.
//   ///
//   /// This will load the file from the file-URI given by:
//   /// `'file://${file.path}'`.
//   Future<void> setFileDataSource(File file,
//       {bool? showNotification,
//       String? title,
//       String? author,
//       String? imageUrl,
//       String? notificationChannelName,
//       Duration? overriddenDuration,
//       String? activityName,
//       String? clearKey}) {
//     return _setDataSource(
//       DataSource(
//           sourceType: DataSourceType.file,
//           uri: 'file://${file.path}',
//           showNotification: showNotification,
//           title: title,
//           author: author,
//           imageUrl: imageUrl,
//           notificationChannelName: notificationChannelName,
//           overriddenDuration: overriddenDuration,
//           activityName: activityName,
//           clearKey: clearKey),
//     );
//   }

//   Future<void> _setDataSource(DataSource dataSourceDescription) async {
//     if (_isDisposed) {
//       return;
//     }

//     value = VideoPlayerValue(
//       duration: null,
//       isLooping: value.isLooping,
//       volume: value.volume,
//     );

//     if (!_creatingCompleter.isCompleted) await _creatingCompleter.future;

//     _initializingCompleter = Completer<void>();

//     await VideoPlayerPlatform.instance.setDataSource(_textureId, dataSourceDescription);
//     return _initializingCompleter.future;
//   }

//   @override
//   Future<void> dispose() async {
//     await _creatingCompleter.future;
//     if (!_isDisposed) {
//       _isDisposed = true;
//       value = VideoPlayerValue.uninitialized();
//       _timer?.cancel();
//       await _eventSubscription?.cancel();
//       await _videoPlayerPlatform.dispose(_textureId);
//       videoEventStreamController.close();
//     }
//     _isDisposed = true;
//     super.dispose();
//   }

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
//   /// [VideoPlayerValue.isLooping].
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

//   Future<void> enablePictureInPicture({double? top, double? left, double? width, double? height}) async {
//     await _videoPlayerPlatform.enablePictureInPicture(textureId, top, left, width, height);
//   }

//   Future<void> disablePictureInPicture() async {
//     await _videoPlayerPlatform.disablePictureInPicture(textureId);
//   }

//   Future<bool?> isPictureInPictureSupported() async {
//     if (_textureId == null) {
//       return false;
//     }
//     return _videoPlayerPlatform.isPictureInPictureEnabled(_textureId);
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
