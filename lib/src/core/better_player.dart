import 'package:better_player/src/core/app_lifecycle_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../config/bp_config.dart';
import '../config/bp_data_source_type.dart';
import '../config/bp_data_source.dart';
import 'bp_controller.dart';

///
///BetterPlayer 接口
///
class BetterPlayer extends StatefulWidget {
  final BPController bpController;

  BetterPlayer({Key? key, required this.bpController}) : super(key: key);

  factory BetterPlayer.network(
    String url, {
    BPConfig? bpConfig,
  }) {
    return BetterPlayer(
      bpController: BPController(
        bpConfig ?? const BPConfig(),
        bpDataSource: BPDataSource(BPDataSourceType.network, url),
      ),
    );
  }

  factory BetterPlayer.file(
    String url, {
    BPConfig? bpConfig,
  }) {
    return BetterPlayer(
      bpController: BPController(
        bpConfig ?? const BPConfig(),
        bpDataSource: BPDataSource(BPDataSourceType.file, url),
      ),
    );
  }

  @override
  State<BetterPlayer> createState() => _BetterPlayerState();
}

class _BetterPlayerState extends State<BetterPlayer> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: _BPInitProviders(widget.bpController));
  }
}

///
/// 初始化 providers
///

void _initProviders(BPController bpController, T Function<T>(ProviderBase<T>) read) {
  var bpConfig = bpController.bpConfig;
  read(appLifecycleProvider.notifier).isHandleLifecycle = bpConfig.isHandleLifecycle;
}

class _BPInitProviders extends HookConsumerWidget {
  late final BPController bpController;

  _BPInitProviders(this.bpController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      _initProviders(bpController, ref.read);
      return null;
    }, const []);

    return _BPAppLifecycle();
  }
}

///
///app life cycle 处理
///
class _BPAppLifecycle extends StatefulHookConsumerWidget {
  const _BPAppLifecycle({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __BPAppLifecycleState();
}

class __BPAppLifecycleState extends ConsumerState<_BPAppLifecycle> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    ref.read(appLifecycleProvider.notifier).appLifecycleState = state;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance!.addObserver(this);

      return () => WidgetsBinding.instance!.removeObserver(this);
    }, const []);
    return Container(
      color: Colors.yellow,
    );
  }
}
