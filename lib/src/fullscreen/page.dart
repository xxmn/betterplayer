import 'package:better_player/src/core/bp_visibility_detector.dart';
import 'package:better_player/src/fullscreen/bp_config_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wakelock/wakelock.dart';
import 'bp_config.dart';
import 'bp_provider.dart';

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
      var autoDO = ref.read(bpFullScreenConfigProvider!.notifier).autoDetectOrientations();
      if (autoDO) {
        var aspectRatio = ref.read(npStatusProvider.notifier).getAspectRatio();
        dvo = aspectRatio <= 1.0
            ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
            : [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight];
      } else {
        dvo = ref.read(bpFullScreenConfigProvider!.notifier).getOrientations();
      }
      SystemChrome.setPreferredOrientations(dvo);

      var orientations = ref.read(bpFullScreenConfigProvider!.notifier).getOrientationsAfter();
      return () {
        SystemChrome.setPreferredOrientations(orientations);
      };
    }, const []);

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      var afterOverlay = ref.read(bpFullScreenConfigProvider!.notifier).getOverlaysAfter();
      return () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: afterOverlay);
      };
    }, const []);

    useEffect(() {
      var allowedSleep = ref.read(bpFullScreenConfigProvider!.notifier).allowedSleep();
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

void exitFullScreenPage(BuildContext ctx) {
  Navigator.of(ctx, rootNavigator: true).pop();
}

Future<dynamic> enterFullScreenPage(BuildContext context, Reader read) async {
  final TransitionRoute<void> route = PageRouteBuilder<void>(
    settings: const RouteSettings(),
    pageBuilder: _fullScreenRoutePageBuilder,
  );

  // 放在这里，以便跟exit对应
  read(bpFullScreenProvider.notifier).enter();

  // push动作同步执行，阻塞在push，等待pop页面才之后之后的动作
  await Navigator.of(context, rootNavigator: true).push(route);
  // print("after push fullscreen");
  // ref.read动作不能在dispose回调里面执行，所以放在这里
  read(bpFullScreenProvider.notifier).exit();

  // 异步执行，不会阻塞
  // 不等退出全屏模式，而直接执行read(bpFullScreenProvider.notifier).exit();，所以不用
  // GoRouter.of(context).push('/bpFullScreen');
  // read(bpFullScreenProvider.notifier).exit();
}

Widget _fullScreenRoutePageBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
) {
  // final routePageBuilder = _betterPlayerConfiguration.routePageBuilder;
  final BPRoutePageBuilder? routePageBuilder = null;
  if (routePageBuilder == null) {
    return _DefaultFullScreenPage(animation: animation, secondaryAnimation: secondaryAnimation);
  } else {
    return routePageBuilder(context, animation, secondaryAnimation);
  }
}

class _DefaultFullScreenPage extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  const _DefaultFullScreenPage({
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
