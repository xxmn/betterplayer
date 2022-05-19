// // Widget _buildResolutionSelectionRow(String name, String url)
// import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'text_style.dart';

// class ResolutionSelectionRow extends HookConsumerWidget {
//   const ResolutionSelectionRow({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final bool isSelected = url == betterPlayerController!.betterPlayerDataSource!.url;
//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         betterPlayerController!.setResolution(url);
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
//               name,
//               style: getTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
