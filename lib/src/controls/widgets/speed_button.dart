import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SpeedButton extends StatefulHookConsumerWidget {
  const SpeedButton({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpeedButtonState();
}

class _SpeedButtonState extends ConsumerState<SpeedButton> {
  final List<double> playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  int playbackSpeedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var speed = ref.watch(npStatusProvider.select((v) => v.speed));
    playbackSpeedIndex = playbackSpeeds.indexOf(speed);
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.timer),
          color: Colors.white,
          onPressed: () => _cyclePlaybackSpeed(ref.read(npStatusProvider.notifier).setSpeed),
        ),
        Positioned(
          bottom: 7,
          right: 3,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(1),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 2,
              ),
              child: Text(
                '${speed}x',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _cyclePlaybackSpeed(Future<void> Function(double) setSpeed) async {
    playbackSpeedIndex++;
    if (playbackSpeedIndex >= playbackSpeeds.length) {
      playbackSpeedIndex = 0;
    }
    var speed = playbackSpeeds.elementAt(playbackSpeedIndex);
    return await setSpeed(speed);
  }
}
