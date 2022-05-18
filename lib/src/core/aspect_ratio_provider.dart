import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 视频比例
///
final bpAspectRatioProvider = Provider.autoDispose<double>((ref) {
  var aspectRatio = ref.watch(bpConfigProvider!.select((v) => v.aspectRatio));
  if (aspectRatio != null) return aspectRatio;
  return ref.watch(npStatusProvider.select((v) => v.aspectRatio));
});
