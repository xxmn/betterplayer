import 'package:better_player/src/configuration/better_player_drm_type.dart';

///Cfg of DRM used to protect data source
class BPDrmCfg {
  ///Type of DRM
  final BPDrmType? drmType;

  ///Parameter used only for token encrypted DRMs
  final String? token;

  ///Url of license server
  final String? licenseUrl;

  ///Url of fairplay certificate
  final String? certificateUrl;

  ///ClearKey json object, used only for ClearKey protection. Only support for Android.
  final String? clearKey;

  ///Additional headers send with auth request, used only for WIDEVINE DRM
  final Map<String, String>? headers;

  BPDrmCfg({this.drmType, this.token, this.licenseUrl, this.certificateUrl, this.headers, this.clearKey});
}
