// void _showSubtitlesSelectionWidget() {
//   final subtitles = List.of(betterPlayerController!.betterPlayerSubtitlesSourceList);
//   final noneSubtitlesElementExists =
//       subtitles.firstWhereOrNull((source) => source.type == BPSubtitlesSourceType.none) != null;
//   if (!noneSubtitlesElementExists) {
//     subtitles.add(BPSubtitlesSource(type: BPSubtitlesSourceType.none));
//   }

//   _showModalBottomSheet(subtitles.map((source) => _buildSubtitlesSourceRow(source)).toList());
// }

// // Widget _buildSubtitlesSourceRow(BPSubtitlesSource subtitlesSource) {}

// class SubtitlesSourceRow extends HookConsumerWidget {
//   const SubtitlesSourceRow({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedSourceType = betterPlayerController!.betterPlayerSubtitlesSource;
//     final bool isSelected = (subtitlesSource == selectedSourceType) ||
//         (subtitlesSource.type == BPSubtitlesSourceType.none &&
//             subtitlesSource.type == selectedSourceType!.type);

//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         betterPlayerController!.setupSubtitleSource(subtitlesSource);
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
//               subtitlesSource.type == BPSubtitlesSourceType.none
//                   ? betterPlayerController!.translations.generalNone
//                   : subtitlesSource.name ?? betterPlayerController!.translations.generalDefault,
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
