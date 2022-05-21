import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'status_provider.dart';

class SectionButtons extends HookConsumerWidget {
  const SectionButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isStart = ref.watch(itemStatusProvider.select((v) => v.selectStart));
    var isEnd = ref.watch(itemStatusProvider.select((v) => v.selectEnd));
    return Row(
      children: [
        AbsorbPointer(
          absorbing: !(isStart || isEnd),
          child: ToggleButtons(
            color: Colors.grey.withOpacity(0.4),
            selectedColor: Colors.deepOrange.withOpacity(0.4),
            disabledColor: Colors.deepPurple.withOpacity(0.4),
            fillColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.deepOrange.withOpacity(0.4),
            splashColor: Colors.deepPurple.withOpacity(0.4),
            borderColor: Colors.blue.withOpacity(0.4),
            selectedBorderColor: Colors.deepOrange.withOpacity(0.4),
            disabledBorderColor: Colors.deepPurple.withOpacity(0.4),
            renderBorder: true,
            isSelected: [true, false, true, true],
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isStart) ref.read(itemStatusProvider.notifier).decreaseStart();
                  if (isEnd) ref.read(itemStatusProvider.notifier).decreaseEnd();
                },
                child: const Icon(Icons.arrow_back),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isStart) ref.read(itemStatusProvider.notifier).insStart();
                  if (isEnd) ref.read(itemStatusProvider.notifier).insEnd();
                },
                child: const Icon(Icons.arrow_forward),
              ),
              ElevatedButton(
                onPressed: () {
                  print("-------------------new-------------------");
                },
                child: const Text("设置"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("-------------------replay_10-------------------");
                },
                child: const Icon(Icons.replay_10),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print("-------------------replay-------------------");
          },
          child: const Icon(Icons.replay),
        ),
        ElevatedButton(
          onPressed: () {
            print("-------------------done-------------------");
          },
          child: const Text("保存"),
        ),
        ElevatedButton(
          onPressed: () {
            print("-------------------new-------------------");
          },
          child: const Text("删除"),
        ),
      ],
    );
  }
}
