import 'package:better_player/src/config/bp_config_provider.dart';
import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/native_player/np_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorPage extends HookConsumerWidget {
  const ErrorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var errorBuilder = ref.watch(bpConfigProvider!.select((v) => v.errorBuilder));
    if (errorBuilder != null) {
      var errorDesc = ref.watch(npStatusProvider.select((v) => v.errorDescription));
      return errorBuilder(context, errorDesc);
    } else {
      return _DefaultErrorPage();
    }
  }
}

class _DefaultErrorPage extends HookConsumerWidget {
  const _DefaultErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textColor = ref.watch(bpControlsConfigProvider!.select((v) => v.textColor));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    var enableRetry = ref.watch(bpControlsConfigProvider!.select((v) => v.enableRetry));
    var defaultError = ref.watch(bpTranslationsProvider!.select((v) => v.generalDefaultError));
    var generalRetry = ref.watch(bpTranslationsProvider!.select((v) => v.generalRetry));

    final textStyle = TextStyle(color: textColor);
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: iconsColor,
              size: 42,
            ),
            Text(defaultError, style: textStyle),
            if (enableRetry)
              TextButton(
                onPressed: () {
                  // _betterPlayerController!.retryDataSource();
                },
                child: Text(
                  generalRetry,
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
      ),
    );
  }
}
