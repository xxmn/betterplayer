import 'dart:async';
import 'package:better_player/src/native_player/np_create_provider.dart';
import 'package:better_player/src/native_player/platform_interface.dart';
import 'package:better_player/src/defines/np_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_data_source_provider.dart';

final npSetDataSourceProvider = StateNotifierProvider.autoDispose<NPDataSourceNotifier, bool>(
  (ref) {
    var npDataSource = ref.watch(npDataSourceProvider.select((v) => v.npDataSource));
    var textureId = ref.watch(npCreateProvider!.select((v) => v.textureId));
    return NPDataSourceNotifier(
      npDataSource: npDataSource,
      textureId: textureId,
    );
  },
);

class NPDataSourceNotifier extends StateNotifier<bool> {
  NPDataSourceNotifier({
    NPDataSource? npDataSource,
    int? textureId,
  }) : super(false) {
    if (npDataSource != null && textureId != null) {
      _setDataSource(npDataSource, textureId);
    }
  }

  Future<void> _setDataSource(NPDataSource npDataSource, int textureId) async {
    if (mounted) {
      await NativePlayerPlatform.instance.setDataSource(textureId, npDataSource);
      var _initializingCompleter = Completer<void>();
      _initializingCompleter.complete(null);

      // print("set data source for native player ok.");
      //set data source successed
      state = true;
    }
  }
}
