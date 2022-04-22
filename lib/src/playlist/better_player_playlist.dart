import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/better_player_utils.dart';

// Flutter imports:
import 'package:flutter/material.dart';

///Special version of Better Player used to play videos in playlist.
class BPPlaylist extends StatefulWidget {
  final List<BPDataSource> betterPlayerDataSourceList;
  final BPConfiguration betterPlayerConfiguration;
  final BPPlaylistConfiguration betterPlayerPlaylistConfiguration;

  const BPPlaylist({
    Key? key,
    required this.betterPlayerDataSourceList,
    required this.betterPlayerConfiguration,
    required this.betterPlayerPlaylistConfiguration,
  }) : super(key: key);

  @override
  BPPlaylistState createState() => BPPlaylistState();
}

///State of BPPlaylist, used to access BPPlaylistController.
class BPPlaylistState extends State<BPPlaylist> {
  BPPlaylistController? _betterPlayerPlaylistController;

  BPController? get _betterPlayerController => _betterPlayerPlaylistController!.bpController;

  ///Get BPPlaylistController
  BPPlaylistController? get betterPlayerPlaylistController => _betterPlayerPlaylistController;

  @override
  void initState() {
    _betterPlayerPlaylistController = BPPlaylistController(
      widget.betterPlayerDataSourceList,
      betterPlayerConfiguration: widget.betterPlayerConfiguration,
      betterPlayerPlaylistConfiguration: widget.betterPlayerPlaylistConfiguration,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _betterPlayerController!.getAspectRatio() ?? BPUtils.calculateAspectRatio(context),
      child: BP(
        controller: _betterPlayerController!,
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerPlaylistController!.dispose();
    super.dispose();
  }
}
