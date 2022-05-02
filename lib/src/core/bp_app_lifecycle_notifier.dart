import 'package:flutter/material.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPAppLifecycleNotifier with ChangeNotifier {
  BPAppLifecycleNotifier();

  ///Current app lifecycle state.
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;
  AppLifecycleState get appLifecycleState => _appLifecycleState;

  ///Set current lifecycle state. If state is [AppLifecycleState.resumed] then
  ///player starts playing again. if lifecycle is in [AppLifecycleState.paused]
  ///state, then video playback will stop. If showNotification is set in data
  ///source or handleLifecycle is false then this logic will be ignored.
  void set appLifecycleState(AppLifecycleState appLifecycleState) {
    if (_appLifecycleState != appLifecycleState) {
      _appLifecycleState = appLifecycleState;
      notifyListeners();
    }
  }

  ///Defines flag which enables/disables lifecycle handling (pause on app closed,
  ///play on app resumed). Default value is true.
  final bool handleLifecycle = true;
}
