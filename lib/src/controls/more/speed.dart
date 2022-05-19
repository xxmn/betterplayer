import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'show_sheet.dart';
import 'text_style.dart';

void showSpeedChooserWidget(BuildContext context) {
  showSheet(
    [
      _SpeedRow(0.5),
      _SpeedRow(0.75),
      _SpeedRow(1.0),
      _SpeedRow(1.25),
      _SpeedRow(1.5),
      _SpeedRow(1.75),
      _SpeedRow(2.0),
    ],
    context,
  );
}

class _SpeedRow extends HookConsumerWidget {
  final double speedTo;
  const _SpeedRow(this.speedTo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BPMaterialClickableWidget(
      onTap: () {
        ref.read(npStatusProvider.notifier).setSpeed(speedTo);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: _Speed(speedTo),
      ),
    );
  }
}

class _Speed extends HookConsumerWidget {
  final double speedTo;
  const _Speed(this.speedTo, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var color = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowModalTextColor));
    var currentSpeed = ref.watch(npStatusProvider.select((v) => v.speed));
    final bool isSelected = currentSpeed == speedTo;
    return Row(
      children: [
        SizedBox(width: isSelected ? 8 : 16),
        Visibility(
            visible: isSelected,
            child: Icon(
              Icons.check_outlined,
              color: color,
            )),
        const SizedBox(width: 16),
        Text(
          "$speedTo x",
          style: getTextStyle(isSelected, color),
        )
      ],
    );
  }
}
