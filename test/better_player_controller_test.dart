// import 'package:better_player/better_player.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'better_player_mock_controller.dart';
// import 'better_player_test_utils.dart';
// import 'mock_method_channel.dart';
// import 'mock_video_player_controller.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   final MockMethodChannel mockMethodChannel = MockMethodChannel();

//   group(
//     "BPController tests",
//     () {
//       setUp(
//         () => {
//           TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
//               .setMockMethodCallHandler(mockMethodChannel.channel, mockMethodChannel.handle)
//         },
//       );

//       test("Create controller without data source", () {
//         final BPMockController bpMockController = BPMockController(const BPConfiguration());
//         expect(bpMockController.dataSource, null);
//         expect(bpMockController.videoPlayerController, null);
//       });

//       test("Setup data source in controller", () async {
//         final BPMockController bpMockController = BPMockController(const BPConfiguration());
//         await bpMockController.setupDataSource(BPDataSource.network(BPTestUtils.forBiggerBlazesUrl));
//         expect(bpMockController.dataSource != null, true);
//         expect(bpMockController.videoPlayerController != null, true);
//       });

//       test(
//         "play should change isPlaying flag",
//         () async {
//           final BPController bpController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           bpController.videoPlayerController = videoPlayerController;
//           await Future.delayed(const Duration(seconds: 1), () {});
//           bpController.play();
//           expect(bpController.isPlaying(), true);
//         },
//       );

//       test(
//         "pause should change isPlaying flag",
//         () async {
//           final BPController bpController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           bpController.videoPlayerController = videoPlayerController;
//           await Future.delayed(const Duration(seconds: 1), () {});
//           bpController.play();
//           expect(bpController.isPlaying(), true);
//           bpController.pause();
//           expect(bpController.isPlaying(), false);
//         },
//       );

//       test(
//         "seekTo should change player position",
//         () async {
//           final BPController bpController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           videoPlayerController.setDuration(const Duration(seconds: 100));
//           bpController.videoPlayerController = videoPlayerController;
//           bpController.seekTo(const Duration(seconds: 5));
//           Duration? position = await bpController.videoPlayerController!.position;
//           expect(position, const Duration(seconds: 5));
//           bpController.seekTo(const Duration(seconds: 30));
//           position = await bpController.videoPlayerController!.position;
//           expect(position, const Duration(seconds: 30));
//         },
//       );

//       test(
//         "seekTo should send event",
//         () async {
//           final BPController bpController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           videoPlayerController.setDuration(const Duration(seconds: 100));
//           bpController.videoPlayerController = videoPlayerController;

//           int seekEventCalls = 0;
//           int finishEventCalls = 0;
//           bpController.addEventsListener((event) {
//             if (event.bpEventType == BPEventType.seekTo) {
//               seekEventCalls += 1;
//             }
//             if (event.bpEventType == BPEventType.finished) {
//               finishEventCalls += 1;
//             }
//           });
//           bpController.seekTo(const Duration(seconds: 5));
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(seekEventCalls, 1);
//           bpController.seekTo(const Duration(seconds: 150));
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(seekEventCalls, 2);
//           expect(finishEventCalls, 1);
//         },
//       );

//       test("full screen and auto play should work", () async {
//         final BPMockController bpMockController = BPMockController(
//           const BPConfiguration(fullScreenByDefault: true, autoPlay: true),
//         );
//         bpMockController.videoPlayerController = MockVideoPlayerController();
//         await bpMockController.setupDataSource(
//           BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
//         );
//         await Future.delayed(const Duration(seconds: 1), () {});
//         expect(bpMockController.isFullScreen, true);
//         expect(bpMockController.isPlaying(), true);
//       });

//       test("exitFullScreen should exit full screen", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController(
//           controller: MockVideoPlayerController(),
//         );
//         expect(bpMockController.isFullScreen, false);
//         bpMockController.exitFullScreen();
//         expect(bpMockController.isFullScreen, false);
//       });

//       test("enterFullScreen should enter full screen", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         await bpMockController.setupDataSource(
//           BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
//         );
//         expect(bpMockController.isFullScreen, false);
//         bpMockController.enterFullScreen();
//         expect(bpMockController.isFullScreen, true);
//       });

