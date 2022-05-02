import 'package:event_bus/event_bus.dart';

class BpEventBus extends EventBus {
  BpEventBus._privateConstructor();

  static final BpEventBus _instance = BpEventBus._privateConstructor();

  factory BpEventBus() => _instance;
}
