import 'package:better_player/better_player.dart';
import 'package:better_player/src/video_player/video_player.dart';

import 'better_player_mock_controller.dart';
import 'mock_video_player_controller.dart';

class BPTestUtils {
  static const String bugBuckBunnyVideoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String forBiggerBlazesUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  static const String elephantDreamStreamUrl = "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";

  static BPMockController setupBPMockController({VideoPlayerController? controller}) {
    final mockController = BPMockController(const BPCfg());
    if (controller != null) {
      mockController.videoPlayerController = controller;
    }
    return mockController;
  }

  static MockVideoPlayerController setupMockVideoPlayerControler() {
    final mockVideoPlayerController = MockVideoPlayerController();
    mockVideoPlayerController.setNetworkDataSource(BPTestUtils.forBiggerBlazesUrl);
    return mockVideoPlayerController;
  }
}
