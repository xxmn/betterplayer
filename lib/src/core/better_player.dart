import 'package:better_player/src/config/bp_config.dart';
import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/config/bp_controls.dart';
import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/core/bp_app_lifecycle_provider.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config_provider.dart';
import 'package:better_player/src/defines/bp_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_visibility_detector.dart';

////////////////////////////////////////////////////////////////////////
///
///BetterPlayer 接口
///
////////////////////////////////////////////////////////////////////////
class BetterPlayer extends StatefulWidget {
  late final _BPInitConfig _bpInitConfig;

  BetterPlayer({
    Key? key,
    required BPDataSource bpDataSource,
    BPConfig? bpConfig,
    BPSubtitlesConfig? subtitlesConfig,
    BPControlsConfig? controlsConfig,
    BPAppLifecycle? bpAppLifecycle,
  })  : _bpInitConfig = _BPInitConfig(
          bpDataSource: bpDataSource,
          bpConfig: bpConfig ?? BPConfig(),
          subtitlesConfig: subtitlesConfig ?? BPSubtitlesConfig(),
          controlsConfig: controlsConfig ?? BPControlsConfig(),
          bpAppLifecycle: bpAppLifecycle ?? BPAppLifecycle(),
        ),
        super(key: key);

  factory BetterPlayer.network(
    String url, {
    BPConfig? bpConfig,
  }) {
    return BetterPlayer(
      bpDataSource: BPDataSource(BPDataSourceType.network, url),
      bpConfig: bpConfig,
    );
  }

  factory BetterPlayer.file(
    String url, {
    BPConfig? bpConfig,
  }) {
    return BetterPlayer(
      bpDataSource: BPDataSource(BPDataSourceType.file, url),
      bpConfig: bpConfig,
    );
  }

  @override
  State<BetterPlayer> createState() => _BetterPlayerState();
}

class _BetterPlayerState extends State<BetterPlayer> {
  @override
  Widget build(BuildContext context) {
    return _BPInitProviders(widget._bpInitConfig);
  }
}

class _BPInitConfig {
  const _BPInitConfig({
    required this.bpDataSource,
    required this.bpConfig,
    required this.subtitlesConfig,
    required this.controlsConfig,
    required this.bpAppLifecycle,
  });

  ///General configuration used in controller instance.
  final BPConfig bpConfig;

  // ///Playlist configuration used in controller instance.
  // final BPPlaylistConfig? bpPlaylistConfig;

  // ///Currently used data source in player.
  final BPDataSource bpDataSource;

  // ///Defines subtitles configuration
  final BPSubtitlesConfig subtitlesConfig;

  ///Defines controls configuration
  final BPControlsConfig controlsConfig;

  //
  final BPAppLifecycle bpAppLifecycle;
}

////////////////////////////////////////////////////////////////////////
///
/// 初始化 providers
///
////////////////////////////////////////////////////////////////////////

void _initProviders(_BPInitConfig _bpInitConfig) {
  initBpDataSourceProvider(_bpInitConfig.bpDataSource);
  initBpSubtitlesConfigProvider(_bpInitConfig.subtitlesConfig);
  initBpConfigProvider(_bpInitConfig.bpConfig);
  initBpControlsProvider(_bpInitConfig.controlsConfig);
  initNpCreateProvider();
  // initNpControllerProvider();
}

void _disposeProviders() {
  disposeBpDataSourceProvider();
  disposeBpSubtitlesConfigProvider();
  disposeBpConfigProvider();
  disposeBpControlsProvider();
  disposeNpCreateProvider();
  // disposeNpControllerProvider();
}

void _initTranslation(BuildContext context) {
  initBpLocaleProvider(context);
  initBpTranslationsProvider();
}

void _disposeTranslation() {
  disposeBpLocaleProvider();
  disposeBpTranslationsProvider();
}

class _BPInitProviders extends StatefulHookConsumerWidget {
  late final _BPInitConfig _bpInitConfig;
  _BPInitProviders(_BPInitConfig bpInitConfig, {Key? key})
      : _bpInitConfig = bpInitConfig,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BPInitProvidersState();
}

class __BPInitProvidersState extends ConsumerState<_BPInitProviders> {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      var bpLife = widget._bpInitConfig.bpAppLifecycle;
      ref.read(bpAppLifecycleProvider.notifier).isHandleLifecycle = bpLife.isHandleLifecycle;
      return null;
    }, const []);

    useEffect(() {
      _initProviders(widget._bpInitConfig);
      return _disposeProviders;
    }, const []);

    useEffect(() {
      _initTranslation(context);
      return _disposeTranslation;
    }, const []);
    return _BPAppLifecycle();
  }
}

////////////////////////////////////////////////////////////////////////
///
///app life cycle 处理
///
////////////////////////////////////////////////////////////////////////
class _BPAppLifecycle extends StatefulHookConsumerWidget {
  const _BPAppLifecycle({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BPAppLifecycleState();
}

class __BPAppLifecycleState extends ConsumerState<_BPAppLifecycle> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    ref.read(bpAppLifecycleProvider.notifier).appLifecycleState = state;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance!.addObserver(this);
      return () => WidgetsBinding.instance!.removeObserver(this);
    }, const []);
    return BPVisibilityDetector();
    // return _BPRoute();
  }
}
