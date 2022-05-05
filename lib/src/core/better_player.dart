import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/core/bp_app_lifecycle_provider.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitles_provider.dart';
import 'package:better_player/src/types/bp_data_source.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../config/bp_config_provider.dart';
import 'bp_playing_status_provider.dart';
import 'bp_with_controls.dart';

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
    return ProviderScope(child: _BPInitProviders(widget._bpInitConfig));
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

void _initProviders(_BPInitConfig _bpInitConfig, T Function<T>(ProviderBase<T>) read) {
  var bpAppLifecycle = _bpInitConfig.bpAppLifecycle;
  read(bpAppLifecycleProvider.notifier).isHandleLifecycle = bpAppLifecycle.isHandleLifecycle;

  initBpDataSourceProvider(_bpInitConfig.bpDataSource);
  initBpConfigProvider(_bpInitConfig.bpConfig);
  initBpControlsProvider(_bpInitConfig.controlsConfig);
  initBpSubtitlesProvider(_bpInitConfig.subtitlesConfig);
  initBpPlayingStatusProvider();
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
      _initProviders(widget._bpInitConfig, ref.read);
      return null;
    }, const []);
    useEffect(() {
      initBpLocaleProvider(context);
      initBpTranslationsProvider();
      return null;
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
    return _BPVisibilityDetector();
  }
}

////////////////////////////////////////////////////////////////////////
///
///可见性回掉函数
///disposed状态
///
////////////////////////////////////////////////////////////////////////
class _BPVisibilityDetector extends HookConsumerWidget {
  _BPVisibilityDetector({Key? key}) : super(key: key);
  final Key id = UniqueKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return () => ref.read(bpIsDisposedProvider.notifier).state = true;
    }, const []);

    return VisibilityDetector(
      // key: Key("${widget.controller.hashCode}_key"),
      onVisibilityChanged: (VisibilityInfo info) {
        print("bpIsVisibleProvider: $bpIsVisibleProvider");
        ref.read(bpIsVisibleProvider.notifier).setIsVisible(info.visibleFraction);
      },
      key: id,
      // child: BPWithControls(),
      child: BPWithControls(),
    );
  }
}
