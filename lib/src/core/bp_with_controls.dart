import 'dart:io';

import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_data_source_provider.dart';
import 'package:better_player/src/config/bp_placeholder_provider.dart';
import 'package:better_player/src/config/bp_theme_provider.dart';
import 'package:better_player/src/types/bp_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:math';

class BPWithControls extends HookConsumerWidget {
  const BPWithControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var expandToFill = ref.watch(bpConfigProvider).expandToFill;
    if (expandToFill) {
      return Center(child: _InnerContainer());
    } else {
      return _InnerContainer();
    }
    ;
  }
}

class _InnerContainer extends HookConsumerWidget {
  const _InnerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var backgroundColor = ref.watch(bpControlsProvider).backgroundColor;
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _CheckDataSource(),
      ),
    );
  }
}

class _CheckDataSource extends HookConsumerWidget {
  const _CheckDataSource({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bpDataSource = ref.watch(bpDataSourceProvider);

    // print("bpDataSource: $bpDataSource");

    if (bpDataSource == null) {
      return Container();
    } else {
      return _PlayerWithControls();
    }
  }
}

class _PlayerWithControls extends HookConsumerWidget {
  const _PlayerWithControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var rotation = ref.watch(bpConfigProvider.select((v) => v.rotation));
    var placeholderOnTop = ref.watch(bpConfigProvider.select((v) => v.placeholderOnTop));
    var overlay = ref.watch(bpConfigProvider.select((v) => v.overlay));

    Widget placeholder = ref.watch(bpPlaceholderProvider);
    return Container(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          if (placeholderOnTop) placeholder,
          // Transform.rotate(
          //   angle: rotation * pi / 180,
          //   child: _BPVideoFitWidget(),
          // ),
          overlay ?? Container(),
          // BPSubtitlesDrawer(),
          if (!placeholderOnTop) placeholder,
          _MaybeShowControls(),
        ],
      ),
    );
  }
}

class _MaybeShowControls extends HookConsumerWidget {
  const _MaybeShowControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showControls = ref.watch(bpControlsProvider.select((v) => v.showControls));
    return showControls ? _CustomOrOSControls() : const SizedBox();
  }
}

class _CustomOrOSControls extends HookConsumerWidget {
  const _CustomOrOSControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("get in _CustomOrOSControls...");

    var playerTheme = ref.watch(bpThemeProvider);

    switch (playerTheme) {
      case BPTheme.material:
        return Container(
            child: Text(
          "material",
          style: TextStyle(color: Colors.white, fontSize: 48),
        ));
      case BPTheme.cupertino:
        return Container(child: Text("cupertino"));
      case BPTheme.custom:
        var customControlsBuilder = ref.watch(
          bpControlsProvider.select((v) => v.customControlsBuilder),
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


  // Widget _buildMaterialControl() {
  //   return BPMaterialControls(
  //     controlsConfig: controlsConfig,
  //   );
  // }

  // Widget _buildCupertinoControl() {
  //   return BPCupertinoControls(
  //     controlsConfig: controlsConfig,
  //   );
  // }

