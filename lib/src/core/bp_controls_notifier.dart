import 'package:better_player/src/configuration/better_player_controls_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPControlsNotifier with ChangeNotifier {
  BPControlsNotifier();

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool _controlsEnabled = true;

  ///Flag which determines if controls (UI interface) is shown. When false,
  ///UI won't be shown (show only player surface).
  bool get controlsEnabled => _controlsEnabled;

  ///Enable/disable controls (when enabled = false, controls will be always hidden)
  void setControlsEnabled(bool enabled) {
    if (_controlsEnabled != enabled) {
      _controlsEnabled = enabled;
      notifyListeners();
    }
  }

  ///Are controls always visible
  bool _controlsAlwaysVisible = false;

  ///Are controls always visible
  bool get controlsAlwaysVisible => _controlsAlwaysVisible;

  ///Setup controls always visible mode
  void setControlsAlwaysVisible(bool controlsAlwaysVisible) {
    if (_controlsAlwaysVisible != controlsAlwaysVisible) {
      _controlsAlwaysVisible = controlsAlwaysVisible;
      notifyListeners();
    }
  }



  ///Are controls visible
  bool _controlsVisible = false;

  ///Are controls visible
  bool get controlsVisible => _controlsVisible;

  ///Show or hide controls manually
  void setControlsVisibility(bool isVisible) {
    if (_controlsVisible != isVisible) {
      _controlsVisible = isVisible;
      notifyListeners();
    }
  }

  ///Internal method, used to trigger CONTROLS_VISIBLE or CONTROLS_HIDDEN event
  ///once controls state changed.
  void toggleControlsVisibility() {
    _controlsVisible = !_controlsVisible;
    notifyListeners();
  }

  ///Was controls enabled before Picture in Picture opened.
  // bool _wasControlsEnabledBeforePiP = false;

  ///Controls configuration
  late BPControlsCfg _bpControlsCfg;
  BPControlsCfg get bpControlsCfg()=> _bpControlsCfg;
  /// Sets the new [betterPlayerControlsConfiguration] instance in the
  /// controller.
  void setBetterPlayerControlsConfiguration(
      BetterPlayerControlsConfiguration betterPlayerControlsConfiguration) {
    this._betterPlayerControlsConfiguration = betterPlayerControlsConfiguration;
  }


}
