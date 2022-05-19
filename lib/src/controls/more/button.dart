import 'package:better_player/src/controls/bp_config_provider.dart';
import 'package:better_player/src/config/bp_translations.dart';
import 'package:better_player/src/controls/bp_material_clickable_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'show_sheet.dart';
import 'speed.dart';
import 'text_style.dart';

class MoreButton extends HookConsumerWidget {
  const MoreButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var overflowMenuIcon = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowMenuIcon));
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.iconsColor));
    return BPMaterialClickableWidget(
      onTap: () => onShowMoreClicked(context),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          overflowMenuIcon,
          color: iconsColor,
        ),
      ),
    );
  }

  void onShowMoreClicked(BuildContext context) {
    showSheet([MoreOptionsList()], context);
  }
}

class MoreOptionsList extends HookConsumerWidget {
  const MoreOptionsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(bpTranslationsProvider!);
    final enablePlaybackSpeed =
        ref.watch(bpControlsConfigProvider!.select((v) => v.enablePlaybackSpeed));
    final playbackSpeedIcon =
        ref.watch(bpControlsConfigProvider!.select((v) => v.playbackSpeedIcon));
    final customItems =
        ref.watch(bpControlsConfigProvider!.select((v) => v.overflowMenuCustomItems));
    return SingleChildScrollView(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            if (enablePlaybackSpeed)
              MoreOptionsListRow(
                playbackSpeedIcon,
                translations.overflowMenuPlaybackSpeed,
                () {
                  Navigator.of(context).pop();
                  showSpeedChooserWidget(context);
                },
              ),
            // todo:
            // if (betterPlayerControlsConfiguration.enableSubtitles)
            //   MoreOptionsListRow(betterPlayerControlsConfiguration.subtitlesIcon,
            //       translations.overflowMenuSubtitles, () {
            //     Navigator.of(context).pop();
            //     _showSubtitlesSelectionWidget();
            //   }),
            // if (betterPlayerControlsConfiguration.enableQualities)
            //   MoreOptionsListRow(
            //       betterPlayerControlsConfiguration.qualitiesIcon, translations.overflowMenuQuality,
            //       () {
            //     Navigator.of(context).pop();
            //     _showQualitiesSelectionWidget();
            //   }),
            // if (betterPlayerControlsConfiguration.enableAudioTracks)
            //   MoreOptionsListRow(betterPlayerControlsConfiguration.audioTracksIcon,
            //       translations.overflowMenuAudioTracks, () {
            //     Navigator.of(context).pop();
            //     _showAudioTracksSelectionWidget();
            //   }),
            if (customItems.isNotEmpty)
              ...customItems.map(
                (customItem) => MoreOptionsListRow(
                  customItem.icon,
                  customItem.title,
                  () {
                    Navigator.of(context).pop();
                    customItem.onClicked.call();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class MoreOptionsListRow extends HookConsumerWidget {
  final IconData icon;
  final String name;
  final void Function() onTap;
  const MoreOptionsListRow(this.icon, this.name, this.onTap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var iconsColor = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowMenuIconsColor));
    var textColor = ref.watch(bpControlsConfigProvider!.select((v) => v.overflowModalTextColor));
    return BPMaterialClickableWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(icon, color: iconsColor),
            const SizedBox(width: 16),
            Text(
              name,
              style: getTextStyle(false, textColor),
            ),
          ],
        ),
      ),
    );
  }
}
