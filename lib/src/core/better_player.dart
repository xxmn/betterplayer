import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/core/bp_app_lifecycle_provider.dart';
import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:better_player/src/subtitles/bp_subtitles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../config/bp_config_provider.dart';
import '../types/data_source_type.dart';
import '../config/bp_data_source_provider.dart';
import 'bp_with_controls.dart';

////////////////////////////////////////////////////////////////////////
///
///BetterPlayer 接口
///
////////////////////////////////////////////////////////////////////////
class BetterPlayer extends StatefulWidget {
  late _BPInitConfig _bpInitConfig;

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
      bpDataSource: BPDataSource(DataSourceType.network, url),
      bpConfig: bpConfig,
    );
  }

  factory BetterPlayer.file(
    String url, {
    BPConfig? bpConfig,
  }) {
    return BetterPlayer(
      bpDataSource: BPDataSource(DataSourceType.file, url),
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

  bpDataSourceProvider = StateNotifierProvider<BPDataSourceNotifier, BPDataSource?>(
    (ref) => BPDataSourceNotifier(
      bpDataSource: _bpInitConfig.bpDataSource,
    ),
  );

  bpConfigProvider = StateNotifierProvider<BPConfigNotifier, BPConfig>(
    (ref) => BPConfigNotifier(
      bpConfig: _bpInitConfig.bpConfig,
    ),
  );

  bpControlsProvider = StateNotifierProvider<BPControlsNotifier, BPControlsConfig>(
    (ref) => BPControlsNotifier(
      bpControlsConfig: _bpInitConfig.controlsConfig,
    ),
  );

  bpSubtitlesProvider = StateNotifierProvider<BPSubtitlesNotifier, BPSubtitlesConfig>(
    (ref) => BPSubtitlesNotifier(
      bpSubtitlesConfig: _bpInitConfig.subtitlesConfig,
    ),
  );
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
  void initState() {
    super.initState();
    _initProviders(widget._bpInitConfig, ref.read);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        ref.read(bpIsVisibleProvider.notifier).setIsVisible(info.visibleFraction);
      },
      key: id,
      // child: BPWithControls(),
      child: BPWithControls(),
    );
  }
}
