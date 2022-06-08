import 'package:better_player/src/utils/bp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bottom_buttons.dart';
import 'current_provider.dart';
import 'top_buttons.dart';
import 'my_slider.dart';

class VideoSegmentItemPage extends HookConsumerWidget {
  const VideoSegmentItemPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 5, end: 5),
      child: Column(
        children: [
          VideoSegmentItemBottomButtons(),
          //TODO: 软键盘遮蔽问题
          _TimeText(),
          _TitleField(),
          MySlider(),
          VideoSegmentItemTopButtons(),
        ],
      ),
    );
  }
}

class _TimeText extends HookConsumerWidget {
  const _TimeText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var start = ref.watch(itemCurrentProvider.select((v) => v.start));
    var end = ref.watch(itemCurrentProvider.select((v) => v.end));
    return Row(
      children: [
        Text("开始时间: ${BPUtils.formatDurationMs(start)}"),
        SizedBox(width: 20),
        Text("结束时间: ${BPUtils.formatDurationMs(end)}"),
      ],
    );
  }
}

class _TitleField extends StatefulHookConsumerWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __TitleFieldState();
}

class __TitleFieldState extends ConsumerState<_TitleField> {
  late TextEditingController controller;
  // late FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    controller = useTextEditingController(text: ref.read(itemCurrentProvider.notifier).title);
    // focusNode = useFocusNode();
    return TextField(
      maxLength: 10,
      controller: controller,
      onEditingComplete: () {
        ref.read(itemCurrentProvider.notifier).title = controller.text;
        FocusScope.of(context).unfocus();
      },
      onChanged: (v) {
        print("title: ${ref.read(itemCurrentProvider.notifier).title}");
      },
      decoration: InputDecoration(
        hintText: '请输入标题',
        suffixIcon: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            controller.clear();
          },
        ),
      ),
      // focusNode: focusNode,
      inputFormatters: [],
    );
  }

  void _setTitle() {
    print('Second text field: ${controller.text}');
    ref.read(itemCurrentProvider.notifier).title = controller.text;
  }
}
