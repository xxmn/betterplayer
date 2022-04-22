import 'package:better_player/src/asms/better_player_asms_audio_track.dart';
import 'package:better_player/src/asms/better_player_asms_subtitle.dart';
import 'package:better_player/src/asms/better_player_asms_track.dart';

class BPAsmsDataHolder {
  List<BPAsmsTrack>? tracks;
  List<BPAsmsSubtitle>? subtitles;
  List<BPAsmsAudioTrack>? audios;

  BPAsmsDataHolder({this.tracks, this.subtitles, this.audios});
}
