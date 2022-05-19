import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_hit_area_clickable_button.dart';
import 'package:better_player/src/controls/show_controls_provider.dart';
import 'package:better_player/src/locked/bp_locked_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LockedButton extends HookConsumerWidget {
  const LockedButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controlsVisible = ref.watch(bpShowControlsProvider);

    return Container(
      child: Center(
        child: AnimatedOpacity(
          opacity: controlsVisible ? 0.7 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.black54,
              ),
              child: Consumer(
                builder: (ctx, ref2, child) {
                  var color = ref2.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
                  var isLocked = ref2.watch(bpLockedProvider);
                  return isLocked ? _LockedButton(color) : _UnLockedButton(color);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LockedButton extends HookConsumerWidget {
  final Color iconsColor;
  const _LockedButton(this.iconsColor, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HitAreaClickableButton(
      onClicked: () {
        ref.read(bpLockedProvider.notifier).unlock();
      },
      icon: Icon(
        FontAwesomeIcons.lock,
        size: 24,
        color: iconsColor,
      ),
    );
  }
}

class _UnLockedButton extends HookConsumerWidget {
  final Color iconsColor;
  const _UnLockedButton(this.iconsColor, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HitAreaClickableButton(
      onClicked: () {
        ref.read(bpLockedProvider.notifier).lock();
      },
      icon: Icon(
        FontAwesomeIcons.unlock,
        size: 24,
        color: iconsColor,
      ),
    );
  }
}
