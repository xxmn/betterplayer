import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListButtons extends HookConsumerWidget {
  const ListButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AbsorbPointer(
        absorbing: false,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
          color: Colors.blueAccent,
          iconSize: 28,
        ),
      ),
    );
  }
}
