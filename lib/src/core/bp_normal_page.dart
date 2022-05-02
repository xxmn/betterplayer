import 'package:better_player/src/core/bp_notifier.dart';
import 'package:better_player/src/core/controller.dart';
import 'package:better_player/src/core/with_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BpNormalPage extends StatefulWidget {
  BpNormalPage({Key? key}) : super(key: key);

  @override
  State<BpNormalPage> createState() => _BpNormalPageState();
}

class _BpNormalPageState extends State<BpNormalPage> {
  late BPController bpController;
  @override
  void dispose() {
    VisibilityDetectorController.instance.forget(Key("${bpController.hashCode}_key"));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BPNotifier, BPController>(
      selector: (_, bpNotifier) => bpNotifier.bpController,
      builder: (_, _bpController, __) {
        bpController = _bpController;
        return VisibilityDetector(
          key: Key("${bpController.hashCode}_key"),
          onVisibilityChanged: (VisibilityInfo info) => bpController.onPlayerVisibilityChanged(info.visibleFraction),
          child: BPWithControls(),
        );
      },
    );
  }
}
