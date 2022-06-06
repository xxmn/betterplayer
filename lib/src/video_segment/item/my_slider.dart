import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'current_provider.dart';
import 'status_provider.dart';

class MySlider extends StatefulHookConsumerWidget {
  MySlider({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __MySlider2State();
}

class __MySlider2State extends ConsumerState<MySlider> {
  final double height = 6;
  final double top = 36;
  final double left = 20;
  final GlobalKey startKey = GlobalKey();
  final GlobalKey endKey = GlobalKey();
  double w = 0;
  double w2 = 0;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback(_getContainerHeight);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MySlider oldWidget) {
    WidgetsBinding.instance!.addPostFrameCallback(_getContainerHeight);
    super.didUpdateWidget(oldWidget);
  }

  void _getContainerHeight(Duration d) {
    //TODO: 需优化， 动态获取icon的宽度

    var w21 = startKey.currentContext?.size?.width;
    var w22 = endKey.currentContext?.size?.width;

    setState(() {
      w = w21 ?? 0;
      w2 = w22 ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var progressStart = ref.watch(itemStatusProvider.select(
      (v) => v.progressStart.inMilliseconds / 1000,
    ));
    var progressMaxTime = ref.watch(itemStatusProvider.select(
      (v) => v.progressDuration.inMilliseconds / 1000,
    ));

    print("progressMaxTime: $progressMaxTime");

    var itemStart = ref.watch(itemCurrentProvider.select((v) => v.start.inMilliseconds / 1000));
    var itemEnd = ref.watch(itemCurrentProvider.select((v) => v.end.inMilliseconds / 1000));
    var start = itemStart - progressStart;
    var end = itemEnd - progressStart;
    // print("MySlider rebuilding..................start:$start, end: $end");
    print("start: $start, end:$end, (progressMaxTime - end): ${(progressMaxTime - end)}");
    return LayoutBuilder(
      builder: (context, constraints) {
        var rate = (constraints.maxWidth - left * 2) / progressMaxTime;
        return SizedBox(
          height: 48,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            // alignment: Alignment.center,
            children: [
              Positioned(
                top: top,
                left: left,
                child: Container(
                  height: height,
                  width: start * rate,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                top: top,
                left: left + start * rate,
                child: Container(
                  height: height,
                  width: (end - start) * rate,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                top: top,
                left: left + end * rate,
                child: Container(
                  height: height,
                  width: (progressMaxTime - end) * rate,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                key: startKey,
                top: 0,
                left: left + start * rate - w / 2,
                child: _DownArrowStart(),
              ),
              Positioned(
                key: endKey,
                top: 0,
                left: left + end * rate - w2 / 2,
                child: _DownArrowEnd(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DownArrowStart extends HookConsumerWidget {
  const _DownArrowStart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selected = ref.watch(itemStatusProvider.select((v) => v.selectStart));
    return IconButton(
      color: selected ? Colors.blue : Colors.black,
      // icon: Icon(Icons.arrow_downward),
      icon: const Icon(MfgLabs.down_fat),
      onPressed: ref.read(itemStatusProvider.notifier).toggleStart,
    );
  }
}

class _DownArrowEnd extends HookConsumerWidget {
  const _DownArrowEnd({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selected = ref.watch(itemStatusProvider.select((v) => v.selectEnd));
    return IconButton(
      color: selected ? Colors.blue : Colors.black,
      // icon: Icon(Icons.arrow_downward),
      icon: const Icon(MfgLabs.down_fat),
      onPressed: ref.read(itemStatusProvider.notifier).toggleEnd,
    );
  }
}
