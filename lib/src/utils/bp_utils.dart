// Flutter imports:
import 'package:better_player/src/defines/bp_drm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BPUtils {
  static String formatBitrate(int bitrate) {
    if (bitrate < 1000) {
      return "$bitrate bit/s";
    }
    if (bitrate < 1000000) {
      final kbit = (bitrate / 1000).floor();
      return "~$kbit KBit/s";
    }
    final mbit = (bitrate / 1000000).floor();
    return "~$mbit MBit/s";
  }

  static String formatMilliSecond(int ms) {
    return formatDuration(Duration(milliseconds: ms));
  }

  static String formatDurationMs(Duration position) {
    var f = _formatDuration(position);
    return "$f.${position.inMilliseconds % 1000}";
  }

  static String formatDuration(Duration position) {
    var ms = position.inMilliseconds + 500;
    return _formatDuration(Duration(milliseconds: ms));
  }

  static String _formatDuration(Duration position) {
    //四舍五入
    final ms = position.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

    return formattedTime;
  }

  static double calculateAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return width > height ? width / height : height / width;
  }

  static void log(String logMessage) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(logMessage);
    }
  }
}

///Build headers map that will be used to setup video player controller. Apply
///DRM headers if available.
///static const String _authorizationHeader = "Authorization";
Map<String, String?> getHeaders(Map<String, String>? dsheaders, BPDrmConfig? drmConfig) {
  final headers = dsheaders ?? {};
  if (drmConfig?.drmType == BPDrmType.token && drmConfig?.token != null) {
    headers["Authorization"] = drmConfig!.token!;
  }
  return headers;
}
