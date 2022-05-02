import 'package:better_player/better_player.dart';
import 'package:better_player/src/configuration/better_player_notification_cfg.dart';
import 'package:better_player/src/configuration/bp_global.dart';
import 'package:better_player/src/core/bp_data_source_notifier.dart';
import 'package:better_player/src/core/bp_event_bus.dart';
import 'package:better_player/src/core/bp_fullscreen_page.dart';
import 'package:better_player/src/core/bp_normal_page.dart';
import 'package:better_player/src/core/np_event_bus.dart';
import 'package:better_player/src/core/bp_notifier.dart';
import 'package:better_player/src/core/bp_translations_notifier.dart';
import 'package:better_player/src/utils/better_player_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 构造函数
/// 本地化  TranslationsNotifier
/// BPNotifier
class BetterPlayer extends StatefulWidget {
  // EventBus bpEventBus = BpEventBus();
  // EventBus npEventBus = NpEventBus();
  BetterPlayer({
    Key? key,
    required this.bpDataSource,
    required this.bpNotificationCfg,
  }) : super(key: key) {}

  late BPDataSource bpDataSource;
  late BPNotificationCfg bpNotificationCfg;

  factory BetterPlayer.network(String url) => BetterPlayer(
        bpDataSource: BPDataSource(BPDataSourceType.network, url),
        bpNotificationCfg: const BPNotificationCfg(showNotification: false),
      );

  factory BetterPlayer.file(String url) => BetterPlayer(
        bpDataSource: BPDataSource(BPDataSourceType.file, url),
        bpNotificationCfg: const BPNotificationCfg(showNotification: false),
      );

  @override
  State<BetterPlayer> createState() => _BetterPlayerState();
}

class _BetterPlayerState extends State<BetterPlayer> {
  var locale = const Locale("en", "US");

  @override
  void initState() {
    super.initState();

    //Default locale
    try {
      if (mounted) {
        locale = Localizations.localeOf(context);
      }
    } catch (exception) {
      BPUtils.log(exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BPNotifier>(create: (_) => BPNotifier()),
        ChangeNotifierProvider<TranslationsNotifier>(create: (_) => TranslationsNotifier(locale: locale)),
        ChangeNotifierProvider<BPDataSourceNotifier>(
          create: (_) => BPDataSourceNotifier(
            bpDataSource: widget.bpDataSource,
            bpNotificationCfg: widget.bpNotificationCfg,
          ),
        ),
      ],
      builder: (context, child) {
        BPGlobal.setGlobalBpNotifier(context);
        BPGlobal.setGlobalBPDataSourceNotifier(context);
        BPGlobal.setGlobalTranslationsNotifier(context);
        return _BetterPlayer();
      },
    );
  }
}

/// app 生命周期
/// isFullScreen
class _BetterPlayer extends StatefulWidget {
  _BetterPlayer({Key? key}) : super(key: key);

  @override
  _BPState createState() {
    return _BPState();
  }
}

class _BPState extends State<_BetterPlayer> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BPNotifier, bool>(
      selector: (_, bpNotifier) => bpNotifier.isFullScreen,
      builder: (_, isFullScreen, __) {
        return isFullScreen ? BpFullScreenPage() : BpNormalPage();
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.bpController.setAppLifecycleState(state);
  }
}

///Page route builder used in fullscreen mode.
typedef BPRoutePageBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
);
