import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/controls/widgets/bp_hitArea.dart';
import 'package:better_player/src/controls/widgets/bp_loading.dart';
import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'widgets/bp_bottomBars.dart';
import 'widgets/bp_error_page.dart';
import 'widgets/bp_next_video.dart';
import 'widgets/bp_topBar.dart';

class BPMaterialControls extends HookConsumerWidget {
  const BPMaterialControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Builds directionality widget which wraps child widget and forces left to
    ///right directionality.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: _ControlsMainOrErrorPage(),
    );
  }
}

class _ControlsMainOrErrorPage extends HookConsumerWidget {
  const _ControlsMainOrErrorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hasError = ref.watch(bpPlayingStatusProvider!.select((v) => v.hasError));
    return hasError ? ErrorPage() : _ControlsMainPage();
  }
}

///Builds main widget of the controls.
class _ControlsMainPage extends HookConsumerWidget {
  const _ControlsMainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // todo: watch 不能使用notifier，不能及时更新
    var showControls = ref.watch(bpShowControlsProvider);
    var isLoading = ref.watch(bpPlayingStatusProvider!.select((v) => v.isLoading));
    //todo: 手势事件处理
    return GestureDetector(
      onTap: ref.read(bpShowControlsProvider.notifier).toggle,
      onDoubleTap: ref.read(bpShowControlsProvider.notifier).show,
      onLongPress: () {
        // print("GestureDetector onLongPress");
      },
      child: AbsorbPointer(
        absorbing: !showControls,
        child: Stack(
          fit: StackFit.expand,
          children: [
            isLoading ? Center(child: Loading()) : MaybeHitArea(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MaybeTopBar(),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: MaybeBottomBars()),
            // NextVideo(),
          ],
        ),
      ),
    );
  }
}
