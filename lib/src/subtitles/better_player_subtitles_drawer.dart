// import 'dart:async';
// import 'package:better_player/better_player.dart';
// import 'package:better_player/src/subtitles/better_player_subtitle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

// class BPSubtitlesDrawer extends StatefulWidget {
//   final List<BPSubtitle> subtitles;
//   final BPController bpController;
//   final BPSubtitlesCfg? bpSubtitlesCfg;
//   final Stream<bool> playerVisibilityStream;

//   const BPSubtitlesDrawer({
//     Key? key,
//     required this.subtitles,
//     required this.bpController,
//     this.bpSubtitlesCfg,
//     required this.playerVisibilityStream,
//   }) : super(key: key);

//   @override
//   _BPSubtitlesDrawerState createState() => _BPSubtitlesDrawerState();
// }

// class _BPSubtitlesDrawerState extends State<BPSubtitlesDrawer> {
//   final RegExp htmlRegExp =
//       // ignore: unnecessary_raw_strings
//       RegExp(r"<[^>]*>", multiLine: true);
//   late TextStyle _innerTextStyle;
//   late TextStyle _outerTextStyle;

//   VideoPlayerValue? _latestValue;
//   BPSubtitlesCfg? _configuration;
//   bool _playerVisible = false;

//   ///Stream used to detect if play controls are visible or not
//   late StreamSubscription _visibilityStreamSubscription;

//   @override
//   void initState() {
//     _visibilityStreamSubscription = widget.playerVisibilityStream.listen((state) {
//       setState(() {
//         _playerVisible = state;
//       });
//     });

//     if (widget.bpSubtitlesCfg != null) {
//       _configuration = widget.bpSubtitlesCfg;
//     } else {
//       _configuration = setupDefaultCfg();
//     }

//     widget.bpController.videoPlayerController!.addListener(_updateState);

//     _outerTextStyle = TextStyle(
//         fontSize: _configuration!.fontSize,
//         fontFamily: _configuration!.fontFamily,
//         foreground: Paint()
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = _configuration!.outlineSize
//           ..color = _configuration!.outlineColor);

//     _innerTextStyle = TextStyle(
//         fontFamily: _configuration!.fontFamily, color: _configuration!.fontColor, fontSize: _configuration!.fontSize);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     widget.bpController.videoPlayerController!.removeListener(_updateState);
//     _visibilityStreamSubscription.cancel();
//     super.dispose();
//   }

//   ///Called when player state has changed, i.e. new player position, etc.
//   void _updateState() {
//     if (mounted) {
//       setState(() {
//         _latestValue = widget.bpController.videoPlayerController!.value;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final BPSubtitle? subtitle = _getSubtitleAtCurrentPosition();
//     widget.bpController.renderedSubtitle = subtitle;
//     final List<String> subtitles = subtitle?.texts ?? [];
//     final List<Widget> textWidgets = subtitles.map((text) => _buildSubtitleTextWidget(text)).toList();

//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       child: Padding(
//         padding: EdgeInsets.only(
//             bottom: _playerVisible ? _configuration!.bottomPadding + 30 : _configuration!.bottomPadding,
//             left: _configuration!.leftPadding,
//             right: _configuration!.rightPadding),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: textWidgets,
//         ),
//       ),
//     );
//   }

//   BPSubtitle? _getSubtitleAtCurrentPosition() {
//     if (_latestValue == null) {
//       return null;
//     }

//     final Duration position = _latestValue!.position;
//     for (final BPSubtitle subtitle in widget.bpController.subtitlesLines) {
//       if (subtitle.start! <= position && subtitle.end! >= position) {
//         return subtitle;
//       }
//     }
//     return null;
//   }

//   Widget _buildSubtitleTextWidget(String subtitleText) {
//     return Row(children: [
//       Expanded(
//         child: Align(
//           alignment: _configuration!.alignment,
//           child: _getTextWithStroke(subtitleText),
//         ),
//       ),
//     ]);
//   }

//   Widget _getTextWithStroke(String subtitleText) {
//     return Container(
//       color: _configuration!.backgroundColor,
//       child: Stack(
//         children: [
//           if (_configuration!.outlineEnabled) _buildHtmlWidget(subtitleText, _outerTextStyle) else const SizedBox(),
//           _buildHtmlWidget(subtitleText, _innerTextStyle)
//         ],
//       ),
//     );
//   }

//   Widget _buildHtmlWidget(String text, TextStyle textStyle) {
//     return HtmlWidget(
//       text,
//       textStyle: textStyle,
//     );
//   }

//   BPSubtitlesCfg setupDefaultCfg() {
//     return const BPSubtitlesCfg();
//   }
// }
