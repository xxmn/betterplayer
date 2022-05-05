import 'dart:ui';

import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final StateProvider<Locale> bpLocaleProvider;
late final Provider<BPTranslations> bpTranslationsProvider;

void initBpLocaleProvider(BuildContext context) {
  bpLocaleProvider = StateProvider((ref) {
    //Default locale
    var locale = const Locale("en", "US");
    try {
      locale = Localizations.localeOf(context);
    } catch (exception) {
      BPUtils.log(exception.toString());
    }
    return locale;
  });
}

void initBpTranslationsProvider() {
  bpTranslationsProvider = Provider(
    (ref) {
      var locale = ref.watch(bpLocaleProvider);
      return getDefaultTranslations(locale);
    },
  );
}

///Class used to hold translations for all features within Better Player

class BPTranslations {
  final String languageCode;
  final String generalDefaultError;
  final String generalNone;
  final String generalDefault;
  final String generalRetry;
  final String playlistLoadingNextVideo;
  final String controlsLive;
  final String controlsNextVideoIn;
  final String overflowMenuPlaybackSpeed;
  final String overflowMenuSubtitles;
  final String overflowMenuQuality;
  final String overflowMenuAudioTracks;
  final String qualityAuto;

  BPTranslations(
      {this.languageCode = "en",
      this.generalDefaultError = "Video can't be played",
      this.generalNone = "None",
      this.generalDefault = "Default",
      this.generalRetry = "Retry",
      this.playlistLoadingNextVideo = "Loading next video",
      this.controlsLive = "LIVE",
      this.controlsNextVideoIn = "Next video in",
      this.overflowMenuPlaybackSpeed = "Playback speed",
      this.overflowMenuSubtitles = "Subtitles",
      this.overflowMenuQuality = "Quality",
      this.overflowMenuAudioTracks = "Audio",
      this.qualityAuto = "Auto"});

  factory BPTranslations.polish() => BPTranslations(
        languageCode: "pl",
        generalDefaultError: "Video nie może zostać odtworzone",
        generalNone: "Brak",
        generalDefault: "Domyślne",
        generalRetry: "Spróbuj ponownie",
        playlistLoadingNextVideo: "Ładowanie następnego filmu",
        controlsNextVideoIn: "Następne video za",
        overflowMenuPlaybackSpeed: "Szybkość odtwarzania",
        overflowMenuSubtitles: "Napisy",
        overflowMenuQuality: "Jakość",
        overflowMenuAudioTracks: "Dźwięk",
        qualityAuto: "Automatycznie",
      );

  factory BPTranslations.chinese() => BPTranslations(
        languageCode: "zh",
        generalDefaultError: "无法播放视频",
        generalNone: "没有",
        generalDefault: "默认",
        generalRetry: "重試",
        playlistLoadingNextVideo: "正在加载下一个视频",
        controlsLive: "直播",
        controlsNextVideoIn: "下一部影片",
        overflowMenuPlaybackSpeed: "播放速度",
        overflowMenuSubtitles: "字幕",
        overflowMenuQuality: "质量",
        overflowMenuAudioTracks: "音訊",
        qualityAuto: "汽車",
      );

  factory BPTranslations.hindi() => BPTranslations(
        languageCode: "hi",
        generalDefaultError: "वीडियो नहीं चलाया जा सकता",
        generalNone: "कोई नहीं",
        generalDefault: "चूक",
        generalRetry: "पुनः प्रयास करें",
        playlistLoadingNextVideo: "अगला वीडियो लोड हो रहा है",
        controlsLive: "लाइव",
        controlsNextVideoIn: "में अगला वीडियो",
        overflowMenuPlaybackSpeed: "प्लेबैक की गति",
        overflowMenuSubtitles: "उपशीर्षक",
        overflowMenuQuality: "गुणवत्ता",
        overflowMenuAudioTracks: "ऑडियो",
        qualityAuto: "ऑटो",
      );

  factory BPTranslations.arabic() => BPTranslations(
        languageCode: "ar",
        generalDefaultError: "لا يمكن تشغيل الفيديو",
        generalNone: "لا يوجد",
        generalDefault: "الاساسي",
        generalRetry: "اعادة المحاوله",
        playlistLoadingNextVideo: "تحميل الفيديو التالي",
        controlsLive: "مباشر",
        controlsNextVideoIn: "الفيديو التالي في",
        overflowMenuPlaybackSpeed: "سرعة التشغيل",
        overflowMenuSubtitles: "الترجمة",
        overflowMenuQuality: "الجودة",
        overflowMenuAudioTracks: "الصوت",
        qualityAuto: "ऑटो",
      );

  factory BPTranslations.turkish() => BPTranslations(
      languageCode: "tr",
      generalDefaultError: "Video oynatılamıyor",
      generalNone: "Hiçbiri",
      generalDefault: "Varsayılan",
      generalRetry: "Tekrar Dene",
      playlistLoadingNextVideo: "Sonraki video yükleniyor",
      controlsLive: "CANLI",
      controlsNextVideoIn: "Sonraki video oynatılmadan",
      overflowMenuPlaybackSpeed: "Oynatma hızı",
      overflowMenuSubtitles: "Altyazı",
      overflowMenuQuality: "Kalite",
      overflowMenuAudioTracks: "Ses",
      qualityAuto: "Otomatik");

  factory BPTranslations.vietnamese() => BPTranslations(
        languageCode: "vi",
        generalDefaultError: "Video không thể phát bây giờ",
        generalNone: "Không có",
        generalDefault: "Mặc định",
        generalRetry: "Thử lại ngay",
        controlsLive: "Trực tiếp",
        playlistLoadingNextVideo: "Đang tải video tiếp theo",
        controlsNextVideoIn: "Video tiếp theo",
        overflowMenuPlaybackSpeed: "Tốc độ phát",
        overflowMenuSubtitles: "Phụ đề",
        overflowMenuQuality: "Chất lượng",
        overflowMenuAudioTracks: "Âm thanh",
        qualityAuto: "Tự động",
      );

  factory BPTranslations.spanish() => BPTranslations(
        languageCode: "es",
        generalDefaultError: "No se puede reproducir el video",
        generalNone: "Ninguno",
        generalDefault: "Por defecto",
        generalRetry: "Reintentar",
        controlsLive: "EN DIRECTO",
        playlistLoadingNextVideo: "Cargando siguiente video",
        controlsNextVideoIn: "Siguiente video en",
        overflowMenuPlaybackSpeed: "Velocidad",
        overflowMenuSubtitles: "Subtítulos",
        overflowMenuQuality: "Calidad",
        qualityAuto: "Automática",
      );
}

///Setup default translations for selected user locale. These translations
///are pre-build in.
BPTranslations getDefaultTranslations(Locale locale) {
  final String languageCode = locale.languageCode;
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
      return BPTranslations();
  }
}
