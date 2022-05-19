import 'dart:async';
import 'package:better_player/src/config/bp_buffering_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/native_player/np_create_provider.freezed.dart';

AutoDisposeStateNotifierProvider<_Notifier, CreateStatus>? npCreateProvider;

void initNpCreateProvider({BPBufferingConfig? bufferingConfig}) {
  if (npCreateProvider == null) {
    npCreateProvider = StateNotifierProvider.autoDispose<_Notifier, CreateStatus>((ref) {
      var bConfig = bufferingConfig ?? const BPBufferingConfig();
      return _Notifier(bufferingConfig: bConfig);
    });
  }
}

void disposeNpCreateProvider() => npCreateProvider = null;

class _Notifier extends StateNotifier<CreateStatus> {
  _Notifier({
    required BPBufferingConfig bufferingConfig,
    bool autoCreate = true,
  }) : super(CreateStatus()) {
    _create(bufferingConfig).then((v) => state = v);
  }

  @override
  Future<void> dispose() async {
    if (state.textureId != null) {
      // print("dispose native player: state.textureId: ${state.textureId}");
      await npPlatform.dispose(state.textureId);
    }
    super.dispose();
  }
}

Future<CreateStatus> _create(BPBufferingConfig bConfig) async {
  /// Attempts to open the given [dataSource] and load metadata about the video.
  var _textureId = await npPlatform.create(bufferingConfig: bConfig);

  final Completer<void> _creatingCompleter = Completer<void>();
  _creatingCompleter.complete(null);

  // print("create native player ok.");

  return CreateStatus(isCreated: true, textureId: _textureId);
}

@freezed
class CreateStatus with _$CreateStatus {
  const factory CreateStatus({
    int? textureId,
    @Default(false) bool isCreated,
  }) = _CreateStatus;
}
