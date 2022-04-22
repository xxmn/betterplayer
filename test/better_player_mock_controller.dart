import 'package:better_player/better_player.dart';

class BPMockController extends BPController {
  BPMockController(
    BPConfiguration bpConfiguration, {
    BPPlaylistConfiguration bpPlaylistConfiguration = const BPPlaylistConfiguration(),
  }) : super(bpConfiguration, bpPlaylistConfiguration: bpPlaylistConfiguration);
}
