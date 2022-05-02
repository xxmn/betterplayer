import 'package:better_player/src/configuration/better_player_controls_configuration.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_configuration.dart';

///Cfg of Better Player. Allows to setup general behavior of player.
///Master configuration which contains children that configure specific part
///of player.
class BPConfiguration {
  /// The Aspect Ratio of the Video. Important to get the correct size of the
  /// video!
  ///
  /// Will fallback to fitting within the space allowed.
  double? aspectRatio;

  /// Defines aspect ratio which will be used in fullscreen
  double? fullScreenAspectRatio;

  ///Defines subtitles configuration
  BPSubtitlesCfg subtitlesCfg;

  ///Defines controls configuration
  BPControlsCfg controlsCfg;

  BPConfiguration({
    this.aspectRatio,
    this.fullScreenAspectRatio,
    this.subtitlesCfg = const BPSubtitlesCfg(),
    this.controlsCfg = const BPControlsCfg(),
  });

  BPConfiguration copyWith({
    double? aspectRatio,
    double? fullScreenAspectRatio,
    BPSubtitlesCfg? subtitlesCfg,
    BPControlsCfg? controlsCfg,
  }) {
    return BPConfiguration(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      fullScreenAspectRatio: fullScreenAspectRatio ?? this.fullScreenAspectRatio,
      subtitlesCfg: subtitlesCfg ?? this.subtitlesCfg,
      controlsCfg: controlsCfg ?? this.controlsCfg,
    );
  }
}
