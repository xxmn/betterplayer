import 'package:better_player/better_player.dart';
import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/core/bp_app_lifecycle_provider.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/fullscreen/bp_config_provider.dart';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_visibility_detector.dart';
import 'init_config.dart';

////////////////////////////////////////////////////////////////////////
///
///BetterPlayer 接口
///
////////////////////////////////////////////////////////////////////////
class BetterPlayer extends StatefulWidget {
  late final BPInitConfig _bpInitConfig;

  BetterPlayer({
    Key? key,
    required BPDataSource dataSource,
    BPConfig? config,
    BPSubtitlesConfig? subtitlesConfig,
    BPControlsConfig? controlsConfig,
    BPFullScreenConfig? fullScreenConfig,
    BPAppLifecycle? appLifecycle,
  })  : _bpInitConfig = BPInitConfig(
          dataSource: dataSource,
          config: config,
          subtitlesConfig: subtitlesConfig,
          controlsConfig: controlsConfig,
          fullScreenConfig: fullScreenConfig,
          appLifecycle: appLifecycle,
        ),
        super(key: key);

  factory BetterPlayer.network(
    String url, {
    BPConfig? config,
    BPSubtitlesConfig? subtitlesConfig,
    BPControlsConfig? controlsConfig,
    BPFullScreenConfig? fullScreenConfig,
    BPAppLifecycle? appLifecycle,
  }) {
    return BetterPlayer(
      dataSource: BPDataSource(BPDataSourceType.network, url),
      config: config,
      subtitlesConfig: subtitlesConfig,
      controlsConfig: controlsConfig,
      fullScreenConfig: fullScreenConfig,
      appLifecycle: appLifecycle,
    );
  }

  factory BetterPlayer.file(
    String url, {
    BPConfig? config,
    BPSubtitlesConfig? subtitlesConfig,
    BPControlsConfig? controlsConfig,
    BPFullScreenConfig? fullScreenConfig,
    BPAppLifecycle? appLifecycle,
  }) {
    return BetterPlayer(
      dataSource: BPDataSource(BPDataSourceType.file, url),
      config: config,
      subtitlesConfig: subtitlesConfig,
      controlsConfig: controlsConfig,
      fullScreenConfig: fullScreenConfig,
      appLifecycle: appLifecycle,
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

////////////////////////////////////////////////////////////////////////
///
/// 初始化 providers
///
////////////////////////////////////////////////////////////////////////

void _initProviders(BPInitConfig _bpInitConfig) {
  initBpDataSourceProvider(_bpInitConfig.dataSource);
  initBpSubtitlesConfigProvider(_bpInitConfig.subtitlesConfig);
  initBpConfigProvider(_bpInitConfig.config);
  initBpControlsConfigProvider(_bpInitConfig.controlsConfig);
  initBpFullScreenConfigProvider(_bpInitConfig.fullScreenConfig);
  initNpCreateProvider();
  // initNpControllerProvider();
}

void _disposeProviders() {
  disposeBpDataSourceProvider();
  disposeBpSubtitlesConfigProvider();
  disposeBpConfigProvider();
  disposeBpControlsConfigProvider();
  disposeBpFullScreenConfigProvider();
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
  late final BPInitConfig _bpInitConfig;
  _BPInitProviders(BPInitConfig bpInitConfig, {Key? key})
      : _bpInitConfig = bpInitConfig,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BPInitProvidersState();
}

class __BPInitProvidersState extends ConsumerState<_BPInitProviders> {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      var bpLife = widget._bpInitConfig.appLifecycle;
      if (bpLife != null)
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

    ref.read(bpAppLifecycleProvider.notifier).setState(state);
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
