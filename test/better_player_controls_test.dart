import 'package:better_player/better_player.dart';
import 'package:better_player/src/core/better_player_with_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'better_player_mock_controller.dart';

void main() {
  late BPMockController _mockController;

  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  setUp(() {
    _mockController = BPMockController(const BPConfiguration());
  });

  testWidgets(
    "One of children is BPWithControls",
    (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrapWidget(
          BP(
            controller: _mockController,
          ),
        ),
      );
      expect(find.byWidgetPredicate((widget) => widget is BPWithControls), findsOneWidget);
    },
  );
}

///Wrap widget with material app to handle all features like navigation and
///localization properly.
Widget _wrapWidget(Widget widget) {
  return MaterialApp(home: widget);
}
