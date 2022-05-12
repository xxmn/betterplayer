// void onControllerEvent(BetterPlayerControllerEvent event) {
//   switch (event) {
//     case BetterPlayerControllerEvent.openFullscreen:
//       onFullScreenChanged();
//       break;
//     case BetterPlayerControllerEvent.hideFullscreen:
//       onFullScreenChanged();
//       break;
//     default:
//       setState(() {});
//       break;
//   }
// }

// // ignore: avoid_void_async
// Future<void> onFullScreenChanged() async {
//   final controller = widget.controller;
//   if (controller.isFullScreen && !_isFullScreen) {
//     _isFullScreen = true;
//     controller.postEvent(BetterPlayerEvent(BetterPlayerEventType.openFullscreen));
//     await _pushFullScreenWidget(context);
//   } else if (_isFullScreen) {
//     Navigator.of(context, rootNavigator: true).pop();
//     _isFullScreen = false;
//     controller.postEvent(BetterPlayerEvent(BetterPlayerEventType.hideFullscreen));
//   }
// }

// Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
//   final TransitionRoute<void> route = PageRouteBuilder<void>(
//     settings: const RouteSettings(),
//     pageBuilder: _fullScreenRoutePageBuilder,
//   );

//   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//   if (_betterPlayerConfiguration.autoDetectFullscreenDeviceOrientation == true) {
//     final aspectRatio = widget.controller.videoPlayerController?.value.aspectRatio ?? 1.0;
//     List<DeviceOrientation> deviceOrientations;
//     if (aspectRatio < 1.0) {
//       deviceOrientations = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
//     } else {
//       deviceOrientations = [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight];
//     }
//     await SystemChrome.setPreferredOrientations(deviceOrientations);
//   } else {
//     await SystemChrome.setPreferredOrientations(
//       widget.controller.betterPlayerConfiguration.deviceOrientationsOnFullScreen,
//     );
//   }

//   if (!_betterPlayerConfiguration.allowedScreenSleep) {
//     Wakelock.enable();
//   }

//   await Navigator.of(context, rootNavigator: true).push(route);
//   _isFullScreen = false;
//   widget.controller.exitFullScreen();

//   // The wakelock plugins checks whether it needs to perform an action internally,
//   // so we do not need to check Wakelock.isEnabled.
//   Wakelock.disable();

//   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: _betterPlayerConfiguration.systemOverlaysAfterFullScreen);
//   await SystemChrome.setPreferredOrientations(
//       _betterPlayerConfiguration.deviceOrientationsAfterFullScreen);
// }

// Widget _fullScreenRoutePageBuilder(
//   BuildContext context,
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
// ) {
//   final controllerProvider =
//       BetterPlayerControllerProvider(controller: widget.controller, child: _buildPlayer());

//   final routePageBuilder = _betterPlayerConfiguration.routePageBuilder;
//   if (routePageBuilder == null) {
//     return _defaultRoutePageBuilder(context, animation, secondaryAnimation, controllerProvider);
//   }

//   return routePageBuilder(context, animation, secondaryAnimation, controllerProvider);
// }

// AnimatedWidget _defaultRoutePageBuilder(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, BetterPlayerControllerProvider controllerProvider) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (BuildContext context, Widget? child) {
//       return _buildFullScreenVideo(context, animation, controllerProvider);
//     },
//   );
// }

// Widget _buildFullScreenVideo(BuildContext context, Animation<double> animation,
//     BetterPlayerControllerProvider controllerProvider) {
//   return Scaffold(
//     resizeToAvoidBottomInset: false,
//     body: Container(
//       alignment: Alignment.center,
//       color: Colors.black,
//       child: controllerProvider,
//     ),
//   );
// }
