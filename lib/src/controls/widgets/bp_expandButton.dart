import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/fullscreen/page.dart';
import 'package:better_player/src/fullscreen/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/fullscreen/bp_fullscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaybeExpandButton extends HookConsumerWidget {
  const MaybeExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableFullscreen = ref.watch(bpFullscreenConfigProvider.select((v) => v.enableFullscreen));
    return enableFullscreen ? ExpandButton() : const SizedBox();
  }
}

class ExpandButton extends HookConsumerWidget {
  const ExpandButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsVisible = ref.watch(bpShowControlsProvider);
    var controlsHideTime = ref.watch(bpControlsConfigProvider!.select((v) => v.controlsHideTime));
    var controlBarHeight = ref.watch(bpControlsConfigProvider!.select((v) => v.controlBarHeight));
    var disableIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenDisableIcon));
    var enableIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.fullscreenEnableIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var isFullScreen = ref.watch(bpFullscreenProvider);

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: BPMaterialClickableWidget(
        onTap: () => _onExpandCollapse(context, ref.read),
        child: AnimatedOpacity(
          opacity: controlsVisible ? 1.0 : 0.0,
          duration: controlsHideTime,
          child: Container(
            height: controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Icon(
                isFullScreen ? disableIcon : enableIcon,
                color: iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _onExpandCollapse(BuildContext ctx, Reader read) {
  var isFullscreen = read(bpFullscreenProvider);
  if (!isFullscreen) {
    _pushFullScreenWidget(ctx, read);
  } else {
    Navigator.of(ctx, rootNavigator: true).pop();
    // GoRouter.of(ctx).pop();
  }
}

Future<dynamic> _pushFullScreenWidget(BuildContext context, Reader read) async {
  final TransitionRoute<void> route = PageRouteBuilder<void>(
    settings: const RouteSettings(),
    pageBuilder: _fullScreenRoutePageBuilder,
  );

  // 放在这里，以便跟exit对应
  read(bpFullscreenProvider.notifier).enter();

  // push动作同步执行，阻塞在push，等待pop页面才之后之后的动作
  await Navigator.of(context, rootNavigator: true).push(route);
  // print("after push fullscreen");
  // ref.read动作不能在dispose回调里面执行，所以放在这里
  read(bpFullscreenProvider.notifier).exit();

  // 异步执行，不会阻塞
  // 不等退出全屏模式，而直接执行read(bpFullscreenProvider.notifier).exit();，所以不用
  // GoRouter.of(context).push('/bpFullscreen');
  // read(bpFullscreenProvider.notifier).exit();
}

Widget _fullScreenRoutePageBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
) {
  // final routePageBuilder = _betterPlayerConfiguration.routePageBuilder;
  final BPRoutePageBuilder? routePageBuilder = null;
  if (routePageBuilder == null) {
    return _DefaultFullscreenPage(animation: animation, secondaryAnimation: secondaryAnimation);
  } else {
    return routePageBuilder(context, animation, secondaryAnimation);
  }
}

class _DefaultFullscreenPage extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  const _DefaultFullscreenPage({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return FullScreenPage();
      },
    );
  }
}
