import 'dart:math';
import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/config/bp_placeholder_provider.dart';
import 'package:better_player/src/config/bp_theme_provider.dart';
import 'package:better_player/src/controls/bp_material_controls.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:better_player/src/swipe/brightness_message.dart';
import 'package:better_player/src/swipe/position_message.dart';
import 'package:better_player/src/swipe/volumn_message.dart';
import 'package:better_player/src/native_player/native_player.dart';
import 'package:better_player/src/subtitles/bp_subtitles_drawer.dart';
import 'package:better_player/src/defines/bp_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'aspect_ratio_provider.dart';

class BPWithControls extends HookConsumerWidget {
  const BPWithControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var expandToFill = ref.watch(bpConfigProvider!.select((v) => v.expandToFill));
    if (expandToFill) {
      return Center(child: _InnerContainer());
    } else {
      return _InnerContainer();
    }
  }
}

class _InnerContainer extends HookConsumerWidget {
  const _InnerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var backgroundColor = ref.watch(bpControlsConfigProvider!.select((v) => v.backgroundColor));
    var aspectRatio = ref.watch(bpAspectRatioProvider);
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: _CheckDataSource(),
      ),
    );
  }
}

class _CheckDataSource extends HookConsumerWidget {
  const _CheckDataSource({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bpDataSource = ref.watch(bpDataSourceProvider!);

    return bpDataSource == null ? SizedBox() : _PlayerWithControls();
  }
}

class _PlayerWithControls extends HookConsumerWidget {
  const _PlayerWithControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var rotation = ref.watch(bpConfigProvider!.select((v) => v.rotation));
    var placeholderOnTop = ref.watch(bpConfigProvider!.select((v) => v.placeholderOnTop));
    var overlay = ref.watch(bpConfigProvider!.select((v) => v.overlay));

    Widget placeholder = ref.watch(bpPlaceholderProvider);
    return Container(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          if (placeholderOnTop) placeholder,
          Transform.rotate(
            angle: rotation * pi / 180,
            child: _MaybeBPVideoFitWidget(),
          ),
          overlay ?? SizedBox(),
          BPSubtitlesDrawer(),
          if (!placeholderOnTop) placeholder,
          _MaybeShowControls(),
          MaybeShowVolumnMessage(),
          MaybeShowBrightnessMessage(),
          MaybeShowPositionMessage(),
        ],
      ),
    );
  }
}

class _MaybeBPVideoFitWidget extends HookConsumerWidget {
  const _MaybeBPVideoFitWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var shouldShow = ref.watch(bpShouldShowVideoProvider);
    return shouldShow ? _BPVideoFitWidget() : const SizedBox();
  }
}

class _BPVideoFitWidget extends HookConsumerWidget {
  const _BPVideoFitWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fit = ref.watch(bpConfigProvider!.select((v) => v.fit));
    var size = ref.watch(bpSizeProvider);
    return Center(
      child: ClipRect(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: FittedBox(
            fit: fit,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: NativePlayer(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MaybeShowControls extends HookConsumerWidget {
  const _MaybeShowControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showControls = ref.watch(bpControlsConfigProvider!.select((v) => v.showControls));
    return showControls ? _CustomOrOSControls() : const SizedBox();
  }
}

class _CustomOrOSControls extends HookConsumerWidget {
  const _CustomOrOSControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var playerTheme = ref.watch(bpThemeProvider);

    switch (playerTheme) {
      case BPTheme.material:
        return BPMaterialControls();
      case BPTheme.cupertino:
        return Container(child: Text("cupertino"));
      case BPTheme.custom:
        var customControlsBuilder = ref.watch(
          bpControlsConfigProvider!.select((v) => v.customControlsBuilder),
        );
        if (customControlsBuilder != null) {
          var onPlayerVisibilityChanged = (bool isVisible) {};
          return customControlsBuilder(onPlayerVisibilityChanged);
        } else {
          return Container(child: Text("no customControlsBuilder"));
        }
      default:
        return Container(child: Text("unkown bpTheme type"));
    }
  }
}

// Widget _buildCupertinoControl() {
//   return BPCupertinoControls(

//   );
// }
