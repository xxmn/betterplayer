import 'package:better_player/better_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'better_player_mock_controller.dart';
import 'better_player_test_utils.dart';
import 'mock_method_channel.dart';
import 'mock_video_player_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockMethodChannel mockMethodChannel = MockMethodChannel();

  group(
    "BPController tests",
    () {
      setUp(
        () => {
          TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
              .setMockMethodCallHandler(mockMethodChannel.channel, mockMethodChannel.handle)
        },
      );

      test("Create controller without data source", () {
        final BPMockController betterPlayerMockController = BPMockController(const BPConfiguration());
        expect(betterPlayerMockController.betterPlayerDataSource, null);
        expect(betterPlayerMockController.videoPlayerController, null);
      });

      test("Setup data source in controller", () async {
        final BPMockController betterPlayerMockController = BPMockController(const BPConfiguration());
        await betterPlayerMockController.setupDataSource(BPDataSource.network(BPTestUtils.forBiggerBlazesUrl));
        expect(betterPlayerMockController.betterPlayerDataSource != null, true);
        expect(betterPlayerMockController.videoPlayerController != null, true);
      });

      test(
        "play should change isPlaying flag",
        () async {
          final BPController bpController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          bpController.videoPlayerController = videoPlayerController;
          await Future.delayed(const Duration(seconds: 1), () {});
          bpController.play();
          expect(bpController.isPlaying(), true);
        },
      );

      test(
        "pause should change isPlaying flag",
        () async {
          final BPController bpController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          bpController.videoPlayerController = videoPlayerController;
          await Future.delayed(const Duration(seconds: 1), () {});
          bpController.play();
          expect(bpController.isPlaying(), true);
          bpController.pause();
          expect(bpController.isPlaying(), false);
        },
      );

      test(
        "seekTo should change player position",
        () async {
          final BPController bpController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          videoPlayerController.setDuration(const Duration(seconds: 100));
          bpController.videoPlayerController = videoPlayerController;
          bpController.seekTo(const Duration(seconds: 5));
          Duration? position = await bpController.videoPlayerController!.position;
          expect(position, const Duration(seconds: 5));
          bpController.seekTo(const Duration(seconds: 30));
          position = await bpController.videoPlayerController!.position;
          expect(position, const Duration(seconds: 30));
        },
      );

      test(
        "seekTo should send event",
        () async {
          final BPController bpController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          videoPlayerController.setDuration(const Duration(seconds: 100));
          bpController.videoPlayerController = videoPlayerController;

          int seekEventCalls = 0;
          int finishEventCalls = 0;
          bpController.addEventsListener((event) {
            if (event.betterPlayerEventType == BPEventType.seekTo) {
              seekEventCalls += 1;
            }
            if (event.betterPlayerEventType == BPEventType.finished) {
              finishEventCalls += 1;
            }
          });
          bpController.seekTo(const Duration(seconds: 5));
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(seekEventCalls, 1);
          bpController.seekTo(const Duration(seconds: 150));
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(seekEventCalls, 2);
          expect(finishEventCalls, 1);
        },
      );

      test("full screen and auto play should work", () async {
        final BPMockController betterPlayerMockController = BPMockController(
          const BPConfiguration(fullScreenByDefault: true, autoPlay: true),
        );
        betterPlayerMockController.videoPlayerController = MockVideoPlayerController();
        await betterPlayerMockController.setupDataSource(
          BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
        );
        await Future.delayed(const Duration(seconds: 1), () {});
        expect(betterPlayerMockController.isFullScreen, true);
        expect(betterPlayerMockController.isPlaying(), true);
      });

      test("exitFullScreen should exit full screen", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController(
          controller: MockVideoPlayerController(),
        );
        expect(betterPlayerMockController.isFullScreen, false);
        betterPlayerMockController.exitFullScreen();
        expect(betterPlayerMockController.isFullScreen, false);
      });

      test("enterFullScreen should enter full screen", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        await betterPlayerMockController.setupDataSource(
          BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
        );
        expect(betterPlayerMockController.isFullScreen, false);
        betterPlayerMockController.enterFullScreen();
        expect(betterPlayerMockController.isFullScreen, true);
      });

      test("toggleFullScreen should change full screen state", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        await betterPlayerMockController.setupDataSource(
          BPDataSource.network(BPTestUtils.forBiggerBlazesUrl),
        );

        expect(betterPlayerMockController.isFullScreen, false);
        betterPlayerMockController.toggleFullScreen();
        expect(betterPlayerMockController.isFullScreen, true);
        betterPlayerMockController.toggleFullScreen();
        expect(betterPlayerMockController.isFullScreen, false);
      });

      test("setLooping changes looping state", () async {
        final mockVideoPlayerController = MockVideoPlayerController();
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);

        betterPlayerMockController.videoPlayerController = mockVideoPlayerController;
        expect(mockVideoPlayerController.isLoopingState, false);
        betterPlayerMockController.setLooping(true);
        expect(mockVideoPlayerController.isLoopingState, true);
        betterPlayerMockController.setLooping(false);
        expect(mockVideoPlayerController.isLoopingState, false);
      });

      test("setControlsVisibility updates controlVisiblityStream", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        var showCalls = 0;
        var hideCalls = 0;
        betterPlayerMockController.controlsVisibilityStream.listen((event) {
          if (event) {
            showCalls += 1;
          } else {
            hideCalls += 1;
          }
        });
        betterPlayerMockController.setControlsVisibility(false);
        betterPlayerMockController.setControlsVisibility(false);
        betterPlayerMockController.setControlsVisibility(true);
        betterPlayerMockController.setControlsVisibility(true);
        betterPlayerMockController.setControlsVisibility(false);
        await Future.delayed(const Duration(milliseconds: 100), () {});
        expect(hideCalls, 3);
        expect(showCalls, 2);
      });

      test("setControlsEnabled updates values correctly", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        var hideCalls = 0;
        betterPlayerMockController.controlsVisibilityStream.listen((event) {
          hideCalls += 1;
        });
        betterPlayerMockController.setControlsEnabled(false);
        betterPlayerMockController.setControlsEnabled(false);
        await Future.delayed(const Duration(milliseconds: 100), () {});
        expect(hideCalls, 2);
        expect(betterPlayerMockController.controlsEnabled, false);
        betterPlayerMockController.setControlsEnabled(true);
        expect(betterPlayerMockController.controlsEnabled, true);
      });

      test("toggleControlsVisibility sends correct events", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        var controlsVisibleEventCount = 0;
        var controlsHiddenEventCount = 0;
        betterPlayerMockController.addEventsListener((event) {
          if (event.betterPlayerEventType == BPEventType.controlsVisible) {
            controlsVisibleEventCount += 1;
          }
          if (event.betterPlayerEventType == BPEventType.controlsHiddenEnd) {
            controlsHiddenEventCount += 1;
          }
        });
        betterPlayerMockController.toggleControlsVisibility(false);
        betterPlayerMockController.toggleControlsVisibility(true);
        betterPlayerMockController.toggleControlsVisibility(true);
        await Future.delayed(const Duration(milliseconds: 100), () {});
        expect(controlsVisibleEventCount, 2);
        expect(controlsHiddenEventCount, 1);
      });

      test("postEvent sends events to listeners", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();

        int firstEventCounter = 0;
        int secondEventCounter = 0;

        betterPlayerMockController.addEventsListener((event) {
          firstEventCounter++;
        });
        betterPlayerMockController.addEventsListener((event) {
          secondEventCounter++;
        });
        betterPlayerMockController.postEvent(BPEvent(BPEventType.play));
        betterPlayerMockController.postEvent(BPEvent(BPEventType.progress));

        betterPlayerMockController.postEvent(BPEvent(BPEventType.pause));
        await Future.delayed(const Duration(milliseconds: 100), () {});
        expect(firstEventCounter, 3);
        expect(secondEventCounter, 3);
      });

      test("addEventsListener update list of event listener", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        betterPlayerMockController.addEventsListener((event) {});
        betterPlayerMockController.addEventsListener((event) {});
        expect(betterPlayerMockController.eventListeners.length, 2);
      });

      void dummyEventListener(BPEvent event) {}

      test("removeEventsListener update list of event listener", () async {
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        betterPlayerMockController.addEventsListener(dummyEventListener);
        betterPlayerMockController.addEventsListener((event) {});
        expect(betterPlayerMockController.eventListeners.length, 2);
        betterPlayerMockController.removeEventsListener(dummyEventListener);
        expect(betterPlayerMockController.eventListeners.length, 1);
      });

      test("setVolume changes volume", () async {
        final mockVideoPlayerController = MockVideoPlayerController();
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);
        betterPlayerMockController.videoPlayerController = mockVideoPlayerController;
        betterPlayerMockController.setVolume(1.0);
        expect(mockVideoPlayerController.volume, 1.0);
        betterPlayerMockController.setVolume(0.5);
        expect(mockVideoPlayerController.volume, 0.5);
      });

      test(
        "setVolume should send event",
        () async {
          final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          betterPlayerMockController.videoPlayerController = videoPlayerController;

          int setVolumeCalls = 0;
          betterPlayerMockController.addEventsListener((event) {
            if (event.betterPlayerEventType == BPEventType.setVolume) {
              setVolumeCalls += 1;
            }
          });
          betterPlayerMockController.setVolume(1.0);
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(setVolumeCalls, 1);
          betterPlayerMockController.setVolume(1.0);
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(setVolumeCalls, 2);
        },
      );

      test("setSpeed changes speed", () async {
        final mockVideoPlayerController = MockVideoPlayerController();
        final BPMockController betterPlayerMockController = BPTestUtils.setupBPMockController();
        mockVideoPlayerController.setNetworkDataSource(BPTestUtils.bugBuckBunnyVideoUrl);
        betterPlayerMockController.videoPlayerController = mockVideoPlayerController;
        betterPlayerMockController.setSpeed(1.1);
        expect(mockVideoPlayerController.speed, 1.1);
        betterPlayerMockController.setSpeed(0.5);
        expect(mockVideoPlayerController.speed, 0.5);
        expect(() => betterPlayerMockController.setSpeed(2.5), throwsA(isA<ArgumentError>()));
        expect(mockVideoPlayerController.speed, 0.5);
        expect(() => betterPlayerMockController.setSpeed(0.0), throwsA(isA<ArgumentError>()));
        expect(mockVideoPlayerController.speed, 0.5);
      });

      test(
        "setSpeed should send event",
        () async {
          final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
          final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
          betterPlayerMockController.videoPlayerController = videoPlayerController;

          int setSpeedCalls = 0;
          betterPlayerMockController.addEventsListener((event) {
            if (event.betterPlayerEventType == BPEventType.setSpeed) {
              setSpeedCalls += 1;
            }
          });
          betterPlayerMockController.setSpeed(1.5);
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(setSpeedCalls, 1);
          betterPlayerMockController.setSpeed(1.0);
          await Future.delayed(const Duration(milliseconds: 100), () {});
          expect(setSpeedCalls, 2);
        },
      );

      test("isBuffering returns valid value", () async {
        final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
        final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
        betterPlayerMockController.videoPlayerController = videoPlayerController;
        videoPlayerController.setBuffering(false);
        expect(betterPlayerMockController.isBuffering(), false);
        videoPlayerController.setBuffering(true);
        expect(betterPlayerMockController.isBuffering(), true);
      });

      test("isLiveStream returns valid value", () async {
        final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
        expect(() => betterPlayerMockController.isLiveStream(), throwsA(isA<StateError>()));
        betterPlayerMockController
            .setupDataSource(BPDataSource(BPDataSourceType.network, BPTestUtils.forBiggerBlazesUrl, liveStream: true));
        final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
        betterPlayerMockController.videoPlayerController = videoPlayerController;
        expect(betterPlayerMockController.isLiveStream(), true);
      });

      test("isVideoInitalized returns valid value", () async {
        final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
        expect(() => betterPlayerMockController.isVideoInitialized(), throwsA(isA<StateError>()));
        final videoPlayerController = BPTestUtils.setupMockVideoPlayerControler();
        betterPlayerMockController.videoPlayerController = videoPlayerController;
        videoPlayerController.setDuration(const Duration(seconds: 1));
        expect(betterPlayerMockController.isVideoInitialized(), true);
      });

      test("startNextVideoTimer starts next video timer", () async {
        final BPController betterPlayerMockController = BPTestUtils.setupBPMockController();
        int eventCount = 0;
        betterPlayerMockController.nextVideoTimeStream.listen((event) {
          eventCount += 1;
        });
        betterPlayerMockController.startNextVideoTimer();
        await Future.delayed(const Duration(milliseconds: 3000), () {});
        expect(eventCount, 3);
      });
    },
  );
}
