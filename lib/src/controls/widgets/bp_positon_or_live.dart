import 'package:better_player/src/config/bp_controls_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:better_player/src/core/bp_playing_status_provider.dart';
import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositonOrLive extends HookConsumerWidget {
  const PositonOrLive({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isLiveStream = ref.watch(bpDataSourceProvider.select((v) => v?.isLiveStream ?? false));
    var enableProgressText = ref.watch(bpControlsProvider.select((v) => v.enableProgressText));
    if (isLiveStream)
      return LiveText();
    else
      return enableProgressText ? Expanded(child: PositionText()) : const SizedBox();
  }
}

class LiveText extends HookConsumerWidget {
  const LiveText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsLive = ref.watch(bpTranslationsProvider.select((v) => v.controlsLive));
    var liveTextColor = ref.watch(bpControlsProvider.select((v) => v.liveTextColor));
    return Text(
      controlsLive,
      style: TextStyle(color: liveTextColor, fontWeight: FontWeight.bold),
    );
  }
}

class PositionText extends HookConsumerWidget {
  const PositionText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var position = ref.watch(bpPlayingStatusProvider.select((v) => v.position));
    var duration = ref.watch(bpDataSourceProvider.select((v) => v?.duration ?? Duration.zero));
    var enablePlayPause = ref.watch(bpControlsProvider.select((v) => v.enablePlayPause));
    var textColor = ref.watch(bpControlsProvider.select((v) => v.textColor));

    return Padding(
      padding: enablePlayPause
          ? const EdgeInsets.only(right: 24)
          : const EdgeInsets.symmetric(horizontal: 22),
      child: RichText(
        text: TextSpan(
            text: BPUtils.formatDuration(position),
            style: TextStyle(
              fontSize: 10.0,
              color: textColor,
              decoration: TextDecoration.none,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' / ${BPUtils.formatDuration(duration)}',
                style: TextStyle(
                  fontSize: 10.0,
                  color: textColor,
                  decoration: TextDecoration.none,
                ),
              )
            ]),
      ),
    );
  }
}