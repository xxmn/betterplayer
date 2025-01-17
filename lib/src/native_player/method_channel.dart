// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:typed_data';
import 'package:better_player/src/config/bp_buffering_config.dart';
import 'package:better_player/src/defines/duration_range.dart';
import 'package:better_player/src/defines/np_data_source.dart';
import 'package:better_player/src/defines/np_event.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'platform_interface.dart';

const MethodChannel _channel = MethodChannel('better_player_channel');

/// An implementation of [VideoPlayerPlatform] that uses method channels.
class NativePlayerMethodChannel extends NativePlayerPlatform {
  @override
  Future<void> init() {
    return _channel.invokeMethod<void>('init');
  }

  @override
  Future<void> dispose(int? textureId) {
    return _channel.invokeMethod<void>(
      'dispose',
      <String, dynamic>{'textureId': textureId},
    );
  }

  @override
  Future<int?> create({
    BPBufferingConfig? bufferingConfig,
  }) async {
    late final Map<String, dynamic>? response;
    if (bufferingConfig == null) {
      response = await _channel.invokeMapMethod<String, dynamic>('create');
    } else {
      final responseLinkedHashMap = await _channel.invokeMethod<Map?>(
        'create',
        <String, dynamic>{
          'minBufferMs': bufferingConfig.minBufferMs,
          'maxBufferMs': bufferingConfig.maxBufferMs,
          'bufferForPlaybackMs': bufferingConfig.bufferForPlaybackMs,
          'bufferForPlaybackAfterRebufferMs': bufferingConfig.bufferForPlaybackAfterRebufferMs,
        },
      );

      response =
          responseLinkedHashMap != null ? Map<String, dynamic>.from(responseLinkedHashMap) : null;
    }
    return response?['textureId'] as int?;
  }

  /// todo: asset 类型不支持audio、video 分离
  @override
  Future<void> setDataSource(int? textureId, NPDataSource dataSource) async {
    Map<String, dynamic>? dataSourceDescription;
    switch (dataSource.sourceType) {
      case NPDataSourceType.asset:
        dataSourceDescription = <String, dynamic>{
          'key': dataSource.key,
          'asset': dataSource.asset,
          'package': dataSource.package,
          'useCache': false,
          'maxCacheSize': 0,
          'maxCacheFileSize': 0,
          'showNotification': dataSource.showNotification,
          'title': dataSource.title,
          'author': dataSource.author,
          'imageUrl': dataSource.imageUrl,
          'notificationChannelName': dataSource.notificationChannelName,
          'overriddenDuration': dataSource.overriddenDuration?.inMilliseconds,
          'startAt': dataSource.startAt?.inMilliseconds,
          'activityName': dataSource.activityName
        };
        break;
      case NPDataSourceType.network:
        dataSourceDescription = <String, dynamic>{
          'key': dataSource.key,
          'uri': dataSource.uri,
          'audioUri': dataSource.audioUri,
          'formatHint': dataSource.rawFormalHint,
          'headers': dataSource.headers,
          'useCache': dataSource.useCache,
          'maxCacheSize': dataSource.maxCacheSize,
          'maxCacheFileSize': dataSource.maxCacheFileSize,
          'cacheKey': dataSource.cacheKey,
          'showNotification': dataSource.showNotification,
          'title': dataSource.title,
          'author': dataSource.author,
          'imageUrl': dataSource.imageUrl,
          'notificationChannelName': dataSource.notificationChannelName,
          'overriddenDuration': dataSource.overriddenDuration?.inMilliseconds,
          'startAt': dataSource.startAt?.inMilliseconds,
          'licenseUrl': dataSource.licenseUrl,
          'certificateUrl': dataSource.certificateUrl,
          'drmHeaders': dataSource.drmHeaders,
          'activityName': dataSource.activityName,
          'clearKey': dataSource.clearKey,
          'videoExtension': dataSource.videoExtension,
        };
        break;
      case NPDataSourceType.file:
        dataSourceDescription = <String, dynamic>{
          'key': dataSource.key,
          'uri': dataSource.uri,
          'audioUri': dataSource.audioUri,
          'useCache': false,
          'maxCacheSize': 0,
          'maxCacheFileSize': 0,
          'showNotification': dataSource.showNotification,
          'title': dataSource.title,
          'author': dataSource.author,
          'imageUrl': dataSource.imageUrl,
          'notificationChannelName': dataSource.notificationChannelName,
          'overriddenDuration': dataSource.overriddenDuration?.inMilliseconds,
          'startAt': dataSource.startAt?.inMilliseconds,
          'activityName': dataSource.activityName,
          'clearKey': dataSource.clearKey
        };
        break;
    }
    await _channel.invokeMethod<void>(
      'setDataSource',
      <String, dynamic>{
        'textureId': textureId,
        'dataSource': dataSourceDescription,
      },
    );
    return;
  }

