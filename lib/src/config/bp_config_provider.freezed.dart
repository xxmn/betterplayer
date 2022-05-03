// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bp_config_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BPConfig {
  /// When the video playback runs  into an error, you can build a custom
  /// error message.
  Widget Function(BuildContext, String?)? get errorBuilder =>
      throw _privateConstructorUsedError;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  Widget? get placeholder => throw _privateConstructorUsedError;

  /// Placeholder position of player stack. If false, then placeholder will be
  /// displayed on the bottom, so user need to hide it manually. Default is
  /// true.
  bool get placeholderOnTop => throw _privateConstructorUsedError;

  /// Should the placeholder be shown until play is pressed
  bool get showPlaceholderUntilPlay => throw _privateConstructorUsedError;

  /// A widget which is placed between the video and the controls
  Widget? get overlay =>
      throw _privateConstructorUsedError; // /// Defines a custom RoutePageBuilder for the fullscreen
// final BPRoutePageBuilder? routePageBuilder;
// /// Defines a event listener where video player events will be send
// final Function(BPEvent)? eventListener;
  ///Defines fit of the video, allows to fix video stretching, see possible
  ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
  BoxFit get fit => throw _privateConstructorUsedError;

  ///Flag which causes to player expand to fill all remaining space. Set to false
  ///to use minimum constraints
  bool get expandToFill => throw _privateConstructorUsedError;

  ///Defines rotation of the video in degrees. Default value is 0. Can be 0, 90, 180, 270.
  ///Angle will rotate only video box, controls will be in the same place.
// rotation <= 360 && rotation % 90 == 0
  int get rotation => throw _privateConstructorUsedError;

  ///Defines function which will react on player visibility changed
  dynamic Function(double)? get playerVisibilityChangedBehavior =>
      throw _privateConstructorUsedError; // ///Defines translations used in player. If null, then default english translations
// ///will be used.
// final List<BPTranslations>? translations;
  ///Defines flag which enabled/disabled auto dispose of
  ///[BPController] on [BetterPlayer] dispose. When it's true and
  ///[BPController] instance has been attached to [BetterPlayer] widget
  ///and dispose has been called on [BetterPlayer] instance, then
  ///[BPController] will be disposed.
  ///Default value is true.
  bool get autoDispose => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BPConfigCopyWith<BPConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BPConfigCopyWith<$Res> {
  factory $BPConfigCopyWith(BPConfig value, $Res Function(BPConfig) then) =
      _$BPConfigCopyWithImpl<$Res>;
  $Res call(
      {Widget Function(BuildContext, String?)? errorBuilder,
      Widget? placeholder,
      bool placeholderOnTop,
      bool showPlaceholderUntilPlay,
      Widget? overlay,
      BoxFit fit,
      bool expandToFill,
      int rotation,
      dynamic Function(double)? playerVisibilityChangedBehavior,
      bool autoDispose});
}

/// @nodoc
class _$BPConfigCopyWithImpl<$Res> implements $BPConfigCopyWith<$Res> {
  _$BPConfigCopyWithImpl(this._value, this._then);

  final BPConfig _value;
  // ignore: unused_field
  final $Res Function(BPConfig) _then;

