// Flutter imports:
import 'package:better_player/src/subtitles/bp_source.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/subtitles/bp_config.freezed.dart';

///Cfg of subtitles - colors/padding/font. Used in
///BPConfiguration.
///
@freezed
class BPSubtitlesConfig with _$BPSubtitlesConfig {
  const factory BPSubtitlesConfig({
    ///Subtitles configuration
    List<BPSubtitlesSource>? subtitlesSources,

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
