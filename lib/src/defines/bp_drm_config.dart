///Config of DRM used to protect data source
class BPDrmConfig {
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

  BPDrmConfig(
      {this.drmType,
      this.token,
      this.licenseUrl,
      this.certificateUrl,
      this.headers,
      this.clearKey});
}

///Types of available DRM's
///token -> supported for both iOS/Android
///widevine -> supported only for Android
///fairplay -> suppoted only for iOS
///clearKey -> supported only for Android
enum BPDrmType { token, widevine, fairplay, clearKey }
