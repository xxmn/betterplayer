// import 'dart:io';
// import 'dart:math';
// import 'package:better_player/better_player.dart';
// import 'package:better_player/src/controls/better_player_clickable_widget.dart';
// import 'package:better_player/src/utils/better_player_utils.dart';
// import 'package:collection/collection.dart' show IterableExtension;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// ///Base class for both material and cupertino controls
// abstract class BPControlsState<T extends StatefulWidget> extends State<T> {
//   ///Min. time of buffered video to hide loading timer (in milliseconds)
//   static const int _bufferingInterval = 20000;

//   BPController? get bpController;

//   BPControlsCfg get bpControlsCfg;

//   VideoPlayerValue? get latestValue;

//   bool controlsNotVisible = true;
//   bool isLocked = false;

//   void cancelAndRestartTimer();

//   bool isVideoFinished(VideoPlayerValue? videoPlayerValue) {
//     return videoPlayerValue?.position != null &&
//         videoPlayerValue?.duration != null &&
//         videoPlayerValue!.position.inMilliseconds != 0 &&
//         videoPlayerValue.duration!.inMilliseconds != 0 &&
//         videoPlayerValue.position >= videoPlayerValue.duration!;
//   }

//   void skipBack() {
//     if (latestValue != null) {
//       cancelAndRestartTimer();
//       final beginning = const Duration().inMilliseconds;
//       final skip =
//           (latestValue!.position - Duration(milliseconds: bpControlsCfg.backwardSkipTimeInMilliseconds)).inMilliseconds;
//       bpController!.seekTo(Duration(milliseconds: max(skip, beginning)));
//     }
//   }

//   void skipForward() {
//     if (latestValue != null) {
//       cancelAndRestartTimer();
//       final end = latestValue!.duration!.inMilliseconds;
//       final skip =
//           (latestValue!.position + Duration(milliseconds: bpControlsCfg.forwardSkipTimeInMilliseconds)).inMilliseconds;
//       bpController!.seekTo(Duration(milliseconds: min(skip, end)));
//     }
//   }

//   void onShowMoreClicked() {
//     _showModalBottomSheet([_buildMoreOptionsList()]);
//   }

