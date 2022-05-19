import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showSheet(List<Widget> children, BuildContext context) {
  Platform.isAndroid
      ? _showMaterialBottomSheet(children, context)
      : _showCupertinoModalBottomSheet(children, context);
}

void _showMaterialBottomSheet(List<Widget> children, BuildContext context) {
  showModalBottomSheet<void>(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return _Content(children);
    },
  );
}

void _showCupertinoModalBottomSheet(List<Widget> children, BuildContext context) {
  showCupertinoModalPopup<void>(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return _Content(children);
    },
  );
}

class _Content extends StatelessWidget {
  final List<Widget> children;
  const _Content(this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var color = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowModalColor));
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                /*shape: RoundedRectangleBorder(side: Bor,borderRadius: 24,)*/
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
              ),
              child: Column(children: children),
            );
          },
        ),
      ),
    );
  }
}
