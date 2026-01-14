import 'dart:io';

import 'package:flutter/material.dart';

// this widgets can be used without autoroute

class ModalDraggableSheet extends StatelessWidget {
  const ModalDraggableSheet({
    super.key,
    required this.child,
    this.initialChildSize = .5,
    this.minChildSize = .25,
    this.maxChildSize = .95,
  });

  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return Platform.isIOS
            ? ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Material(
                  color: Colors.white,
                  child: DraggableScrollController(
                    scrollController: scrollController,
                    child: child,
                  ),
                ),
              )
            : DraggableScrollController(
                scrollController: scrollController,
                child: child,
              );
      },
    );
  }
}

/// this widget is responsible of supplying the scroll controller of a draggable
/// scrollable sheet to its children.
///
/// * see
///   * [DraggableScrollControllerStateMixin] for stateful widget mixin
///     Use the getter [DraggableScrollControllerStateMixin.scrollController]
///     to get the scroll controller
///   * [DraggableScrollControllerStateMixin] for stateless widget mixin
///     Use the method [DraggableScrollControllerMixin.getScrollController]
///     to get the scroll controller
///
class DraggableScrollController extends InheritedWidget {
  const DraggableScrollController({
    super.key,
    this.scrollController,
    required super.child,
  });

  final ScrollController? scrollController;

  static ScrollController? of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<DraggableScrollController>()
          ?.scrollController;
    }
    final widget = context
        .getElementForInheritedWidgetOfExactType<DraggableScrollController>()
        ?.widget as DraggableScrollController?;
    return widget?.scrollController;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

/// mixin to simplify retrieving the scrollController on stateful widget that may be
/// inserted inside a [ModalDraggableSheet]
mixin DraggableScrollControllerStateMixin<T extends StatefulWidget>
    on State<T> {
  ScrollController? get scrollController =>
      DraggableScrollController.of(context);
}

/// mixin to simplify retrieving the scrollController on stateless widget that may be
/// inserted inside a [ModalDraggableSheet]
mixin DraggableScrollControllerMixin on StatelessWidget {
  ScrollController? getScrollController(BuildContext context) =>
      DraggableScrollController.of(context);
}
