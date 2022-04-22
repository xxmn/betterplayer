import 'package:better_player/src/configuration/better_player_event_type.dart';

///Event that happens in player. It can be used to determine current player state
///on higher layer.
class BPEvent {
  final BPEventType bpEventType;
  final Map<String, dynamic>? parameters;

  BPEvent(this.bpEventType, {this.parameters});
}
