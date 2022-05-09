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
mixin _$BPNtConfig {
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
  $BPNtConfigCopyWith<BPNtConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPNtConfigCopyWith<$Res> {
  factory $BPNtConfigCopyWith(
          BPNtConfig value, $Res Function(BPNtConfig) then) =
      _$BPNtConfigCopyWithImpl<$Res>;
  $Res call(
      {bool? isShow,
      String? title,
      String? author,
      String? imageUrl,
      String? channelName,
      String? activityName});
}

/// @nodoc
class _$BPNtConfigCopyWithImpl<$Res> implements $BPNtConfigCopyWith<$Res> {
  _$BPNtConfigCopyWithImpl(this._value, this._then);

  final BPNtConfig _value;
  // ignore: unused_field
  final $Res Function(BPNtConfig) _then;

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
abstract class _$BPNtConfigCopyWith<$Res> implements $BPNtConfigCopyWith<$Res> {
  factory _$BPNtConfigCopyWith(
          _BPNtConfig value, $Res Function(_BPNtConfig) then) =
      __$BPNtConfigCopyWithImpl<$Res>;
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
class __$BPNtConfigCopyWithImpl<$Res> extends _$BPNtConfigCopyWithImpl<$Res>
    implements _$BPNtConfigCopyWith<$Res> {
  __$BPNtConfigCopyWithImpl(
      _BPNtConfig _value, $Res Function(_BPNtConfig) _then)
      : super(_value, (v) => _then(v as _BPNtConfig));

  @override
  _BPNtConfig get _value => super._value as _BPNtConfig;

  @override
  $Res call({
    Object? isShow = freezed,
    Object? title = freezed,
    Object? author = freezed,
    Object? imageUrl = freezed,
    Object? channelName = freezed,
    Object? activityName = freezed,
  }) {
    return _then(_BPNtConfig(
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

class _$_BPNtConfig with DiagnosticableTreeMixin implements _BPNtConfig {
  const _$_BPNtConfig(
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
    return 'BPNtConfig(isShow: $isShow, title: $title, author: $author, imageUrl: $imageUrl, channelName: $channelName, activityName: $activityName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BPNtConfig'))
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
            other is _BPNtConfig &&
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
  _$BPNtConfigCopyWith<_BPNtConfig> get copyWith =>
      __$BPNtConfigCopyWithImpl<_BPNtConfig>(this, _$identity);
}

abstract class _BPNtConfig implements BPNtConfig {
  const factory _BPNtConfig(
      {final bool? isShow,
      final String? title,
      final String? author,
      final String? imageUrl,
      final String? channelName,
      final String? activityName}) = _$_BPNtConfig;

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
  _$BPNtConfigCopyWith<_BPNtConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
