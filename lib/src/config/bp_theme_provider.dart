import 'dart:io';
import 'package:better_player/src/defines/bp_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controls/bp_config_provider.dart';

final bpThemeProvider = Provider.autoDispose((ref) {
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
