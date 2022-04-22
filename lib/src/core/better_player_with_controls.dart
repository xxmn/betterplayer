import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:better_player/better_player.dart';
import 'package:better_player/src/configuration/better_player_controller_event.dart';
import 'package:better_player/src/controls/better_player_cupertino_controls.dart';
import 'package:better_player/src/controls/better_player_material_controls.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:better_player/src/subtitles/better_player_subtitles_drawer.dart';
import 'package:better_player/src/video_player/video_player.dart';
import 'package:flutter/material.dart';

class BPWithControls extends StatefulWidget {
  final BPController? controller;

  const BPWithControls({Key? key, this.controller}) : super(key: key);

  @override
  _BPWithControlsState createState() => _BPWithControlsState();
}

class _BPWithControlsState extends State<BPWithControls> {
  BPSubtitlesCfg get subtitlesCfg => widget.controller!.bpCfg.subtitlesCfg;

  BPControlsCfg get controlsCfg => widget.controller!.bpControlsCfg;

  final StreamController<bool> playerVisibilityStreamController = StreamController();

  bool _initialized = false;

  StreamSubscription? _controllerEventSubscription;

  @override
  void initState() {
    playerVisibilityStreamController.add(true);
    _controllerEventSubscription = widget.controller!.controllerEventStream.listen(_onControllerChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(BPWithControls oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _controllerEventSubscription?.cancel();
      _controllerEventSubscription = widget.controller!.controllerEventStream.listen(_onControllerChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    playerVisibilityStreamController.close();
    _controllerEventSubscription?.cancel();
    super.dispose();
  }

  void _onControllerChanged(BPControllerEvent event) {
    setState(() {
      if (!_initialized) {
        _initialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final BPController bpController = BPController.of(context);

    double? aspectRatio;
    if (bpController.isFullScreen) {
      if (bpController.bpCfg.autoDetectFullscreenDeviceOrientation ||
          bpController.bpCfg.autoDetectFullscreenAspectRatio) {
        aspectRatio = bpController.videoPlayerController?.value.aspectRatio ?? 1.0;
      } else {
        aspectRatio = bpController.bpCfg.fullScreenAspectRatio ?? BPUtils.calculateAspectRatio(context);
      }
    } else {
      aspectRatio = bpController.getAspectRatio();
    }

    aspectRatio ??= 16 / 9;
    final innerContainer = Container(
      width: double.infinity,
      color: bpController.bpCfg.controlsCfg.backgroundColor,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: _buildPlayerWithControls(bpController, context),
      ),
    );

    if (bpController.bpCfg.expandToFill) {
      return Center(child: innerContainer);
    } else {
      return innerContainer;
    }
  }

  Container _buildPlayerWithControls(BPController bpController, BuildContext context) {
    final configuration = bpController.bpCfg;
    var rotation = configuration.rotation;

    if (!(rotation <= 360 && rotation % 90 == 0)) {
      BPUtils.log("Invalid rotation provided. Using rotation = 0");
      rotation = 0;
    }
    if (bpController.bpDataSource == null) {
      return Container();
    }
    _initialized = true;

    final bool placeholderOnTop = bpController.bpCfg.placeholderOnTop;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          if (placeholderOnTop) _buildPlaceholder(bpController),
          Transform.rotate(
            angle: rotation * pi / 180,
            child: _BPVideoFitWidget(
              bpController,
              bpController.getFit(),
            ),
          ),
          bpController.bpCfg.overlay ?? Container(),
          BPSubtitlesDrawer(
            bpController: bpController,
            bpSubtitlesCfg: subtitlesCfg,
            subtitles: bpController.subtitlesLines,
            playerVisibilityStream: playerVisibilityStreamController.stream,
          ),
          if (!placeholderOnTop) _buildPlaceholder(bpController),
          _buildControls(context, bpController),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(BPController bpController) {
    return bpController.bpDataSource!.placeholder ?? bpController.bpCfg.placeholder ?? Container();
  }

  Widget _buildControls(
    BuildContext context,
    BPController bpController,
  ) {
    if (controlsCfg.showControls) {
      BPTheme? playerTheme = controlsCfg.playerTheme;
      if (playerTheme == null) {
        if (Platform.isAndroid) {
          playerTheme = BPTheme.material;
        } else {
          playerTheme = BPTheme.cupertino;
        }
      }

      if (controlsCfg.customControlsBuilder != null && playerTheme == BPTheme.custom) {
        return controlsCfg.customControlsBuilder!(bpController, onControlsVisibilityChanged);
      } else if (playerTheme == BPTheme.material) {
        return _buildMaterialControl();
      } else if (playerTheme == BPTheme.cupertino) {
        return _buildCupertinoControl();
      }
    }

    return const SizedBox();
  }

  Widget _buildMaterialControl() {
    return BPMaterialControls(
      onControlsVisibilityChanged: onControlsVisibilityChanged,
      controlsCfg: controlsCfg,
    );
  }

  Widget _buildCupertinoControl() {
    return BPCupertinoControls(
      onControlsVisibilityChanged: onControlsVisibilityChanged,
      controlsCfg: controlsCfg,
    );
  }

  void onControlsVisibilityChanged(bool state) {
    playerVisibilityStreamController.add(state);
  }
}

///Widget used to set the proper box fit of the video. Default fit is 'fill'.
class _BPVideoFitWidget extends StatefulWidget {
  const _BPVideoFitWidget(
    this.bpController,
    this.boxFit, {
    Key? key,
  }) : super(key: key);

  final BPController bpController;
  final BoxFit boxFit;

  @override
  _BPVideoFitWidgetState createState() => _BPVideoFitWidgetState();
}

class _BPVideoFitWidgetState extends State<_BPVideoFitWidget> {
  VideoPlayerController? get controller => widget.bpController.videoPlayerController;

  bool _initialized = false;

  VoidCallback? _initializedListener;

  bool _started = false;

  StreamSubscription? _controllerEventSubscription;

  @override
  void initState() {
    super.initState();
    if (!widget.bpController.bpCfg.showPlaceholderUntilPlay) {
      _started = true;
    } else {
      _started = widget.bpController.hasCurrentDataSourceStarted;
    }

    _initialize();
  }

  @override
  void didUpdateWidget(_BPVideoFitWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bpController.videoPlayerController != controller) {
      if (_initializedListener != null) {
        oldWidget.bpController.videoPlayerController!.removeListener(_initializedListener!);
      }
      _initialized = false;
      _initialize();
    }
  }

  void _initialize() {
    if (controller?.value.initialized == false) {
      _initializedListener = () {
        if (!mounted) {
          return;
        }

        if (_initialized != controller!.value.initialized) {
          _initialized = controller!.value.initialized;
          setState(() {});
        }
      };
      controller!.addListener(_initializedListener!);
    } else {
      _initialized = true;
    }

    _controllerEventSubscription = widget.bpController.controllerEventStream.listen((event) {
      if (event == BPControllerEvent.play) {
        if (!_started) {
          setState(() {
            _started = widget.bpController.hasCurrentDataSourceStarted;
          });
        }
      }
      if (event == BPControllerEvent.setupDataSource) {
        setState(() {
          _started = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized && _started) {
      return Center(
        child: ClipRect(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: widget.boxFit,
              child: SizedBox(
                width: controller!.value.size?.width ?? 0,
                height: controller!.value.size?.height ?? 0,
                child: VideoPlayer(controller),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  void dispose() {
    if (_initializedListener != null) {
      widget.bpController.videoPlayerController!.removeListener(_initializedListener!);
    }
    _controllerEventSubscription?.cancel();
    super.dispose();
  }
}
