import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'bp_status_provider.dart';
import 'bp_with_controls.dart';

////////////////////////////////////////////////////////////////////////
///
///可见性回掉函数
///disposed状态
///
////////////////////////////////////////////////////////////////////////

class BPVisibilityDetector extends StatefulHookConsumerWidget {
  const BPVisibilityDetector({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BPVisibilityDetectorState();
}

class _BPVisibilityDetectorState extends ConsumerState<BPVisibilityDetector> {
  final Key id = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      // key: Key("${widget.controller.hashCode}_key"),
      key: id,
      onVisibilityChanged: (VisibilityInfo info) {
        if (mounted) {
          ref.read(bpIsVisibleProvider.notifier).setIsVisible(info.visibleFraction);
        }
      },
      child: BPWithControls(),
    );
  }
}
