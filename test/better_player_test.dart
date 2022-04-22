import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'better_player_mock_controller.dart';
import 'better_player_test_utils.dart';

void main() {
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets("Better Player simple player - network", (WidgetTester tester) async {
    await tester.pumpWidget(_wrapWidget(BP.network(BPTestUtils.bugBuckBunnyVideoUrl)));
    expect(find.byWidgetPredicate((widget) => widget is BP), findsOneWidget);
  });

  testWidgets("Better Player simple player - file", (WidgetTester tester) async {
    await tester.pumpWidget(_wrapWidget(BP.network(BPTestUtils.bugBuckBunnyVideoUrl)));
    expect(find.byWidgetPredicate((widget) => widget is BP), findsOneWidget);
  });

  testWidgets("BP - with controller", (WidgetTester tester) async {
    final BPMockController bpController = BPMockController(const BPConfiguration());
    await tester.pumpWidget(_wrapWidget(BP(
      controller: bpController,
    )));
    expect(find.byWidgetPredicate((widget) => widget is BP), findsOneWidget);
  });
}

///Wrap widget with material app to handle all features like navigation and
///localization properly.
Widget _wrapWidget(Widget widget) {
  return MaterialApp(home: widget);
}
