import 'dart:convert';
import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'better_player_subtitle.dart';

class BPSubtitlesFactory {
  static Future<List<BPSubtitle>> parseSubtitles(BPSubtitlesSource source) async {
    switch (source.type) {
      case BPSubtitlesSourceType.file:
        return _parseSubtitlesFromFile(source);
      case BPSubtitlesSourceType.network:
        return _parseSubtitlesFromNetwork(source);
      case BPSubtitlesSourceType.memory:
        return _parseSubtitlesFromMemory(source);
      default:
        return [];
    }
  }

  static Future<List<BPSubtitle>> _parseSubtitlesFromFile(BPSubtitlesSource source) async {
    try {
      final List<BPSubtitle> subtitles = [];
      for (final String? url in source.urls!) {
        final file = File(url!);
        if (file.existsSync()) {
          final String fileContent = await file.readAsString();
          final subtitlesCache = _parseString(fileContent);
          subtitles.addAll(subtitlesCache);
        } else {
          BPUtils.log("$url doesn't exist!");
        }
      }
      return subtitles;
    } catch (exception) {
      BPUtils.log("Failed to read subtitles from file: $exception");
    }
    return [];
  }

  static Future<List<BPSubtitle>> _parseSubtitlesFromNetwork(BPSubtitlesSource source) async {
    try {
      final client = HttpClient();
      final List<BPSubtitle> subtitles = [];
      for (final String? url in source.urls!) {
        final request = await client.getUrl(Uri.parse(url!));
        source.headers?.keys.forEach((key) {
          final value = source.headers![key];
          if (value != null) {
            request.headers.add(key, value);
          }
        });
        final response = await request.close();
        final data = await response.transform(const Utf8Decoder()).join();
        final cacheList = _parseString(data);
        subtitles.addAll(cacheList);
      }
      client.close();

      BPUtils.log("Parsed total subtitles: ${subtitles.length}");
      return subtitles;
    } catch (exception) {
      BPUtils.log("Failed to read subtitles from network: $exception");
    }
    return [];
  }

  static List<BPSubtitle> _parseSubtitlesFromMemory(BPSubtitlesSource source) {
    try {
      return _parseString(source.content!);
    } catch (exception) {
      BPUtils.log("Failed to read subtitles from memory: $exception");
    }
    return [];
  }

  static List<BPSubtitle> _parseString(String value) {
    List<String> components = value.split('\r\n\r\n');
    if (components.length == 1) {
      components = value.split('\n\n');
    }

    // Skip parsing files with no cues
    if (components.length == 1) {
      return [];
    }

    final List<BPSubtitle> subtitlesObj = [];

    final bool isWebVTT = components.contains("WEBVTT");
    for (final component in components) {
      if (component.isEmpty) {
        continue;
      }
      final subtitle = BPSubtitle(component, isWebVTT);
      if (subtitle.start != null && subtitle.end != null && subtitle.texts != null) {
        subtitlesObj.add(subtitle);
      }
    }

    return subtitlesObj;
  }
}
