import 'dart:async';
import 'package:better_player/src/config/bp_buffering_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'np_platform_instance.dart';

StateNotifierProvider<NPCreateNotifier, CreateStatus>? npCreateProvider;

void initNpCreateProvider({BPBufferingConfig? bufferingConfig}) {
  if (npCreateProvider == null) {
    npCreateProvider = StateNotifierProvider<NPCreateNotifier, CreateStatus>((ref) {
      var bConfig = bufferingConfig ?? const BPBufferingConfig();
      return NPCreateNotifier(bufferingConfig: bConfig);
    });
  }
}

void disposeNpCreateProvider() => npCreateProvider = null;

class NPCreateNotifier extends StateNotifier<CreateStatus> {
  NPCreateNotifier({
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

  print("create native player ok.");

  return CreateStatus(isCreated: true, textureId: _textureId);
}

class CreateStatus {
  CreateStatus({
    this.isCreated = false,
    this.textureId,
  });
  final int? textureId;
  final bool isCreated;

  CreateStatus copyWith({int? textureId, bool? isCreated}) {
    return CreateStatus(
      isCreated: isCreated ?? this.isCreated,
      textureId: textureId ?? this.textureId,
    );
  }
}
