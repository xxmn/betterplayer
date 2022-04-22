import 'package:better_player/better_player.dart';

class BPMockController extends BPController {
  BPMockController(
    BPConfiguration betterPlayerConfiguration, {
    BPPlaylistConfiguration betterPlayerPlaylistConfiguration = const BPPlaylistConfiguration(),
  }) : super(betterPlayerConfiguration, betterPlayerPlaylistConfiguration: betterPlayerPlaylistConfiguration);
}
