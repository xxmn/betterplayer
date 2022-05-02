import 'package:better_player/src/config/bp_config.dart';
import 'package:better_player/src/config/bp_data_source.dart';

// late final StateNotifierProvider<AppLifeCycleNotifier, AppLifecycle> appLifecycleProvider;

///Class used to control overall Better Player behavior. Main class to change
///state of Better Player.
class BPController {
  // ///General configuration used in controller instance.
  final BPConfig bpConfig;

  // ///Playlist configuration used in controller instance.
  // final BPPlaylistConfig? bpPlaylistConfig;

  // ///Currently used data source in player.
  // BPDataSource? _bpDataSource;

  BPController(
    this.bpConfig, {
    // this.bpPlaylistConfig,
    BPDataSource? bpDataSource,
  });
}
