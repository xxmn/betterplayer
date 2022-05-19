// ///Widget _buildAudioTrackRow(BPAsmsAudioTrack audioTrack, bool isSelected) {}
// class AudioTrackRow extends HookConsumerWidget {
//   const AudioTrackRow({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         betterPlayerController!.setAudioTrack(audioTrack);
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
//               audioTrack.label!,
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _showAudioTracksSelectionWidget() {
//   //HLS / DASH
//   final List<BPAsmsAudioTrack>? asmsTracks = betterPlayerController!.betterPlayerAsmsAudioTracks;
//   final List<Widget> children = [];
//   final BPAsmsAudioTrack? selectedAsmsAudioTrack =
//       betterPlayerController!.betterPlayerAsmsAudioTrack;
//   if (asmsTracks != null) {
//     for (var index = 0; index < asmsTracks.length; index++) {
//       final bool isSelected =
//           selectedAsmsAudioTrack != null && selectedAsmsAudioTrack == asmsTracks[index];
//       children.add(_buildAudioTrackRow(asmsTracks[index], isSelected));
//     }
//   }

//   if (children.isEmpty) {
//     children.add(
//       _buildAudioTrackRow(
//         BPAsmsAudioTrack(
//           label: betterPlayerController!.translations.generalDefault,
//         ),
//         true,
//       ),
//     );
//   }
//   _showModalBottomSheet(children);
// }