  @override
  Future<void> setLooping(int? textureId, bool looping) {
    return _channel.invokeMethod<void>(
      'setLooping',
      <String, dynamic>{
        'textureId': textureId,
        'looping': looping,
      },
    );
  }

  @override
  Future<void> play(int? textureId) {
    return _channel.invokeMethod<void>(
      'play',
      <String, dynamic>{'textureId': textureId},
    );
  }

  @override
  Future<void> pause(int? textureId) {
    return _channel.invokeMethod<void>(
      'pause',
      <String, dynamic>{'textureId': textureId},
    );
  }

  @override
  Future<Uint8List?> screenshot(int? textureId) {
    return _channel.invokeMethod<Uint8List?>(
      'screenshot',
      <String, dynamic>{'textureId': textureId},
    );
  }

  @override
  Future<void> setVolume(int? textureId, double volume) {
    return _channel.invokeMethod<void>(
      'setVolume',
      <String, dynamic>{
        'textureId': textureId,
        'volume': volume,
      },
    );
  }

  @override
  Future<void> setSpeed(int? textureId, double speed) {
    return _channel.invokeMethod<void>(
      'setSpeed',
      <String, dynamic>{
        'textureId': textureId,
        'speed': speed,
      },
    );
  }

  @override
  Future<void> setTrackParameters(int? textureId, int? width, int? height, int? bitrate) {
    return _channel.invokeMethod<void>(
      'setTrackParameters',
      <String, dynamic>{
        'textureId': textureId,
        'width': width,
        'height': height,
        'bitrate': bitrate,
      },
    );
  }

  @override
  Future<void> seekTo(int? textureId, Duration? position) {
    return _channel.invokeMethod<void>(
      'seekTo',
      <String, dynamic>{
        'textureId': textureId,
        'location': position!.inMilliseconds,
      },
    );
  }

  @override
  Future<Duration> getPosition(int? textureId) async {
    return Duration(
        milliseconds: await _channel.invokeMethod<int>(
              'position',
              <String, dynamic>{'textureId': textureId},
            ) ??
            0);
  }

