import 'package:better_player/src/core/bp_status_provider.dart';
import 'package:better_player/src/subtitles/bp_current_subtitle_providers.dart';
import 'package:better_player/src/subtitles/bp_subtitles_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BPSubtitlesDrawer extends HookConsumerWidget {
  const BPSubtitlesDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var config = ref.watch(bpSubtitlesConfigProvider!);
    var isVisible = ref.watch(bpIsVisibleProvider);
    var subtitle = ref.watch(bpCurrentSubtitleProvider);
    var subtitleTexts = subtitle?.texts ?? [];
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isVisible ? config.bottomPadding + 30 : config.bottomPadding,
          left: config.leftPadding,
          right: config.rightPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: subtitleTexts.map((text) => SubtitleText(subtitleText: text)).toList(),
        ),
      ),
    );
  }
}

class SubtitleText extends HookConsumerWidget {
  final String subtitleText;
  const SubtitleText({Key? key, required this.subtitleText}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var alignment = ref.watch(bpSubtitlesConfigProvider!.select((v) => v.alignment));
    return Row(children: [
      Expanded(
        child: Align(
          alignment: alignment,
          child: TextWithStroke(subtitleText),
        ),
      ),
    ]);
  }
}

class TextWithStroke extends HookConsumerWidget {
  final String subtitleText;
  const TextWithStroke(this.subtitleText, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var config = ref.watch(bpSubtitlesConfigProvider!);
    var _outerTextStyle = TextStyle(
      fontSize: config.fontSize,
      fontFamily: config.fontFamily,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.outlineSize
        ..color = config.outlineColor,
    );
    var _innerTextStyle = TextStyle(
      fontFamily: config.fontFamily,
      color: config.fontColor,
      fontSize: config.fontSize,
    );
    return Container(
      color: config.backgroundColor,
      child: Stack(
        children: [
          if (config.outlineEnabled)
            _buildHtmlWidget(subtitleText, _outerTextStyle)
          else
            const SizedBox(),
          _buildHtmlWidget(subtitleText, _innerTextStyle)
        ],
      ),
    );
  }
}

Widget _buildHtmlWidget(String text, TextStyle textStyle) {
  return HtmlWidget(
    text,
    textStyle: textStyle,
  );
}
