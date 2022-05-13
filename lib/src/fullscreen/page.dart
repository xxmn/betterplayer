import 'package:better_player/src/core/bp_visibility_detector.dart';
import 'package:better_player/src/fullscreen/bp_config_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock/wakelock.dart';
import 'bp_fullscreen_provider.dart';

class FullScreenPage extends StatefulHookConsumerWidget {
  const FullScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends ConsumerState<FullScreenPage> {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      List<DeviceOrientation> dvo;
      var autoDO = ref.read(bpFullscreenConfigProvider.notifier).autoDetectOrientations();
      if (autoDO) {
        var aspectRatio = ref.read(npStatusProvider.notifier).getAspectRatio();
        dvo = aspectRatio <= 1.0
            ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
            : [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight];
      } else {
        dvo = ref.read(bpFullscreenConfigProvider.notifier).getOrientations();
      }
      SystemChrome.setPreferredOrientations(dvo);

      var orientations = ref.read(bpFullscreenConfigProvider.notifier).getOrientationsAfter();
      return () {
        SystemChrome.setPreferredOrientations(orientations);
      };
    }, const []);

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      var afterOverlay = ref.read(bpFullscreenConfigProvider.notifier).getOverlaysAfter();
      return () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: afterOverlay);
      };
    }, const []);

    useEffect(() {
      var allowedSleep = ref.read(bpFullscreenConfigProvider.notifier).allowedSleep();
      if (!allowedSleep) Wakelock.enable();
      return () {
        // The wakelock plugins checks whether it needs to perform an action internally,
        // so we do not need to check Wakelock.isEnabled.
        Wakelock.disable();
      };
    }, const []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: BPVisibilityDetector(),
      ),
    );
  }
}
