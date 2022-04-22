import 'package:better_player/src/core/better_player_controller.dart';
import 'package:flutter/material.dart';

///Widget which is used to inherit BPController through widget tree.
class BPControllerProvider extends InheritedWidget {
  const BPControllerProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final BPController controller;

  static BPControllerProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BPControllerProvider>()!;
  }

  @override
  bool updateShouldNotify(BPControllerProvider old) => controller != old.controller;
}