//   Widget _buildMoreOptionsList() {
//     final translations = bpController!.translations;
//     return SingleChildScrollView(
//       // ignore: avoid_unnecessary_containers
//       child: Container(
//         child: Column(
//           children: [
//             if (bpControlsCfg.enablePlaybackSpeed)
//               _buildMoreOptionsListRow(bpControlsCfg.playbackSpeedIcon, translations.overflowMenuPlaybackSpeed, () {
//                 Navigator.of(context).pop();
//                 _showSpeedChooserWidget();
//               }),
//             if (bpControlsCfg.enableSubtitles)
//               _buildMoreOptionsListRow(bpControlsCfg.subtitlesIcon, translations.overflowMenuSubtitles, () {
//                 Navigator.of(context).pop();
//                 _showSubtitlesSelectionWidget();
//               }),
//             if (bpControlsCfg.enableQualities)
//               _buildMoreOptionsListRow(bpControlsCfg.qualitiesIcon, translations.overflowMenuQuality, () {
//                 Navigator.of(context).pop();
//                 _showQualitiesSelectionWidget();
//               }),
//             if (bpControlsCfg.enableAudioTracks)
//               _buildMoreOptionsListRow(bpControlsCfg.audioTracksIcon, translations.overflowMenuAudioTracks, () {
//                 Navigator.of(context).pop();
//                 _showAudioTracksSelectionWidget();
//               }),
//             if (bpControlsCfg.overflowMenuCustomItems.isNotEmpty)
//               ...bpControlsCfg.overflowMenuCustomItems.map(
//                 (customItem) => _buildMoreOptionsListRow(
//                   customItem.icon,
//                   customItem.title,
//                   () {
//                     Navigator.of(context).pop();
//                     customItem.onClicked.call();
//                   },
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMoreOptionsListRow(IconData icon, String name, void Function() onTap) {
//     return BPMaterialClickableWidget(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//         child: Row(
//           children: [
//             const SizedBox(width: 8),
//             Icon(
//               icon,
//               color: bpControlsCfg.overflowMenuIconsColor,
//             ),
//             const SizedBox(width: 16),
//             Text(
//               name,
//               style: _getOverflowMenuElementTextStyle(false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSpeedChooserWidget() {
//     _showModalBottomSheet([
//       _buildSpeedRow(0.25),
//       _buildSpeedRow(0.5),
//       _buildSpeedRow(0.75),
//       _buildSpeedRow(1.0),
//       _buildSpeedRow(1.25),
//       _buildSpeedRow(1.5),
//       _buildSpeedRow(1.75),
//       _buildSpeedRow(2.0),
//     ]);
//   }

//   Widget _buildSpeedRow(double value) {
//     final bool isSelected = bpController!.videoPlayerController!.value.speed == value;

//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         bpController!.setSpeed(value);
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
//                   color: bpControlsCfg.overflowModalTextColor,
//                 )),
//             const SizedBox(width: 16),
//             Text(
//               "$value x",
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   ///Latest value can be null
//   bool isLoading(VideoPlayerValue? latestValue) {
//     if (latestValue != null) {
//       if (!latestValue.isPlaying && latestValue.duration == null) {
//         return true;
//       }

//       final Duration position = latestValue.position;

//       Duration? bufferedEndPosition;
//       if (latestValue.buffered.isNotEmpty == true) {
//         bufferedEndPosition = latestValue.buffered.last.end;
//       }

//       if (bufferedEndPosition != null) {
//         final difference = bufferedEndPosition - position;

//         if (latestValue.isPlaying && latestValue.isBuffering && difference.inMilliseconds < _bufferingInterval) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   void _showSubtitlesSelectionWidget() {
//     final subtitles = List.of(bpController!.bpSubtitlesSourceList);
//     final noneSubtitlesElementExists =
//         subtitles.firstWhereOrNull((source) => source.type == BPSubtitlesSourceType.none) != null;
//     if (!noneSubtitlesElementExists) {
//       subtitles.add(BPSubtitlesSource(type: BPSubtitlesSourceType.none));
//     }

//     _showModalBottomSheet(subtitles.map((source) => _buildSubtitlesSourceRow(source)).toList());
//   }

//   Widget _buildSubtitlesSourceRow(BPSubtitlesSource subtitlesSource) {
//     final selectedSourceType = bpController!.bpSubtitlesSource;
//     final bool isSelected = (subtitlesSource == selectedSourceType) ||
//         (subtitlesSource.type == BPSubtitlesSourceType.none && subtitlesSource.type == selectedSourceType!.type);

//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         bpController!.setupSubtitleSource(subtitlesSource);
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
//                   color: bpControlsCfg.overflowModalTextColor,
//                 )),
//             const SizedBox(width: 16),
//             Text(
//               subtitlesSource.type == BPSubtitlesSourceType.none
//                   ? bpController!.translations.generalNone
//                   : subtitlesSource.name ?? bpController!.translations.generalDefault,
//               style: _getOverflowMenuElementTextStyle(isSelected),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ///Build both track and resolution selection
//   ///Track selection is used for HLS / DASH videos
//   ///Resolution selection is used for normal videos
//   void _showQualitiesSelectionWidget() {
//     // HLS / DASH
//     final List<String> asmsTrackNames = bpController!.bpDataSource!.asmsTrackNames ?? [];
//     final List<BPAsmsTrack> asmsTracks = bpController!.bpAsmsTracks;
//     final List<Widget> children = [];
//     for (var index = 0; index < asmsTracks.length; index++) {
//       final track = asmsTracks[index];

//       String? preferredName;
//       if (track.height == 0 && track.width == 0 && track.bitrate == 0) {
//         preferredName = bpController!.translations.qualityAuto;
//       } else {
//         preferredName = asmsTrackNames.length > index ? asmsTrackNames[index] : null;
//       }
//       children.add(_buildTrackRow(asmsTracks[index], preferredName));
//     }

//     // normal videos
//     final resolutions = bpController!.bpDataSource!.resolutions;
//     resolutions?.forEach((key, value) {
//       children.add(_buildResolutionSelectionRow(key, value));
//     });

//     if (children.isEmpty) {
//       children.add(
//         _buildTrackRow(BPAsmsTrack.defaultTrack(), bpController!.translations.qualityAuto),
//       );
//     }

//     _showModalBottomSheet(children);
//   }

//   Widget _buildTrackRow(BPAsmsTrack track, String? preferredName) {
//     final int width = track.width ?? 0;
//     final int height = track.height ?? 0;
//     final int bitrate = track.bitrate ?? 0;
//     final String mimeType = (track.mimeType ?? '').replaceAll('video/', '');
//     final String trackName = preferredName ?? "${width}x$height ${BPUtils.formatBitrate(bitrate)} $mimeType";

//     final BPAsmsTrack? selectedTrack = bpController!.bpAsmsTrack;
//     final bool isSelected = selectedTrack != null && selectedTrack == track;

//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         bpController!.setTrack(track);
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
//                   color: bpControlsCfg.overflowModalTextColor,
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

//   Widget _buildResolutionSelectionRow(String name, String url) {
//     final bool isSelected = url == bpController!.bpDataSource!.url;
//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         bpController!.setResolution(url);
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
//                   color: bpControlsCfg.overflowModalTextColor,
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

//   void _showAudioTracksSelectionWidget() {
//     //HLS / DASH
//     final List<BPAsmsAudioTrack>? asmsTracks = bpController!.bpAsmsAudioTracks;
//     final List<Widget> children = [];
//     final BPAsmsAudioTrack? selectedAsmsAudioTrack = bpController!.bpAsmsAudioTrack;
//     if (asmsTracks != null) {
//       for (var index = 0; index < asmsTracks.length; index++) {
//         final bool isSelected = selectedAsmsAudioTrack != null && selectedAsmsAudioTrack == asmsTracks[index];
//         children.add(_buildAudioTrackRow(asmsTracks[index], isSelected));
//       }
//     }

//     if (children.isEmpty) {
//       children.add(
//         _buildAudioTrackRow(
//           BPAsmsAudioTrack(
//             label: bpController!.translations.generalDefault,
//           ),
//           true,
//         ),
//       );
//     }

//     _showModalBottomSheet(children);
//   }

//   Widget _buildAudioTrackRow(BPAsmsAudioTrack audioTrack, bool isSelected) {
//     return BPMaterialClickableWidget(
//       onTap: () {
//         Navigator.of(context).pop();
//         bpController!.setAudioTrack(audioTrack);
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
//                   color: bpControlsCfg.overflowModalTextColor,
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

//   TextStyle _getOverflowMenuElementTextStyle(bool isSelected) {
//     return TextStyle(
//       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       color: isSelected ? bpControlsCfg.overflowModalTextColor : bpControlsCfg.overflowModalTextColor.withOpacity(0.7),
//     );
//   }

//   void _showModalBottomSheet(List<Widget> children) {
//     Platform.isAndroid ? _showMaterialBottomSheet(children) : _showCupertinoModalBottomSheet(children);
//   }

//   void _showCupertinoModalBottomSheet(List<Widget> children) {
//     showCupertinoModalPopup<void>(
//       barrierColor: Colors.transparent,
//       context: context,
//       useRootNavigator: bpController?.bpCfg.useRootNavigator ?? false,
//       builder: (context) {
//         return SafeArea(
//           top: false,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//               decoration: BoxDecoration(
//                 color: bpControlsCfg.overflowModalColor,
//                 /*shape: RoundedRectangleBorder(side: Bor,borderRadius: 24,)*/
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//               ),
//               child: Column(
//                 children: children,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showMaterialBottomSheet(List<Widget> children) {
//     showModalBottomSheet<void>(
//       backgroundColor: Colors.transparent,
//       context: context,
//       useRootNavigator: bpController?.bpCfg.useRootNavigator ?? false,
//       builder: (context) {
//         return SafeArea(
//           top: false,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//               decoration: BoxDecoration(
//                 color: bpControlsCfg.overflowModalColor,
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
//               ),
//               child: Column(
//                 children: children,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   ///Builds directionality widget which wraps child widget and forces left to
//   ///right directionality.
//   Widget buildLTRDirectionality(Widget child) {
//     return Directionality(textDirection: TextDirection.ltr, child: child);
//   }

//   ///Called when player controls visibility should be changed.
//   void changePlayerControlsNotVisible(bool notVisible) {
//     setState(() {
//       if (notVisible) {
//         bpController?.postEvent(BPEvent(BPEventType.controlsHiddenStart));
//       }
//       controlsNotVisible = notVisible;
//     });
//   }

//   void setLocked(bool locked) {
//     setState(() {
//       if (locked) {
//         bpController?.postEvent(BPEvent(BPEventType.controlsLockStart));
//       }
//       isLocked = locked;
//     });
//   }
// }
