import 'dart:io';
import 'package:better_player/src/types/bp_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_controls_provider.dart';

final bpThemeProvider = Provider((ref) {
  var playerTheme = ref.watch(bpControlsConfigProvider!.select((v) => v.playerTheme));

  if (playerTheme == null) {
    if (Platform.isAndroid) {
      playerTheme = BPTheme.material;
    } else {
      playerTheme = BPTheme.cupertino;
    }
  }
  return playerTheme;
});
