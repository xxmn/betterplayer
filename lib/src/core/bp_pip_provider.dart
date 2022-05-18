import 'package:hooks_riverpod/hooks_riverpod.dart';

///Check if picture in picture mode is supported in this device.
///
final bpPIPProvider = StateNotifierProvider.autoDispose<BPPIPNotifier, bool>(
  (ref) => BPPIPNotifier(),
);

class BPPIPNotifier extends StateNotifier<bool> {
  BPPIPNotifier() : super(false);

  Future<bool> isPictureInPictureSupported() async {
    return Future.value(false);
    // if (videoPlayerController == null) {
    //   throw StateError("The data source has not been initialized");
    // }

    // final bool isPipSupported =
    //     (await videoPlayerController!.isPictureInPictureSupported()) ?? false;

    // return isPipSupported && !_isFullScreen;
  }
}