//       test("toggleFullScreen should change full screen state", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         await bpMockController.setupDataSource(
//           BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
//         );

//         expect(bpMockController.isFullScreen, false);
//         bpMockController.toggleFullScreen();
//         expect(bpMockController.isFullScreen, true);
//         bpMockController.toggleFullScreen();
//         expect(bpMockController.isFullScreen, false);
//       });

//       test("setLooping changes looping state", () async {
//         final mockVideoPlayerController = MockVideoPlayerController();
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);

//         bpMockController.videoPlayerController = mockVideoPlayerController;
//         expect(mockVideoPlayerController.isLoopingState, false);
//         bpMockController.setLooping(true);
//         expect(mockVideoPlayerController.isLoopingState, true);
//         bpMockController.setLooping(false);
//         expect(mockVideoPlayerController.isLoopingState, false);
//       });

//       test("setControlsVisibility updates controlVisiblityStream", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         var showCalls = 0;
//         var hideCalls = 0;
//         bpMockController.controlsVisibilityStream.listen((event) {
//           if (event) {
//             showCalls += 1;
//           } else {
//             hideCalls += 1;
//           }
//         });
//         bpMockController.setControlsVisibility(false);
//         bpMockController.setControlsVisibility(false);
//         bpMockController.setControlsVisibility(true);
//         bpMockController.setControlsVisibility(true);
//         bpMockController.setControlsVisibility(false);
//         await Future.delayed(const Duration(milliseconds: 100), () {});
//         expect(hideCalls, 3);
//         expect(showCalls, 2);
//       });

//       test("setControlsEnabled updates values correctly", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         var hideCalls = 0;
//         bpMockController.controlsVisibilityStream.listen((event) {
//           hideCalls += 1;
//         });
//         bpMockController.setControlsEnabled(false);
//         bpMockController.setControlsEnabled(false);
//         await Future.delayed(const Duration(milliseconds: 100), () {});
//         expect(hideCalls, 2);
//         expect(bpMockController.controlsEnabled, false);
//         bpMockController.setControlsEnabled(true);
//         expect(bpMockController.controlsEnabled, true);
//       });

//       test("toggleControlsVisibility sends correct events", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         var controlsVisibleEventCount = 0;
//         var controlsHiddenEventCount = 0;
//         bpMockController.addEventsListener((event) {
//           if (event.bpEventType == BPEventType.controlsVisible) {
//             controlsVisibleEventCount += 1;
//           }
//           if (event.bpEventType == BPEventType.controlsHiddenEnd) {
//             controlsHiddenEventCount += 1;
//           }
//         });
//         bpMockController.toggleControlsVisibility(false);
//         bpMockController.toggleControlsVisibility(true);
//         bpMockController.toggleControlsVisibility(true);
//         await Future.delayed(const Duration(milliseconds: 100), () {});
//         expect(controlsVisibleEventCount, 2);
//         expect(controlsHiddenEventCount, 1);
//       });

//       test("postEvent sends events to listeners", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();

//         int firstEventCounter = 0;
//         int secondEventCounter = 0;

//         bpMockController.addEventsListener((event) {
//           firstEventCounter++;
//         });
//         bpMockController.addEventsListener((event) {
//           secondEventCounter++;
//         });
//         bpMockController.postEvent(BPEvent(BPEventType.play));
//         bpMockController.postEvent(BPEvent(BPEventType.progress));

//         bpMockController.postEvent(BPEvent(BPEventType.pause));
//         await Future.delayed(const Duration(milliseconds: 100), () {});
//         expect(firstEventCounter, 3);
//         expect(secondEventCounter, 3);
//       });

//       test("addEventsListener update list of event listener", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         bpMockController.addEventsListener((event) {});
//         bpMockController.addEventsListener((event) {});
//         expect(bpMockController.eventListeners.length, 2);
//       });

//       void dummyEventListener(BPEvent event) {}

//       test("removeEventsListener update list of event listener", () async {
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         bpMockController.addEventsListener(dummyEventListener);
//         bpMockController.addEventsListener((event) {});
//         expect(bpMockController.eventListeners.length, 2);
//         bpMockController.removeEventsListener(dummyEventListener);
//         expect(bpMockController.eventListeners.length, 1);
//       });

