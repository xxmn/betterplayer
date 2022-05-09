import 'dart:math';
import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/config/bp_placeholder_provider.dart';
import 'package:better_player/src/config/bp_theme_provider.dart';
import 'package:better_player/src/controls/bp_material_controls.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:better_player/src/native_player/native_player.dart';
import 'package:better_player/src/native_player/np_set_data_source_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitles_drawer.dart';
import 'package:better_player/src/types/bp_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    var backgroundColor = ref.watch(bpControlsProvider!.select((v) => v.backgroundColor));
    var aspectRatio = ref.watch(npStatusProvider.select((v) => v.aspectRatio));
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
          overlay ?? Container(),
          BPSubtitlesDrawer(),
          if (!placeholderOnTop) placeholder,
          _MaybeShowControls(),
        ],
      ),
    );
  }
}

class _MaybeBPVideoFitWidget extends HookConsumerWidget {
  const _MaybeBPVideoFitWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var init = ref.watch(bpIsInitializedProvider);
    var started = ref.watch(bpIsStartedProvider);
    var npSetDataSource = ref.watch(npSetDataSourceProvider);
    // return init && started ? _BPVideoFitWidget() : const SizedBox();
    return init ? _BPVideoFitWidget() : _BPVideoFitWidget();
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
            fit: BoxFit.contain,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: NativePlayer(),
              // child: npPlayerStatus.isCreated
              //     ? Text(
              //         "NativePlayer : $npPlayerStatus.textureId",
              //         style: TextStyle(
              //           color: Colors.red,
              //           fontSize: 48,
              //         ),
              //       )
              //     : Text("NativePlayer"),
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
    var showControls = ref.watch(bpControlsProvider!.select((v) => v.showControls));
    // return showControls ? _CustomOrOSControls() : const SizedBox();
    return const SizedBox();
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
        return BPMaterialControls();
      case BPTheme.cupertino:
        return Container(child: Text("cupertino"));
      case BPTheme.custom:
        var customControlsBuilder = ref.watch(
          bpControlsProvider!.select((v) => v.customControlsBuilder),
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
