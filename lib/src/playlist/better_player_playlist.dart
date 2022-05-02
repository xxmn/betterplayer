// import 'package:better_player/better_player.dart';
// import 'package:better_player/src/utils/better_player_utils.dart';

// // Flutter imports:
// import 'package:flutter/material.dart';

// ///Special version of Better Player used to play videos in playlist.
// class BPPlaylist extends StatefulWidget {
//   final List<BPDataSource> bpDataSourceList;
//   final BPConfiguration bpCfg;
//   final BPPlaylistCfg bpPlaylistCfg;

//   const BPPlaylist({
//     Key? key,
//     required this.bpDataSourceList,
//     required this.bpCfg,
//     required this.bpPlaylistCfg,
//   }) : super(key: key);

//   @override
//   BPPlaylistState createState() => BPPlaylistState();
// }

// ///State of BPPlaylist, used to access BPPlaylistController.
// class BPPlaylistState extends State<BPPlaylist> {
//   BPPlaylistController? _bpPlaylistController;

//   BPController? get _bpController => _bpPlaylistController!.bpController;

//   ///Get BPPlaylistController
//   BPPlaylistController? get bpPlaylistController => _bpPlaylistController;

//   @override
//   void initState() {
//     _bpPlaylistController = BPPlaylistController(
//       widget.bpDataSourceList,
//       bpCfg: widget.bpCfg,
//       bpPlaylistCfg: widget.bpPlaylistCfg,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: _bpController!.getAspectRatio() ?? BPUtils.calculateAspectRatio(context),
//       child: BP(
//         controller: _bpController!,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _bpPlaylistController!.dispose();
//     super.dispose();
//   }
// }