  @override
  Future<DateTime?> getAbsolutePosition(int? textureId) async {
    final int milliseconds = await _channel.invokeMethod<int>(
          'absolutePosition',
          <String, dynamic>{'textureId': textureId},
        ) ??
        0;

    if (milliseconds <= 0) return null;

    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  Future<void> enablePictureInPicture(
      int? textureId, double? top, double? left, double? width, double? height) async {
    return _channel.invokeMethod<void>(
      'enablePictureInPicture',
      <String, dynamic>{
        'textureId': textureId,
        'top': top,
        'left': left,
        'width': width,
        'height': height,
      },
    );
  }

  @override
  Future<bool?> isPictureInPictureEnabled(int? textureId) {
    return _channel.invokeMethod<bool>(
      'isPictureInPictureSupported',
      <String, dynamic>{
        'textureId': textureId,
      },
    );
  }

  @override
  Future<void> disablePictureInPicture(int? textureId) {
    return _channel.invokeMethod<bool>(
      'disablePictureInPicture',
      <String, dynamic>{
        'textureId': textureId,
      },
    );
  }

  @override
  Future<void> setAudioTrack(int? textureId, String? name, int? index) {
    return _channel.invokeMethod<void>(
      'setAudioTrack',
      <String, dynamic>{
        'textureId': textureId,
        'name': name,
        'index': index,
      },
    );
  }

  @override
  Future<void> setMixWithOthers(int? textureId, bool mixWithOthers) {
    return _channel.invokeMethod<void>(
      'setMixWithOthers',
      <String, dynamic>{
        'textureId': textureId,
        'mixWithOthers': mixWithOthers,
      },
    );
  }

  @override
  Future<void> clearCache() {
    return _channel.invokeMethod<void>(
      'clearCache',
      <String, dynamic>{},
    );
  }

  @override
  Future<void> preCache(NPDataSource dataSource, int preCacheSize) {
    final Map<String, dynamic> dataSourceDescription = <String, dynamic>{
      'key': dataSource.key,
      'uri': dataSource.uri,
      'certificateUrl': dataSource.certificateUrl,
      'headers': dataSource.headers,
      'maxCacheSize': dataSource.maxCacheSize,
      'maxCacheFileSize': dataSource.maxCacheFileSize,
      'preCacheSize': preCacheSize,
      'cacheKey': dataSource.cacheKey,
      'videoExtension': dataSource.videoExtension,
    };
    return _channel.invokeMethod<void>(
      'preCache',
      <String, dynamic>{
        'dataSource': dataSourceDescription,
      },
    );
  }

  @override
  Future<void> stopPreCache(String url, String? cacheKey) {
    return _channel.invokeMethod<void>(
      'stopPreCache',
      <String, dynamic>{'url': url, 'cacheKey': cacheKey},
    );
  }

  @override
  Stream<NPVideoEvent> videoEventsFor(int textureId) {
    return _eventChannelFor(textureId).receiveBroadcastStream().map((dynamic event) {
      late Map<dynamic, dynamic> map;
      if (event is Map) {
        map = event;
      }
      final String? eventType = map["event"] as String?;
      final String? key = map["key"] as String?;
      switch (eventType) {
        case 'initialized':
          double width = 0;
          double height = 0;

          try {
            if (map.containsKey("width")) {
              final num widthNum = map["width"] as num;
              width = widthNum.toDouble();
            }
            if (map.containsKey("height")) {
              final num heightNum = map["height"] as num;
              height = heightNum.toDouble();
            }
          } catch (exception) {
            BPUtils.log(exception.toString());
          }

          final Size size = Size(width, height);

          return NPVideoEvent(
            eventType: NPVideoEventType.initialized,
            key: key,
            duration: Duration(milliseconds: map['duration'] as int),
            size: size,
          );
        case 'completed':
          return NPVideoEvent(
            eventType: NPVideoEventType.completed,
            key: key,
          );
        case 'bufferingUpdate':
          final List<dynamic> values = map['values'] as List;

          return NPVideoEvent(
            eventType: NPVideoEventType.bufferingUpdate,
            key: key,
            buffered: values.map<DurationRange>(_toDurationRange).toList(),
          );
        case 'bufferingStart':
          return NPVideoEvent(
            eventType: NPVideoEventType.bufferingStart,
            key: key,
          );
        case 'bufferingEnd':
          return NPVideoEvent(
            eventType: NPVideoEventType.bufferingEnd,
            key: key,
          );
        case 'playingChanged':
          final String? isPlaying = map["value"] as String?;
          return NPVideoEvent(
            eventType: NPVideoEventType.playingChanged,
            key: key,
            value: isPlaying,
          );
        case 'volumeChanged':
          final double volume = map["volume"] as double;
          return NPVideoEvent(
            eventType: NPVideoEventType.volumeChanged,
            key: key,
            dValue: volume,
          );
        case 'updatePosition':
          final int? position = map["position"] as int?;
          // final int? absolutePosition = map["absolutePosition"] as int?;

          return NPVideoEvent(
            eventType: NPVideoEventType.updatePosition,
            key: key,
            position: position != null ? Duration(milliseconds: position) : null,

            // todo: 未弄清楚，可能是absolutePosition:-9223372036854758765
            // absolutePosition: absolutePosition != null
            //     ? DateTime.fromMillisecondsSinceEpoch(absolutePosition)
            //     : null,
          );

        case 'play':
          return NPVideoEvent(
            eventType: NPVideoEventType.play,
            key: key,
          );

        case 'pause':
          return NPVideoEvent(
            eventType: NPVideoEventType.pause,
            key: key,
          );

        case 'screenshot':
          return NPVideoEvent(
            eventType: NPVideoEventType.screenshot,
            key: key,
          );

        case 'seek':
          return NPVideoEvent(
            eventType: NPVideoEventType.seek,
            key: key,
            position: Duration(milliseconds: map['position'] as int),
          );

        case 'pipStart':
          return NPVideoEvent(
            eventType: NPVideoEventType.pipStart,
            key: key,
          );

        case 'pipStop':
          return NPVideoEvent(
            eventType: NPVideoEventType.pipStop,
            key: key,
          );

        default:
          print("--------------unknown event:$event");
          return NPVideoEvent(
            eventType: NPVideoEventType.unknown,
            key: key,
          );
      }
    });
  }

  @override
  Widget buildView(int? textureId) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'com.jhomlala/better_player',
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: {'textureId': textureId!},
      );
    } else {
      return Texture(textureId: textureId!);
    }
  }

  EventChannel _eventChannelFor(int? textureId) {
    return EventChannel('better_player_channel/videoEvents$textureId');
  }

  DurationRange _toDurationRange(dynamic value) {
    final List<dynamic> pair = value as List;
    return DurationRange(
      Duration(milliseconds: pair[0] as int),
      Duration(milliseconds: pair[1] as int),
    );
  }
}
