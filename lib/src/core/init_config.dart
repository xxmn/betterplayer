import 'package:better_player/src/config/bp_config.dart';
import 'package:better_player/src/controls/bp_config.dart';
import 'package:better_player/src/core/bp_app_lifecycle_provider.dart';
import 'package:better_player/src/defines/bp_data_source.dart';
import 'package:better_player/src/fullscreen/bp_config.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config.dart';

class BPInitConfig {
  BPInitConfig({
    required this.dataSource,
    this.config,
    this.fullScreenConfig,
    this.subtitlesConfig,
    this.controlsConfig,
    this.appLifecycle,
  });

  ///General configuration used in controller instance.
  BPConfig? config;
  final BPFullScreenConfig? fullScreenConfig;

  // ///Playlist configuration used in controller instance.
  // final BPPlaylistConfig? bpPlaylistConfig;

  // ///Currently used data source in player.
  final BPDataSource dataSource;

  // ///Defines subtitles configuration
  BPSubtitlesConfig? subtitlesConfig;

  ///Defines controls configuration
  BPControlsConfig? controlsConfig;

  //
  BPAppLifecycle? appLifecycle;
}
