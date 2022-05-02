import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

class BpFullScreenPage extends StatefulWidget {
  BpFullScreenPage({Key? key}) : super(key: key);

  @override
  State<BpFullScreenPage> createState() => _BpFullScreenPageState();
}

class _BpFullScreenPageState extends State<BpFullScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (_bpCfg.autoDetectFullscreenDeviceOrientation == true) {
      final aspectRatio = widget.bpController.nativePlayerController?.value.aspectRatio ?? 1.0;
      List<DeviceOrientation> deviceOrientations;
      if (aspectRatio < 1.0) {
        deviceOrientations = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
      } else {
        deviceOrientations = [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight];
      }
      await SystemChrome.setPreferredOrientations(deviceOrientations);
    } else {
      await SystemChrome.setPreferredOrientations(
        widget.bpController.bpCfg.deviceOrientationsOnFullScreen,
      );
    }

    if (!_bpCfg.allowedScreenSleep) {
      Wakelock.enable();
    }
    // The wakelock plugins checks whether it needs to perform an action internally,
    // so we do not need to check Wakelock.isEnabled.
    Wakelock.disable();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: _bpCfg.systemOverlaysAfterFullScreen);
    await SystemChrome.setPreferredOrientations(_bpCfg.deviceOrientationsAfterFullScreen);
  }

  @override
  void dispose() {
    Wakelock.disable();
    _navigatorState.maybePop();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: _bpCfg.systemOverlaysAfterFullScreen);
    SystemChrome.setPreferredOrientations(_bpCfg.deviceOrientationsAfterFullScreen);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      settings: const RouteSettings(),
      pageBuilder: _fullScreenRoutePageBuilder,
    );
  }

  Widget _fullScreenRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final controllerProvider = BPControllerProvider(controller: widget.bpController, child: _buildPlayer());

    final routePageBuilder = _bpCfg.routePageBuilder;
    if (routePageBuilder == null) {
      return _defaultRoutePageBuilder(context, animation, secondaryAnimation, controllerProvider);
    }

    return routePageBuilder(context, animation, secondaryAnimation, controllerProvider);
  }

  AnimatedWidget _defaultRoutePageBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, BetterPlayerControllerProvider controllerProvider) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return _buildFullScreenVideo(context, animation, controllerProvider);
      },
    );
  }

  Widget _buildFullScreenVideo(
    BuildContext context,
    Animation<double> animation,
    BPControllerProvider controllerProvider,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: controllerProvider,
      ),
    );
  }
}
