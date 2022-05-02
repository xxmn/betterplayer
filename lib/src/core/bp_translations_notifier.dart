import 'package:better_player/src/configuration/better_player_translations.dart';
import 'package:better_player/src/utils/better_player_utils.dart';
import 'package:flutter/material.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class BPTranslationsNotifier with ChangeNotifier {
  Locale? _locale;
  late BPTranslations _trans;

  BPTranslationsNotifier({Locale? locale = const Locale("en", "US")}) {
    _locale = locale;
    _trans = _getTranslations(_locale);
  }

  ///Setup translations for given locale. In normal use cases it shouldn't be
  ///called manually.
  void setTranslations(Locale? locale) {
    if (_locale?.languageCode != locale?.languageCode) {
      _trans = _getTranslations(locale);
      notifyListeners();
    }
  }

  BPTranslations get translations => _trans;

  ///Setup default translations for selected user locale. These translations
  ///are pre-build in.
  BPTranslations _getTranslations(Locale? locale) {
    var languageCode = locale?.languageCode;
    switch (languageCode) {
      case "pl":
        return BPTranslations.polish();
      case "zh":
        return BPTranslations.chinese();
      case "hi":
        return BPTranslations.hindi();
      case "tr":
        return BPTranslations.turkish();
      case "vi":
        return BPTranslations.vietnamese();
      case "es":
        return BPTranslations.spanish();
      default:
        BPUtils.log("Locale is null. Couldn't setup translations, local: ${locale?.languageCode}");
        return BPTranslations();
    }
  }
}
