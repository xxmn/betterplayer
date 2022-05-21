import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'status_provider.dart';

class MySlider extends StatefulHookConsumerWidget {
  final double min;
  final double max;
  final double totalWidth = 300;
  late double rate;
  MySlider({required this.min, required this.max, Key? key}) : super(key: key) {
    rate = totalWidth / max;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __MySlider2State();
}

class __MySlider2State extends ConsumerState<MySlider> {
  final double height = 6;
  double top = 32;
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
    var w21 = startKey.currentContext?.size?.width;
    var w22 = endKey.currentContext?.size?.width;

    setState(() {
      // top = startKey.currentContext?.size?.height ?? 32;
      // print("_getContainerHeight --------------- top:$top");
      w = w21 ?? 0;
      w2 = w22 ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var r = ref.watch(itemStatusProvider);
    // print("MySlider rebuilding..................r:$r");
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      // alignment: Alignment.center,
      children: [
        // Container(height: height, width: r.start * rate, color: Colors.grey),
        Positioned(
          top: top,
          left: 0,
          child: Container(height: height, width: r.start * widget.rate, color: Colors.grey),
        ),
        Positioned(
          key: startKey,
          top: 0,
          left: r.start * widget.rate - w / 2,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var selected = ref.watch(itemStatusProvider.select((v) => v.selectStart));
              return IconButton(
                color: selected ? Colors.blue : Colors.black,
                icon: const Icon(Icons.arrow_downward),
                onPressed: () => ref.read(itemStatusProvider.notifier).toggleStart(),
              );
            },
          ),
        ),
        Positioned(
          top: top,
          left: r.start * widget.rate,
          child:
              Container(height: height, width: (r.end - r.start) * widget.rate, color: Colors.blue),
        ),
        Positioned(
          key: endKey,
          top: 0,
          left: r.end * widget.rate - w2 / 2,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var selected = ref.watch(itemStatusProvider.select((v) => v.selectEnd));
              return IconButton(
                color: selected ? Colors.blue : Colors.black,
                icon: Icon(Icons.arrow_downward),
                onPressed: () => ref.read(itemStatusProvider.notifier).toggleEnd(),
              );
            },
          ),
        ),
        Positioned(
          top: top,
          left: r.end * widget.rate,
          child: Container(
              height: height, width: (widget.max - r.end) * widget.rate, color: Colors.grey),
        ),
      ],
    );
  }
}
