// import 'package:better_player/src/asms/bp_asms_track.dart';
// import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
// import 'package:better_player/src/utils/bp_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// ///Build both track and resolution selection
// ///Track selection is used for HLS / DASH videos
// ///Resolution selection is used for normal videos
// void _showQualitiesSelectionWidget() {
//   // HLS / DASH
//   final List<String> asmsTrackNames =
//       betterPlayerController!.betterPlayerDataSource!.asmsTrackNames ?? [];
//   final List<BPAsmsTrack> asmsTracks = betterPlayerController!.betterPlayerAsmsTracks;
//   final List<Widget> children = [];
//   for (var index = 0; index < asmsTracks.length; index++) {
//     final track = asmsTracks[index];

//     String? preferredName;
//     if (track.height == 0 && track.width == 0 && track.bitrate == 0) {
//       preferredName = betterPlayerController!.translations.qualityAuto;
//     } else {
//       preferredName = asmsTrackNames.length > index ? asmsTrackNames[index] : null;
//     }
//     children.add(_buildTrackRow(asmsTracks[index], preferredName));
//   }

//   // normal videos
//   final resolutions = betterPlayerController!.betterPlayerDataSource!.resolutions;
//   resolutions?.forEach((key, value) {
//     children.add(_buildResolutionSelectionRow(key, value));
//   });

//   if (children.isEmpty) {
//     children.add(
//       _buildTrackRow(BPAsmsTrack.defaultTrack(), betterPlayerController!.translations.qualityAuto),
//     );
//   }

//   _showModalBottomSheet(children);
// }

// // Widget _buildTrackRow(BPAsmsTrack track, String? preferredName) {}
// class TrackRow extends HookConsumerWidget {
//   const TrackRow({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final int width = track.width ?? 0;
//     final int height = track.height ?? 0;
//     final int bitrate = track.bitrate ?? 0;
//     final String mimeType = (track.mimeType ?? '').replaceAll('video/', '');
//     final String trackName =
//         preferredName ?? "${width}x$height ${BPUtils.formatBitrate(bitrate)} $mimeType";

//     final BPAsmsTrack? selectedTrack = betterPlayerController!.betterPlayerAsmsTrack;
//     final bool isSelected = selectedTrack != null && selectedTrack == track;

//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         betterPlayerController!.setTrack(track);
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         child: Row(
//           children: [
//             SizedBox(width: isSelected ? 8 : 16),
//             Visibility(
//                 visible: isSelected,
//                 child: Icon(
//                   Icons.check_outlined,
//                   color: betterPlayerControlsConfiguration.overflowModalTextColor,
//                 )),
//             const SizedBox(width: 16),
//             Text(
//               trackName,
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
