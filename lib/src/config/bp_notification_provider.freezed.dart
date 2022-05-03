// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_notification_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$_BPNotificationConfig {
  ///Is player controls notification enabled
  bool? get isShow => throw _privateConstructorUsedError;

  ///Title of the given data source, used in controls notification
  String? get title => throw _privateConstructorUsedError;

  ///Author of the given data source, used in controls notification
  String? get author => throw _privateConstructorUsedError;

  ///Image of the video, used in controls notification
  String? get imageUrl => throw _privateConstructorUsedError;

  ///Name of the notification channel. Used only in Android.
  String? get channelName => throw _privateConstructorUsedError;

  ///Name of activity used to open application from notification. Used only
  ///in Android.
  String? get activityName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$BPNotificationConfigCopyWith<_BPNotificationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$BPNotificationConfigCopyWith<$Res> {
  factory _$BPNotificationConfigCopyWith(_BPNotificationConfig value,
          $Res Function(_BPNotificationConfig) then) =
      __$BPNotificationConfigCopyWithImpl<$Res>;
  $Res call(
      {bool? isShow,
      String? title,
      String? author,
      String? imageUrl,
      String? channelName,
      String? activityName});
}

/// @nodoc
class __$BPNotificationConfigCopyWithImpl<$Res>
    implements _$BPNotificationConfigCopyWith<$Res> {
  __$BPNotificationConfigCopyWithImpl(this._value, this._then);

  final _BPNotificationConfig _value;
  // ignore: unused_field
  final $Res Function(_BPNotificationConfig) _then;

  @override
  $Res call({
    Object? isShow = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? imageUrl = freezed,
    Object? channelName = freezed,
    Object? activityName = freezed,
  }) {
    return _then(_value.copyWith(
      isShow: isShow == freezed
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String?,
      activityName: activityName == freezed
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$_BPNotificationConfigCopyWith<$Res>
    implements _$BPNotificationConfigCopyWith<$Res> {
  factory _$_BPNotificationConfigCopyWith(__BPNotificationConfig value,
          $Res Function(__BPNotificationConfig) then) =
      __$_BPNotificationConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool? isShow,
      String? title,
      String? author,
      String? imageUrl,
      String? channelName,
      String? activityName});
}

/// @nodoc
class __$_BPNotificationConfigCopyWithImpl<$Res>
    extends __$BPNotificationConfigCopyWithImpl<$Res>
    implements _$_BPNotificationConfigCopyWith<$Res> {
  __$_BPNotificationConfigCopyWithImpl(__BPNotificationConfig _value,
      $Res Function(__BPNotificationConfig) _then)
      : super(_value, (v) => _then(v as __BPNotificationConfig));

  @override
  __BPNotificationConfig get _value => super._value as __BPNotificationConfig;

  @override
  $Res call({
    Object? isShow = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? imageUrl = freezed,
    Object? channelName = freezed,
    Object? activityName = freezed,
  }) {
    return _then(__BPNotificationConfig(
      isShow: isShow == freezed
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String?,
      activityName: activityName == freezed
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$__BPNotificationConfig
    with DiagnosticableTreeMixin
    implements __BPNotificationConfig {
  const _$__BPNotificationConfig(
      {this.isShow = false,
      this.title,
      this.author,
      this.imageUrl,
      this.channelName,
      this.activityName});

  ///Is player controls notification enabled
  @override
  @JsonKey()
  final bool? isShow;

  ///Title of the given data source, used in controls notification
  @override
  final String? title;

  ///Author of the given data source, used in controls notification
  @override
  final String? author;

  ///Image of the video, used in controls notification
  @override
  final String? imageUrl;

  ///Name of the notification channel. Used only in Android.
  @override
  final String? channelName;

  ///Name of activity used to open application from notification. Used only
  ///in Android.
  @override
  final String? activityName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_BPNotificationConfig(isShow: $isShow, title: $title, author: $author, imageUrl: $imageUrl, channelName: $channelName, activityName: $activityName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_BPNotificationConfig'))
      ..add(DiagnosticsProperty('isShow', isShow))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('channelName', channelName))
      ..add(DiagnosticsProperty('activityName', activityName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __BPNotificationConfig &&
            const DeepCollectionEquality().equals(other.isShow, isShow) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality()
                .equals(other.channelName, channelName) &&
            const DeepCollectionEquality()
                .equals(other.activityName, activityName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isShow),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(channelName),
      const DeepCollectionEquality().hash(activityName));

  @JsonKey(ignore: true)
  @override
  _$_BPNotificationConfigCopyWith<__BPNotificationConfig> get copyWith =>
      __$_BPNotificationConfigCopyWithImpl<__BPNotificationConfig>(
          this, _$identity);
}

abstract class __BPNotificationConfig implements _BPNotificationConfig {
  const factory __BPNotificationConfig(
      {final bool? isShow,
      final String? title,
      final String? author,
      final String? imageUrl,
      final String? channelName,
      final String? activityName}) = _$__BPNotificationConfig;

  @override

  ///Is player controls notification enabled
  bool? get isShow => throw _privateConstructorUsedError;
  @override

  ///Title of the given data source, used in controls notification
  String? get title => throw _privateConstructorUsedError;
  @override

  ///Author of the given data source, used in controls notification
  String? get author => throw _privateConstructorUsedError;
  @override

  ///Image of the video, used in controls notification
  String? get imageUrl => throw _privateConstructorUsedError;
  @override

  ///Name of the notification channel. Used only in Android.
  String? get channelName => throw _privateConstructorUsedError;
  @override

  ///Name of activity used to open application from notification. Used only
  ///in Android.
  String? get activityName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$_BPNotificationConfigCopyWith<__BPNotificationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
