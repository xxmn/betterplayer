import 'package:better_player/src/native_player/platform_interface.dart';
import 'package:flutter/material.dart';

final NativePlayerPlatform _videoPlayerPlatform = NativePlayerPlatform.instance
// This will clear all open videos on the platform when a full restart is
// performed.
  ..init();

/// Widget that displays the video controlled by [controller].
class NativePlayer extends StatefulWidget {
  /// Uses the given [controller] for all video rendered in this widget.
  const NativePlayer({Key? key}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<NativePlayer> {
  _VideoPlayerState() {
    _listener = () {
      final int? newTextureId = widget.controller!.textureId;
      if (newTextureId != _textureId) {
        setState(() {
          _textureId = newTextureId;
        });
      }
    };
  }

  late VoidCallback _listener;
  int? _textureId;

  @override
  void initState() {
    super.initState();
    _textureId = widget.controller!.textureId;
    // Need to listen for initialization events since the actual texture ID
    // becomes available after asynchronous initialization finishes.
    widget.controller!.addListener(_listener);
  }

  @override
  void didUpdateWidget(NativePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller!.removeListener(_listener);
    _textureId = widget.controller!.textureId;
    widget.controller!.addListener(_listener);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller!.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == null ? Container() : _videoPlayerPlatform.buildView(_textureId);
  }
}
