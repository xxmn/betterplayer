// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Indicates that the size of one of the descendants of the object receiving
/// this notification has changed, and that therefore any assumptions about that
/// layout are no longer valid.
///
/// For example, sent by the [MySizeChangedLayoutNotifier] widget whenever that
/// widget changes size.
///
/// This notification can be used for triggering repaints, but if you use this
/// notification to trigger rebuilds or relayouts, you'll create a backwards
/// dependency in the frame pipeline because [SizeChangedLayoutNotification]s
/// are generated during layout, which is after the build phase and in the
/// middle of the layout phase. This backwards dependency can lead to visual
/// corruption or lags.
///
/// See [LayoutChangedNotification] for additional discussion of layout
/// notifications such as this one.
///
/// See also:
///
///  * [MySizeChangedLayoutNotifier], which sends this notification.
///  * [LayoutChangedNotification], of which this is a subclass.
class SizeChangedLayoutNotification extends LayoutChangedNotification {}

/// A widget that automatically dispatches a [SizeChangedLayoutNotification]
/// when the layout dimensions of its child change.
///
/// The notification is not sent for the initial layout (since the size doesn't
/// change in that case, it's just established).
///
/// To listen for the notification dispatched by this widget, use a
/// [NotificationListener<SizeChangedLayoutNotification>].
///
/// The [Material] class listens for [LayoutChangedNotification]s, including
/// [SizeChangedLayoutNotification]s, to repaint [InkResponse] and [InkWell] ink
/// effects. When a widget is likely to change size, wrapping it in a
/// [MySizeChangedLayoutNotifier] will cause the ink effects to correctly repaint
/// when the child changes size.
///
/// See also:
///
///  * [Notification], the base class for notifications that bubble through the
///    widget tree.
class MySizeChangedLayoutNotifier extends SingleChildRenderObjectWidget {
  /// Creates a [MySizeChangedLayoutNotifier] that dispatches layout changed
  /// notifications when [child] changes layout size.
  const MySizeChangedLayoutNotifier({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSizeChangedWithCallback(
      onLayoutChangedCallback: () {
        SizeChangedLayoutNotification().dispatch(context);
      },
    );
  }
}

class _RenderSizeChangedWithCallback extends RenderProxyBox {
  _RenderSizeChangedWithCallback({
    RenderBox? child,
    required this.onLayoutChangedCallback,
  })  : assert(onLayoutChangedCallback != null),
        super(child);

  // There's a 1:1 relationship between the _RenderSizeChangedWithCallback and
  // the `context` that is captured by the closure created by createRenderObject
  // above to assign to onLayoutChangedCallback, and thus we know that the
  // onLayoutChangedCallback will never change nor need to change.

  final VoidCallback onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    // Don't send the initial notification, or this will be SizeObserver all
    // over again!
    if (size != _oldSize)
      // if (_oldSize != null && size != _oldSize)
      onLayoutChangedCallback();
    _oldSize = size;
  }
}
