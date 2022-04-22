import 'package:better_player/better_player.dart';

class BPMockController extends BPController {
  BPMockController(
    BPCfg bpCfg, {
    BPPlaylistCfg bpPlaylistCfg = const BPPlaylistCfg(),
  }) : super(bpCfg, bpPlaylistCfg: bpPlaylistCfg);
}
