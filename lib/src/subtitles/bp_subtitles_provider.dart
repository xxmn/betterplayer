// Flutter imports:
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'bp_subtitles_provider.freezed.dart';

late final StateNotifierProvider<BPSubtitlesNotifier, BPSubtitlesConfig> bpSubtitlesProvider;

void initBpSubtitlesProvider(BPSubtitlesConfig subtitlesConfig) {
  bpSubtitlesProvider = StateNotifierProvider<BPSubtitlesNotifier, BPSubtitlesConfig>(
    (ref) => BPSubtitlesNotifier(
      bpSubtitlesConfig: subtitlesConfig,
    ),
  );
}

class BPSubtitlesNotifier extends StateNotifier<BPSubtitlesConfig> {
  BPSubtitlesNotifier({
    BPSubtitlesConfig? bpSubtitlesConfig,
  }) : super(bpSubtitlesConfig ?? BPSubtitlesConfig());
}

///Cfg of subtitles - colors/padding/font. Used in
///BPConfiguration.
///
@freezed
class BPSubtitlesConfig with _$BPSubtitlesConfig {
  const factory BPSubtitlesConfig({
    ///Subtitle font size
    @Default(14) double fontSize,

    ///Subtitle font color
    @Default(Colors.white) Color fontColor,

    ///Enable outline (border) of the text
    @Default(true) bool outlineEnabled,

    ///Color of the outline stroke
    @Default(Colors.black) Color outlineColor,

    ///Outline stroke size
    @Default(2.0) double outlineSize,

    ///Font family of the subtitle
    @Default("Roboto") String fontFamily,

    ///Left padding of the subtitle
    @Default(8.0) double leftPadding,

    ///Right padding of the subtitle
    @Default(8.0) double rightPadding,

    ///Bottom padding of the subtitle
    @Default(20.0) double bottomPadding,

    ///Alignment of the subtitle
    @Default(Alignment.center) Alignment alignment,

    ///Background color of the subtitle
    @Default(Colors.transparent) Color backgroundColor,
  }) = _BPSubtitlesConfig;
}
