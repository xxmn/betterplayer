import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audio_video_progress_bar/defines.dart';
import 'package:better_player/src/defines/duration_range.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaterialProgressBar extends HookConsumerWidget {
  const MaterialProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var progress = ref.watch(npStatusProvider.select((v) => v.position ?? Duration.zero));
    var total = ref.watch(npStatusProvider.select((v) => v.duration ?? Duration.zero));
    var bufferedList = ref.watch(npStatusProvider.select((v) => v.buffered));
    return ProgressBar(
      progress: progress,
      // buffered: Duration(seconds: 15),
      buffered: _convertDurationRange(bufferedList),
      bufferedBarColor: Colors.lightBlue,
      timeLabelLocation: TimeLabelLocation.sides,
      timeLabelTextStyle: TextStyle(color: Colors.red),
      timeLabelTextStyle2: TextStyle(color: Colors.yellow),
      total: total,
      onSeek: (duration) {
        ref.read(npStatusProvider.notifier).seekToAndContinue(duration);
      },
    );
  }
}

List<List<Duration>>? _convertDurationRange(List<DurationRange>? bufferedList) {
  if (bufferedList == null) return null;
  return bufferedList
      .map(
        (buffered) => [buffered.start, buffered.end],
      )
      .toList();
}
