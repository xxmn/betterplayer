import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:flutter/material.dart';

///Special version of Better Player which is used to play video in list view.
class BPListVideoPlayer extends StatefulWidget {
  ///Video to show
  final BPDataSource dataSource;

  ///Video player configuration
  final BPConfiguration configuration;

  ///Fraction of the screen height that will trigger play/pause. For example
  ///if playFraction is 0.6 video will be played if 60% of player height is
  ///visible.
  final double playFraction;

  ///Flag to determine if video should be auto played
  final bool autoPlay;

  ///Flag to determine if video should be auto paused
  final bool autoPause;

  final BPListVideoPlayerController? betterPlayerListVideoPlayerController;

  const BPListVideoPlayer(
    this.dataSource, {
    this.configuration = const BPConfiguration(),
    this.playFraction = 0.6,
    this.autoPlay = true,
    this.autoPause = true,
    this.betterPlayerListVideoPlayerController,
    Key? key,
  })  : assert(
            playFraction >= 0.0 && playFraction <= 1.0, "Play fraction can't be null and must be between 0.0 and 1.0"),
        super(key: key);

  @override
  _BPListVideoPlayerState createState() => _BPListVideoPlayerState();
}

class _BPListVideoPlayerState extends State<BPListVideoPlayer> with AutomaticKeepAliveClientMixin<BPListVideoPlayer> {
  BPController? _betterPlayerController;
  bool _isDisposing = false;

  @override
  void initState() {
    super.initState();
    _betterPlayerController = BPController(
      widget.configuration.copyWith(playerVisibilityChangedBehavior: onVisibilityChanged),
      betterPlayerDataSource: widget.dataSource,
      betterPlayerPlaylistConfiguration: const BPPlaylistConfiguration(),
    );

    if (widget.betterPlayerListVideoPlayerController != null) {
      widget.betterPlayerListVideoPlayerController!.setBPController(_betterPlayerController);
    }
  }

  @override
  void dispose() {
    _betterPlayerController!.dispose();
    _isDisposing = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: _betterPlayerController!.getAspectRatio() ?? BPUtils.calculateAspectRatio(context),
      child: BP(
        key: Key("${_getUniqueKey()}_player"),
        controller: _betterPlayerController!,
      ),
    );
  }

  void onVisibilityChanged(double visibleFraction) async {
    final bool? isPlaying = _betterPlayerController!.isPlaying();
    final bool? initialized = _betterPlayerController!.isVideoInitialized();
    if (visibleFraction >= widget.playFraction) {
      if (widget.autoPlay && initialized! && !isPlaying! && !_isDisposing) {
        _betterPlayerController!.play();
      }
    } else {
      if (widget.autoPause && initialized! && isPlaying! && !_isDisposing) {
        _betterPlayerController!.pause();
      }
    }
  }

  String _getUniqueKey() => widget.dataSource.hashCode.toString();

  @override
  bool get wantKeepAlive => true;
}
