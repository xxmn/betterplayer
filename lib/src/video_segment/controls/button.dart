import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyButton extends HookConsumerWidget {
  final bool isEnable;
  final Widget label;
  final void Function() onPressed;
  const MyButton({
    required this.isEnable,
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AbsorbPointer(
      absorbing: !isEnable,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: label,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isEnable ? Colors.blueAccent : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
