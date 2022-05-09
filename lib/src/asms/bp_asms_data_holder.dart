import 'package:better_player/src/asms/bp_asms_audio_track.dart';
import 'package:better_player/src/subtitles/bp_asms_subtitle.dart';
import 'package:better_player/src/asms/bp_asms_track.dart';

class BPAsmsDataHolder {
  List<BPAsmsTrack>? tracks;
  List<BPAsmsSubtitle>? subtitles;
  List<BPAsmsAudioTrack>? audios;

  BPAsmsDataHolder({this.tracks, this.subtitles, this.audios});
}
