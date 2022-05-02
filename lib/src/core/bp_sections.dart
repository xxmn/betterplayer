// Widget _buildPlayer() {
//     var sections = widget.bpController.bpDataSource?.sections;
//     return sections == null ? _buildPlayerNoVideoSections() : _buildPlayerHasVideoSections(sections);
//   }

//   Widget _buildPlayerHasVideoSections(List<Section> sections) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<VideoSectionsState>(create: (_) => VideoSectionsState(sections.length)),
//       ],
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildPlayerNoVideoSections(),
//           Divider(),
//           Builder(builder: (ctx) {
//             return IconButton(
//               onPressed: () => Provider.of<VideoSectionsState>(ctx, listen: false).setIsShow(true),
//               icon: Icon(Icons.show_chart_rounded),
//             );
//           }),
//           _buildVideoSections(sections),
//         ],
//       ),
//     );
//   }

//   Widget _buildVideoSections(List<Section> sections) {
//     return Selector<VideoSectionsState, bool>(
//       selector: (_, vs) => vs.isShow,
//       builder: (_, isShow, __) {
//         if (isShow) {
//           return Expanded(child: VideoSections(sections));
//         } else {
//           return Container();
//         }
//       },
//     );
//   }