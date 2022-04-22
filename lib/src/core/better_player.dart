import 'dart:async';
import 'package:better_player/better_player.dart';
import 'package:better_player/src/configuration/better_player_controller_event.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:better_player/src/core/better_player_with_controls.dart';
import 'package:better_player/src/controls/widgets/video_sections.dart';
import 'package:better_player/src/core/video_sections_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';

///Widget which uses provided controller to render video player.
class BP extends StatefulWidget {
  const BP({Key? key, required this.controller}) : super(key: key);

  factory BP.network(
    String url, {
    BPConfiguration? betterPlayerConfiguration,
  }) =>
      BP(
        controller: BPController(
          betterPlayerConfiguration ?? const BPConfiguration(),
          betterPlayerDataSource: BPDataSource(BPDataSourceType.network, url),
        ),
      );

  factory BP.file(
    String url, {
    BPConfiguration? betterPlayerConfiguration,
  }) =>
      BP(
        controller: BPController(
          betterPlayerConfiguration ?? const BPConfiguration(),
          betterPlayerDataSource: BPDataSource(BPDataSourceType.file, url),
        ),
      );

  final BPController controller;

  @override
  _BPState createState() {
    return _BPState();
  }
}

class _BPState extends State<BP> with WidgetsBindingObserver {
  BPConfiguration get _betterPlayerConfiguration => widget.controller.betterPlayerConfiguration;

  bool _isFullScreen = false;

  ///State of navigator on widget created
  late NavigatorState _navigatorState;

  ///Flag which determines if widget has initialized
  bool _initialized = false;

  ///Subscription for controller events
  StreamSubscription? _controllerEventSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final navigator = Navigator.of(context);
      setState(() {
        _navigatorState = navigator;
      });
      _setup();
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _setup() async {
    _controllerEventSubscription = widget.controller.controllerEventStream.listen(onControllerEvent);

    //Default locale
    var locale = const Locale("en", "US");
    try {
      if (mounted) {
        final contextLocale = Localizations.localeOf(context);
        locale = contextLocale;
      }
    } catch (exception) {
      BPUtils.log(exception.toString());
    }
    widget.controller.setupTranslations(locale);
  }

  @override
  void dispose() {
    ///If somehow BP widget has been disposed from widget tree and
    ///full screen is on, then full screen route must be pop and return to normal
    ///state.
    if (_isFullScreen) {
      Wakelock.disable();
      _navigatorState.maybePop();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: _betterPlayerConfiguration.systemOverlaysAfterFullScreen);
      SystemChrome.setPreferredOrientations(_betterPlayerConfiguration.deviceOrientationsAfterFullScreen);
    }

    WidgetsBinding.instance!.removeObserver(this);
    _controllerEventSubscription?.cancel();
    widget.controller.dispose();
    VisibilityDetectorController.instance.forget(Key("${widget.controller.hashCode}_key"));
    super.dispose();
  }

  @override
  void didUpdateWidget(BP oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _controllerEventSubscription?.cancel();
      _controllerEventSubscription = widget.controller.controllerEventStream.listen(onControllerEvent);
    }
    super.didUpdateWidget(oldWidget);
  }

  void onControllerEvent(BPControllerEvent event) {
    switch (event) {
      case BPControllerEvent.openFullscreen:
        onFullScreenChanged();
        break;
      case BPControllerEvent.hideFullscreen:
        onFullScreenChanged();
        break;
      default:
        setState(() {});
        break;
    }
  }

  // ignore: avoid_void_async
  Future<void> onFullScreenChanged() async {
    final controller = widget.controller;
    if (controller.isFullScreen && !_isFullScreen) {
      _isFullScreen = true;
      controller.postEvent(BPEvent(BPEventType.openFullscreen));
      await _pushFullScreenWidget(context);
    } else if (_isFullScreen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isFullScreen = false;
      controller.postEvent(BPEvent(BPEventType.hideFullscreen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BPControllerProvider(
      controller: widget.controller,
      child: _buildPlayer(),
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

  AnimatedWidget _defaultRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    BPControllerProvider controllerProvider,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return _buildFullScreenVideo(context, animation, controllerProvider);
      },
    );
  }

  Widget _fullScreenRoutePageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final controllerProvider = BPControllerProvider(controller: widget.controller, child: _buildPlayer());

    final routePageBuilder = _betterPlayerConfiguration.routePageBuilder;
    if (routePageBuilder == null) {
      return _defaultRoutePageBuilder(context, animation, secondaryAnimation, controllerProvider);
    }

    return routePageBuilder(context, animation, secondaryAnimation, controllerProvider);
  }

  Future<dynamic> _pushFullScreenWidget(BuildContext context) async {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      settings: const RouteSettings(),
      pageBuilder: _fullScreenRoutePageBuilder,
    );

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (_betterPlayerConfiguration.autoDetectFullscreenDeviceOrientation == true) {
      final aspectRatio = widget.controller.videoPlayerController?.value.aspectRatio ?? 1.0;
      List<DeviceOrientation> deviceOrientations;
      if (aspectRatio < 1.0) {
        deviceOrientations = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
      } else {
        deviceOrientations = [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight];
      }
      await SystemChrome.setPreferredOrientations(deviceOrientations);
    } else {
      await SystemChrome.setPreferredOrientations(
        widget.controller.betterPlayerConfiguration.deviceOrientationsOnFullScreen,
      );
    }

    if (!_betterPlayerConfiguration.allowedScreenSleep) {
      Wakelock.enable();
    }

    await Navigator.of(context, rootNavigator: true).push(route);
    _isFullScreen = false;
    widget.controller.exitFullScreen();

    // The wakelock plugins checks whether it needs to perform an action internally,
    // so we do not need to check Wakelock.isEnabled.
    Wakelock.disable();

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: _betterPlayerConfiguration.systemOverlaysAfterFullScreen);
    await SystemChrome.setPreferredOrientations(_betterPlayerConfiguration.deviceOrientationsAfterFullScreen);
  }

  Widget _buildPlayer() {
    var sections = widget.controller.betterPlayerDataSource?.sections;
    return sections == null ? _buildPlayerNoVideoSections() : _buildPlayerHasVideoSections(sections);
  }

  Widget _buildPlayerNoVideoSections() {
    return VisibilityDetector(
      key: Key("${widget.controller.hashCode}_key"),
      onVisibilityChanged: (VisibilityInfo info) => widget.controller.onPlayerVisibilityChanged(info.visibleFraction),
      child: BPWithControls(
        controller: widget.controller,
      ),
    );
  }

  Widget _buildPlayerHasVideoSections(List<Section> sections) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoSectionsState>(create: (_) => VideoSectionsState(sections.length)),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPlayerNoVideoSections(),
          Divider(),
          Builder(builder: (ctx) {
            return IconButton(
              onPressed: () => Provider.of<VideoSectionsState>(ctx, listen: false).setIsShow(true),
              icon: Icon(Icons.show_chart_rounded),
            );
          }),
          _buildVideoSections(sections),
        ],
      ),
    );
  }

  Widget _buildVideoSections(List<Section> sections) {
    return Selector<VideoSectionsState, bool>(
      selector: (_, vs) => vs.isShow,
      builder: (_, isShow, __) {
        if (isShow) {
          return Expanded(child: VideoSections(sections));
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.controller.setAppLifecycleState(state);
  }
}

///Page route builder used in fullscreen mode.
typedef BPRoutePageBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  BPControllerProvider controllerProvider,
);
