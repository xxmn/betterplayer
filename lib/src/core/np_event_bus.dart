import 'package:event_bus/event_bus.dart';

class NpEventBus extends EventBus {
  NpEventBus._privateConstructor();

  static final NpEventBus _instance = NpEventBus._privateConstructor();

  factory NpEventBus() => _instance;
}
