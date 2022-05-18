import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoreButton extends HookConsumerWidget {
  const MoreButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var overflowMenuIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowMenuIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      onTap: () {
        onShowMoreClicked();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          overflowMenuIcon,
          color: iconsColor,
        ),
      ),
    );
  }

  void onShowMoreClicked() {
    print("onShowMoreClicked.");
    // todo:
    // _showModalBottomSheet([MoreOptionsList()]);
  }

  // void _showSubtitlesSelectionWidget() {
  //   final subtitles = List.of(betterPlayerController!.betterPlayerSubtitlesSourceList);
  //   final noneSubtitlesElementExists =
  //       subtitles.firstWhereOrNull((source) => source.type == BPSubtitlesSourceType.none) != null;
  //   if (!noneSubtitlesElementExists) {
  //     subtitles.add(BPSubtitlesSource(type: BPSubtitlesSourceType.none));
  //   }

  //   _showModalBottomSheet(subtitles.map((source) => _buildSubtitlesSourceRow(source)).toList());
  // }

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
  //       _buildTrackRow(
  //           BPAsmsTrack.defaultTrack(), betterPlayerController!.translations.qualityAuto),
  //     );
  //   }

  //   _showModalBottomSheet(children);
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
}

// // Widget _buildResolutionSelectionRow(String name, String url)
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
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

class MoreOptionsList extends HookConsumerWidget {
  const MoreOptionsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(bpTranslationsProvider!);
    final enablePlaybackSpeed =
        ref.watch(bpControlsConfigProvider!.select((v) => v.enablePlaybackSpeed));
    final playbackSpeedIcon =
        ref.watch(bpControlsConfigProvider!.select((v) => v.playbackSpeedIcon));
    return SingleChildScrollView(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            if (enablePlaybackSpeed)
              MoreOptionsListRow(
                playbackSpeedIcon,
                translations.overflowMenuPlaybackSpeed,
                () {
                  //todo:
                  // Navigator.of(context).pop();
                  // _showSpeedChooserWidget();
                },
              ),
            // todo:
            // if (betterPlayerControlsConfiguration.enableSubtitles)
            //   MoreOptionsListRow(betterPlayerControlsConfiguration.subtitlesIcon,
            //       translations.overflowMenuSubtitles, () {
            //     Navigator.of(context).pop();
            //     _showSubtitlesSelectionWidget();
            //   }),
            // if (betterPlayerControlsConfiguration.enableQualities)
            //   MoreOptionsListRow(
            //       betterPlayerControlsConfiguration.qualitiesIcon, translations.overflowMenuQuality,
            //       () {
            //     Navigator.of(context).pop();
            //     _showQualitiesSelectionWidget();
            //   }),
            // if (betterPlayerControlsConfiguration.enableAudioTracks)
            //   MoreOptionsListRow(betterPlayerControlsConfiguration.audioTracksIcon,
            //       translations.overflowMenuAudioTracks, () {
            //     Navigator.of(context).pop();
            //     _showAudioTracksSelectionWidget();
            //   }),
            // if (betterPlayerControlsConfiguration.overflowMenuCustomItems.isNotEmpty)
            //   ...betterPlayerControlsConfiguration.overflowMenuCustomItems.map(
            //     (customItem) => MoreOptionsListRow(
            //       customItem.icon,
            //       customItem.title,
            //       () {
            //         Navigator.of(context).pop();
            //         customItem.onClicked.call();
            //       },
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}

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

TextStyle _getOverflowMenuElementTextStyle(bool isSelected, Color overflowModalTextColor) {
  return TextStyle(
    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
    color: isSelected ? overflowModalTextColor : overflowModalTextColor.withOpacity(0.7),
  );
}

// Widget _buildSpeedRow(double value) {}
class SpeedRow extends HookConsumerWidget {
  final double value;
  const SpeedRow(this.value, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var overflowModalTextColor =
        ref.watch(bpControlsConfigProvider!.select((v) => v.overflowModalTextColor));
    var speed = ref.watch(npStatusProvider.select((v) => v.speed));
    final bool isSelected = speed == value;

    return BPMaterialClickableWidget(
      onTap: () {
        // todo:
        // Navigator.of(context).pop();
        // betterPlayerController!.setSpeed(value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            SizedBox(width: isSelected ? 8 : 16),
            Visibility(
                visible: isSelected,
                child: Icon(
                  Icons.check_outlined,
                  color: overflowModalTextColor,
                )),
            const SizedBox(width: 16),
            Text(
              "$value x",
              style: _getOverflowMenuElementTextStyle(isSelected, overflowModalTextColor),
            )
          ],
        ),
      ),
    );
  }
}

class MoreOptionsListRow extends HookConsumerWidget {
  final IconData icon;
  final String name;
  final void Function() onTap;
  const MoreOptionsListRow(this.icon, this.name, this.onTap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowMenuIconsColor));
    var textColor = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowModalTextColor));
    return BPMaterialClickableWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(icon, color: iconsColor),
            const SizedBox(width: 16),
            Text(
              name,
              style: _getOverflowMenuElementTextStyle(false, textColor),
            ),
          ],
        ),
      ),
    );
  }
}

// void _showSpeedChooserWidget(BuildContext context) {
//   _showModalBottomSheet(
//     [
//       SpeedRow(0.5),
//       SpeedRow(0.25),
//       SpeedRow(0.75),
//       SpeedRow(1.0),
//       SpeedRow(1.25),
//       SpeedRow(1.5),
//       SpeedRow(1.75),
//       SpeedRow(2.0),
//     ],
//     context,
//   );
// }

// void _showModalBottomSheet(List<Widget> children, BuildContext context) {
//   Platform.isAndroid
//       ? _showMaterialBottomSheet(children)
//       : _showCupertinoModalBottomSheet(children);
// }

// void _showMaterialBottomSheet(List<Widget> children, BuildContext context) {
//   showModalBottomSheet<void>(
//     backgroundColor: Colors.transparent,
//     context: context,
//     useRootNavigator: betterPlayerController?.betterPlayerConfiguration.useRootNavigator ?? false,
//     builder: (context) {
//       return SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//             decoration: BoxDecoration(
//               color: betterPlayerControlsConfiguration.overflowModalColor,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//             ),
//             child: Column(
//               children: children,
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// void _showCupertinoModalBottomSheet(List<Widget> children, BuildContext context) {
//   showCupertinoModalPopup<void>(
//     barrierColor: Colors.transparent,
//     context: context,
//     useRootNavigator: betterPlayerController?.betterPlayerConfiguration.useRootNavigator ?? false,
//     builder: (context) {
//       return SafeArea(
//         top: false,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//             decoration: BoxDecoration(
//               color: betterPlayerControlsConfiguration.overflowModalColor,
//               /*shape: RoundedRectangleBorder(side: Bor,borderRadius: 24,)*/
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//             ),
//             child: Column(
//               children: children,
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