  @override
  $Res call({
    Object? errorBuilder = freezed,
    Object? placeholder = freezed,
    Object? placeholderOnTop = freezed,
    Object? showPlaceholderUntilPlay = freezed,
    Object? overlay = freezed,
    Object? fit = freezed,
    Object? expandToFill = freezed,
    Object? rotation = freezed,
    Object? playerVisibilityChangedBehavior = freezed,
    Object? autoDispose = freezed,
  }) {
    return _then(_value.copyWith(
      errorBuilder: errorBuilder == freezed
          ? _value.errorBuilder
          : errorBuilder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, String?)?,
      placeholder: placeholder == freezed
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as Widget?,
      placeholderOnTop: placeholderOnTop == freezed
          ? _value.placeholderOnTop
          : placeholderOnTop // ignore: cast_nullable_to_non_nullable
              as bool,
      showPlaceholderUntilPlay: showPlaceholderUntilPlay == freezed
          ? _value.showPlaceholderUntilPlay
          : showPlaceholderUntilPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      overlay: overlay == freezed
          ? _value.overlay
          : overlay // ignore: cast_nullable_to_non_nullable
              as Widget?,
      fit: fit == freezed
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      expandToFill: expandToFill == freezed
          ? _value.expandToFill
          : expandToFill // ignore: cast_nullable_to_non_nullable
              as bool,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      playerVisibilityChangedBehavior: playerVisibilityChangedBehavior ==
              freezed
          ? _value.playerVisibilityChangedBehavior
          : playerVisibilityChangedBehavior // ignore: cast_nullable_to_non_nullable
              as dynamic Function(double)?,
      autoDispose: autoDispose == freezed
          ? _value.autoDispose
          : autoDispose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$BPConfigCopyWith<$Res> implements $BPConfigCopyWith<$Res> {
  factory _$BPConfigCopyWith(_BPConfig value, $Res Function(_BPConfig) then) =
      __$BPConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {Widget Function(BuildContext, String?)? errorBuilder,
      Widget? placeholder,
      bool placeholderOnTop,
      bool showPlaceholderUntilPlay,
      Widget? overlay,
      BoxFit fit,
      bool expandToFill,
      int rotation,
      dynamic Function(double)? playerVisibilityChangedBehavior,
      bool autoDispose});
}

/// @nodoc
class __$BPConfigCopyWithImpl<$Res> extends _$BPConfigCopyWithImpl<$Res>
    implements _$BPConfigCopyWith<$Res> {
  __$BPConfigCopyWithImpl(_BPConfig _value, $Res Function(_BPConfig) _then)
      : super(_value, (v) => _then(v as _BPConfig));

  @override
  _BPConfig get _value => super._value as _BPConfig;

  @override
  $Res call({
    Object? errorBuilder = freezed,
    Object? placeholder = freezed,
    Object? placeholderOnTop = freezed,
    Object? showPlaceholderUntilPlay = freezed,
    Object? overlay = freezed,
    Object? fit = freezed,
    Object? expandToFill = freezed,
    Object? rotation = freezed,
    Object? playerVisibilityChangedBehavior = freezed,
    Object? autoDispose = freezed,
  }) {
    return _then(_BPConfig(
      errorBuilder: errorBuilder == freezed
          ? _value.errorBuilder
          : errorBuilder // ignore: cast_nullable_to_non_nullable
              as Widget Function(BuildContext, String?)?,
      placeholder: placeholder == freezed
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as Widget?,
      placeholderOnTop: placeholderOnTop == freezed
          ? _value.placeholderOnTop
          : placeholderOnTop // ignore: cast_nullable_to_non_nullable
              as bool,
      showPlaceholderUntilPlay: showPlaceholderUntilPlay == freezed
          ? _value.showPlaceholderUntilPlay
          : showPlaceholderUntilPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      overlay: overlay == freezed
          ? _value.overlay
          : overlay // ignore: cast_nullable_to_non_nullable
              as Widget?,
      fit: fit == freezed
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as BoxFit,
      expandToFill: expandToFill == freezed
          ? _value.expandToFill
          : expandToFill // ignore: cast_nullable_to_non_nullable
              as bool,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      playerVisibilityChangedBehavior: playerVisibilityChangedBehavior ==
              freezed
          ? _value.playerVisibilityChangedBehavior
          : playerVisibilityChangedBehavior // ignore: cast_nullable_to_non_nullable
              as dynamic Function(double)?,
      autoDispose: autoDispose == freezed
          ? _value.autoDispose
          : autoDispose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BPConfig implements _BPConfig {
  const _$_BPConfig(
      {this.errorBuilder,
      this.placeholder,
      this.placeholderOnTop = true,
      this.showPlaceholderUntilPlay = false,
      this.overlay,
      this.fit = BoxFit.fill,
      this.expandToFill = true,
      this.rotation = 0,
      this.playerVisibilityChangedBehavior,
      this.autoDispose = true})
      : assert(rotation <= 360),
        assert(rotation % 90 == 0);

  /// When the video playback runs  into an error, you can build a custom
  /// error message.
  @override
  final Widget Function(BuildContext, String?)? errorBuilder;

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  @override
  final Widget? placeholder;

  /// Placeholder position of player stack. If false, then placeholder will be
  /// displayed on the bottom, so user need to hide it manually. Default is
  /// true.
  @override
  @JsonKey()
  final bool placeholderOnTop;

  /// Should the placeholder be shown until play is pressed
  @override
  @JsonKey()
  final bool showPlaceholderUntilPlay;

  /// A widget which is placed between the video and the controls
  @override
  final Widget? overlay;
// /// Defines a custom RoutePageBuilder for the fullscreen
// final BPRoutePageBuilder? routePageBuilder;
// /// Defines a event listener where video player events will be send
// final Function(BPEvent)? eventListener;
  ///Defines fit of the video, allows to fix video stretching, see possible
  ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
  @override
  @JsonKey()
  final BoxFit fit;

  ///Flag which causes to player expand to fill all remaining space. Set to false
  ///to use minimum constraints
  @override
  @JsonKey()
  final bool expandToFill;

  ///Defines rotation of the video in degrees. Default value is 0. Can be 0, 90, 180, 270.
  ///Angle will rotate only video box, controls will be in the same place.
// rotation <= 360 && rotation % 90 == 0
  @override
  @JsonKey()
  final int rotation;

  ///Defines function which will react on player visibility changed
  @override
  final dynamic Function(double)? playerVisibilityChangedBehavior;
// ///Defines translations used in player. If null, then default english translations
// ///will be used.
// final List<BPTranslations>? translations;
  ///Defines flag which enabled/disabled auto dispose of
  ///[BPController] on [BetterPlayer] dispose. When it's true and
  ///[BPController] instance has been attached to [BetterPlayer] widget
  ///and dispose has been called on [BetterPlayer] instance, then
  ///[BPController] will be disposed.
  ///Default value is true.
  @override
  @JsonKey()
  final bool autoDispose;

  @override
  String toString() {
    return 'BPConfig(errorBuilder: $errorBuilder, placeholder: $placeholder, placeholderOnTop: $placeholderOnTop, showPlaceholderUntilPlay: $showPlaceholderUntilPlay, overlay: $overlay, fit: $fit, expandToFill: $expandToFill, rotation: $rotation, playerVisibilityChangedBehavior: $playerVisibilityChangedBehavior, autoDispose: $autoDispose)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BPConfig &&
            (identical(other.errorBuilder, errorBuilder) ||
                other.errorBuilder == errorBuilder) &&
            const DeepCollectionEquality()
                .equals(other.placeholder, placeholder) &&
            const DeepCollectionEquality()
                .equals(other.placeholderOnTop, placeholderOnTop) &&
            const DeepCollectionEquality().equals(
                other.showPlaceholderUntilPlay, showPlaceholderUntilPlay) &&
            const DeepCollectionEquality().equals(other.overlay, overlay) &&
            const DeepCollectionEquality().equals(other.fit, fit) &&
            const DeepCollectionEquality()
                .equals(other.expandToFill, expandToFill) &&
            const DeepCollectionEquality().equals(other.rotation, rotation) &&
            (identical(other.playerVisibilityChangedBehavior,
                    playerVisibilityChangedBehavior) ||
                other.playerVisibilityChangedBehavior ==
                    playerVisibilityChangedBehavior) &&
            const DeepCollectionEquality()
                .equals(other.autoDispose, autoDispose));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      errorBuilder,
      const DeepCollectionEquality().hash(placeholder),
      const DeepCollectionEquality().hash(placeholderOnTop),
      const DeepCollectionEquality().hash(showPlaceholderUntilPlay),
      const DeepCollectionEquality().hash(overlay),
      const DeepCollectionEquality().hash(fit),
      const DeepCollectionEquality().hash(expandToFill),
      const DeepCollectionEquality().hash(rotation),
      playerVisibilityChangedBehavior,
      const DeepCollectionEquality().hash(autoDispose));

  @JsonKey(ignore: true)
  @override
  _$BPConfigCopyWith<_BPConfig> get copyWith =>
      __$BPConfigCopyWithImpl<_BPConfig>(this, _$identity);
}

abstract class _BPConfig implements BPConfig {
  const factory _BPConfig(
      {final Widget Function(BuildContext, String?)? errorBuilder,
      final Widget? placeholder,
      final bool placeholderOnTop,
      final bool showPlaceholderUntilPlay,
      final Widget? overlay,
      final BoxFit fit,
      final bool expandToFill,
      final int rotation,
      final dynamic Function(double)? playerVisibilityChangedBehavior,
      final bool autoDispose}) = _$_BPConfig;

  @override

  /// When the video playback runs  into an error, you can build a custom
  /// error message.
  Widget Function(BuildContext, String?)? get errorBuilder =>
      throw _privateConstructorUsedError;
  @override

  /// The placeholder is displayed underneath the Video before it is initialized
  /// or played.
  Widget? get placeholder => throw _privateConstructorUsedError;
  @override

  /// Placeholder position of player stack. If false, then placeholder will be
  /// displayed on the bottom, so user need to hide it manually. Default is
  /// true.
  bool get placeholderOnTop => throw _privateConstructorUsedError;
  @override

  /// Should the placeholder be shown until play is pressed
  bool get showPlaceholderUntilPlay => throw _privateConstructorUsedError;
  @override

  /// A widget which is placed between the video and the controls
  Widget? get overlay => throw _privateConstructorUsedError;
  @override // /// Defines a custom RoutePageBuilder for the fullscreen
// final BPRoutePageBuilder? routePageBuilder;
// /// Defines a event listener where video player events will be send
// final Function(BPEvent)? eventListener;
  ///Defines fit of the video, allows to fix video stretching, see possible
  ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
  BoxFit get fit => throw _privateConstructorUsedError;
  @override

  ///Flag which causes to player expand to fill all remaining space. Set to false
  ///to use minimum constraints
  bool get expandToFill => throw _privateConstructorUsedError;
  @override

  ///Defines rotation of the video in degrees. Default value is 0. Can be 0, 90, 180, 270.
  ///Angle will rotate only video box, controls will be in the same place.
// rotation <= 360 && rotation % 90 == 0
  int get rotation => throw _privateConstructorUsedError;
  @override

  ///Defines function which will react on player visibility changed
  dynamic Function(double)? get playerVisibilityChangedBehavior =>
      throw _privateConstructorUsedError;
  @override // ///Defines translations used in player. If null, then default english translations
// ///will be used.
// final List<BPTranslations>? translations;
  ///Defines flag which enabled/disabled auto dispose of
  ///[BPController] on [BetterPlayer] dispose. When it's true and
  ///[BPController] instance has been attached to [BetterPlayer] widget
  ///and dispose has been called on [BetterPlayer] instance, then
  ///[BPController] will be disposed.
  ///Default value is true.
  bool get autoDispose => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BPConfigCopyWith<_BPConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
