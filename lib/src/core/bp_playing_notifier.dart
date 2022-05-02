import 'dart:async';

import 'package:better_player/src/configuration/better_player_data_source.dart';
import 'package:better_player/src/native_player/platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPPlayingNotifier with ChangeNotifier {
  BPPlayingNotifier();

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool _controlsEnabled = true;

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool get controlsEnabled => _controlsEnabled;

  ///Enable/disable controls (when enabled = false, controls will be always hidden)
  void setControlsEnabled(bool enabled) {
    if (_controlsEnabled != enabled) {
      _controlsEnabled = enabled;
      notifyListeners();
    }
  }

  /// The current volume of the playback.
  final double volume;

  /// The current speed of the playback
  final double speed;

  /// True if the video is playing. False if it's paused.
  final bool isPlaying;

  ///Flag which determines whenever player is playing or not.
  bool? isPlaying() {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController!.value.isPlaying;
  }

  ///Was player playing before automatic pause.
  bool? _wasPlayingBeforePause;

  /// True if the video is looping.
  /// Whether or not the video should loop
  final bool isLooping;

  /// The current playback position.
  final Duration position;
  Duration? _seekPosition;

  void updatePosition(
    Duration? position, {
    Duration? seekPosition,
    DateTime? absolutePosition,
  }) {
    this.position = seekPosition ?? position;
    if (seekPosition == null) {
      this.absolutePosition = absolutePosition;
    }
    notifyListeners();
  }

  /// Play the video as soon as it's displayed
  bool autoPlay;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
  final DateTime? absolutePosition;

  /// True if the video is currently buffering.
  final bool isBuffering;

  ///Flag which determines whenever player is loading video data or not.
  bool? isBuffering() {
    if (videoPlayerController == null) {
      throw StateError("The data source has not been initialized");
    }
    return videoPlayerController!.value.isBuffering;
  }

  /// The currently buffered ranges.
  final List<DurationRange> buffered;

  ///Playlist configuration used in controller instance.
  final BetterPlayerPlaylistConfiguration? betterPlayerPlaylistConfiguration;

  ///List of files to delete once player disposes.
  final List<File> _tempFiles = [];

  ///Flag used to store full screen mode state.
  bool _isFullScreen = false;

  ///Flag used to store full screen mode state.
  bool get isFullScreen => _isFullScreen;
  void set isFullScreen(bool isFull) {
    _isFullScreen = isFull;
    notifyListeners();
  }

  ///Time when last progress event was sent
  // int _lastPositionSelection = 0;

  ///Currently used data source in player.
  BPDataSource? _betterPlayerDataSource;

  ///Timer for next video. Used in playlist.
  Timer? _nextVideoTimer;

  ///Time for next video.
  int? _nextVideoTime;

  ///Handle VideoEvent when remote controls notification / PiP is shown
  void _handleVideoEvent(VideoEvent event) async {
    switch (event.eventType) {
      case VideoEventType.play:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.play));
        break;
      case VideoEventType.pause:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.pause));
        break;
      case VideoEventType.seek:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.seekTo));
        break;
      case VideoEventType.completed:
        final VideoPlayerValue? videoValue = videoPlayerController?.value;
        _postEvent(
          BetterPlayerEvent(
            BetterPlayerEventType.finished,
            parameters: <String, dynamic>{
              _progressParameter: videoValue?.position,
              _durationParameter: videoValue?.duration
            },
          ),
        );
        break;
      case VideoEventType.bufferingStart:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.bufferingStart));
        break;
      case VideoEventType.bufferingUpdate:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.bufferingUpdate, parameters: <String, dynamic>{
          _bufferedParameter: event.buffered,
        }));
        break;
      case VideoEventType.bufferingEnd:
        _postEvent(BetterPlayerEvent(BetterPlayerEventType.bufferingEnd));
        break;
      default:

        ///TODO: Handle when needed
        break;
    }
  }

  ///PreCache a video. On Android, the future succeeds when
  ///the requested size, specified in
  ///[BetterPlayerCacheConfiguration.preCacheSize], is downloaded or when the
  ///complete file is downloaded if the file is smaller than the requested size.
  ///On iOS, the whole file will be downloaded, since [maxCacheFileSize] is
  ///currently not supported on iOS. On iOS, the video format must be in this
  ///list: https://github.com/sendyhalim/Swime/blob/master/Sources/MimeType.swift
  Future<void> preCache(BetterPlayerDataSource betterPlayerDataSource) async {
    final cacheConfig =
        betterPlayerDataSource.cacheConfiguration ?? const BetterPlayerCacheConfiguration(useCache: true);

    final dataSource = DataSource(
      sourceType: DataSourceType.network,
      uri: betterPlayerDataSource.url,
      useCache: true,
      headers: betterPlayerDataSource.headers,
      maxCacheSize: cacheConfig.maxCacheSize,
      maxCacheFileSize: cacheConfig.maxCacheFileSize,
      cacheKey: cacheConfig.key,
      videoExtension: betterPlayerDataSource.videoExtension,
    );

    return VideoPlayerController.preCache(dataSource, cacheConfig.preCacheSize);
  }

  ///Stop pre cache for given [betterPlayerDataSource]. If there was no pre
  ///cache started for given [betterPlayerDataSource] then it will be ignored.
  Future<void> stopPreCache(BetterPlayerDataSource betterPlayerDataSource) async {
    return VideoPlayerController?.stopPreCache(
        betterPlayerDataSource.url, betterPlayerDataSource.cacheConfiguration?.key);
  }
}