//       test("setVolume changes volume", () async {
//         final mockVideoPlayerController = MockVideoPlayerController();
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);
//         bpMockController.videoPlayerController = mockVideoPlayerController;
//         bpMockController.setVolume(1.0);
//         expect(mockVideoPlayerController.volume, 1.0);
//         bpMockController.setVolume(0.5);
//         expect(mockVideoPlayerController.volume, 0.5);
//       });

//       test(
//         "setVolume should send event",
//         () async {
//           final BPController bpMockController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           bpMockController.videoPlayerController = videoPlayerController;

//           int setVolumeCalls = 0;
//           bpMockController.addEventsListener((event) {
//             if (event.bpEventType == BPEventType.setVolume) {
//               setVolumeCalls += 1;
//             }
//           });
//           bpMockController.setVolume(1.0);
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(setVolumeCalls, 1);
//           bpMockController.setVolume(1.0);
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(setVolumeCalls, 2);
//         },
//       );

//       test("setSpeed changes speed", () async {
//         final mockVideoPlayerController = MockVideoPlayerController();
//         final BPMockController bpMockController = BPTestUtils.setupBPMockController();
//         mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);
//         bpMockController.videoPlayerController = mockVideoPlayerController;
//         bpMockController.setSpeed(1.1);
//         expect(mockVideoPlayerController.speed, 1.1);
//         bpMockController.setSpeed(0.5);
//         expect(mockVideoPlayerController.speed, 0.5);
//         expect(() => bpMockController.setSpeed(2.5), throwsA(isA<ArgumentError>()));
//         expect(mockVideoPlayerController.speed, 0.5);
//         expect(() => bpMockController.setSpeed(0.0), throwsA(isA<ArgumentError>()));
//         expect(mockVideoPlayerController.speed, 0.5);
//       });

//       test(
//         "setSpeed should send event",
//         () async {
//           final BPController bpMockController = BPTestUtils.setupBPMockController();
//           final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//           bpMockController.videoPlayerController = videoPlayerController;

//           int setSpeedCalls = 0;
//           bpMockController.addEventsListener((event) {
//             if (event.bpEventType == BPEventType.setSpeed) {
//               setSpeedCalls += 1;
//             }
//           });
//           bpMockController.setSpeed(1.5);
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(setSpeedCalls, 1);
//           bpMockController.setSpeed(1.0);
//           await Future.delayed(const Duration(milliseconds: 100), () {});
//           expect(setSpeedCalls, 2);
//         },
//       );

//       test("isBuffering returns valid value", () async {
//         final BPController bpMockController = BPTestUtils.setupBPMockController();
//         final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//         bpMockController.videoPlayerController = videoPlayerController;
//         videoPlayerController.setBuffering(false);
//         expect(bpMockController.isBuffering(), false);
//         videoPlayerController.setBuffering(true);
//         expect(bpMockController.isBuffering(), true);
//       });

//       test("isLiveStream returns valid value", () async {
//         final BPController bpMockController = BPTestUtils.setupBPMockController();
//         expect(() => bpMockController.isLiveStream(), throwsA(isA<StateError>()));
//         bpMockController
//             .setupDataSource(BPDataSource(DataSourceType.network, BPTestUtils.forBiggerBlazesUrl, liveStream: true));
//         final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//         bpMockController.videoPlayerController = videoPlayerController;
//         expect(bpMockController.isLiveStream(), true);
//       });

//       test("isVideoInitalized returns valid value", () async {
//         final BPController bpMockController = BPTestUtils.setupBPMockController();
//         expect(() => bpMockController.isVideoInitialized(), throwsA(isA<StateError>()));
//         final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
//         bpMockController.videoPlayerController = videoPlayerController;
//         videoPlayerController.setDuration(const Duration(seconds: 1));
//         expect(bpMockController.isVideoInitialized(), true);
//       });

//       test("startNextVideoTimer starts next video timer", () async {
//         final BPController bpMockController = BPTestUtils.setupBPMockController();
//         int eventCount = 0;
//         bpMockController.nextVideoTimeStream.listen((event) {
//           eventCount += 1;
//         });
//         bpMockController.startNextVideoTimer();
//         await Future.delayed(const Duration(milliseconds: 3000), () {});
//         expect(eventCount, 3);
//       });
//     },
//   );
// }
