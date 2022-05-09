import 'platform_interface.dart';

final NativePlayerPlatform npPlatform = NativePlayerPlatform.instance
// This will clear all open videos on the platform when a full restart is
// performed.
  ..init();
