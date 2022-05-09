import 'dart:convert';
import 'dart:io';
import 'package:better_player/src/types/video_format.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:better_player/src/dash/better_player_dash_utils.dart';
import 'package:better_player/src/hls/bp_hls_utils.dart';

import 'bp_asms_data_holder.dart';

///Base helper class for ASMS parsing.
class BPAsmsUtils {
  static const String _hlsExtension = "m3u8";
  static const String _dashExtension = "mpd";

  static final HttpClient _httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 5);

  ///Check if given url is HLS / DASH-type data source.
  static bool isDataSourceAsms(String url) => isDataSourceHls(url) || isDataSourceDash(url);

  ///Check if given [bpDataSource] is HLS / DASH-type data source.
  static bool isDataSourceAsms2(String url, VideoFormat? videoFormat) =>
      (BPAsmsUtils.isDataSourceHls(url) || videoFormat == VideoFormat.hls) ||
      (BPAsmsUtils.isDataSourceDash(url) || videoFormat == VideoFormat.dash);

  ///Check if given url is HLS-type data source.
  static bool isDataSourceHls(String url) => url.contains(_hlsExtension);

  ///Check if given url is DASH-type data source.
  static bool isDataSourceDash(String url) => url.contains(_dashExtension);

  ///Parse playlist based on type of stream.
  static Future<BPAsmsDataHolder> parse(String data, String masterPlaylistUrl) async {
    return isDataSourceDash(masterPlaylistUrl)
        ? BPDashUtils.parse(data, masterPlaylistUrl)
        : BPHlsUtils.parse(data, masterPlaylistUrl);
  }

  ///Request data from given uri along with headers. May return null if resource
  ///is not available or on error.
  static Future<String?> getDataFromUrl(
    String url, [
    Map<String, String?>? headers,
  ]) async {
    try {
      final request = await _httpClient.getUrl(Uri.parse(url));
      if (headers != null) {
        headers.forEach((name, value) => request.headers.add(name, value!));
      }

      final response = await request.close();
      var data = "";
      await response.transform(const Utf8Decoder()).listen((content) {
        data += content.toString();
      }).asFuture<String?>();

      return data;
    } catch (exception) {
      BPUtils.log("GetDataFromUrl failed: $exception");
      return null;
    }
  }
}
