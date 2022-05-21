import 'package:better_player/src/utils/my_size_changed_layout_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SizeNotificationTest extends StatefulHookConsumerWidget {
  const SizeNotificationTest({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SizeNotificationTestState();
}

class _SizeNotificationTestState extends ConsumerState<SizeNotificationTest> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<LayoutChangedNotification>(
      onNotification: (notification) {
        print("===================notification: ${notification}");

        /// 收到布局结束通知,打印尺寸
        _printSize();

        /// flutter1.7之后需要返回值,之前是不需要的.
        return true;
      },
      child: MySizeChangedLayoutNotifier(
        child: _buildContentWidget(),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Container(
      color: Colors.red,
      child: const Text(
        '''
        1 ...     1
        2 ...     2
        3 ...       3
        4 ...      4
        ''',
        style: TextStyle(fontSize: 30),
        maxLines: null,
        softWrap: true,
      ),
    );
  }

  void _printSize() {
    if (!mounted) return;
    var size = context.findRenderObject()?.paintBounds.size;
    print("------------------- size: ${size.toString()}");
  }
}
