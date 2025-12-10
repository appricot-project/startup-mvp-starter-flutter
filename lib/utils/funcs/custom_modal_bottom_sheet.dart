import 'dart:io';
import 'package:flutter/material.dart';

showMyModalBottomSheet({
  required BuildContext context,
  required Widget widget,
  bool useRootNavigator = false,
  bool enableDrag = true,
  bool fullScreen = false,
  void Function(dynamic value)? then,
  void Function()? whenComplete,
}) {
  Widget? page;
  if (Platform.isIOS) {
    showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          useSafeArea: true,
          clipBehavior: Clip.antiAlias,
          isScrollControlled: true,
          isDismissible: enableDrag,
          useRootNavigator: useRootNavigator,
          enableDrag: enableDrag,
          context: context,
          builder: (context) {
            page ??= Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateRoute: (settings) => MaterialPageRoute(
                fullscreenDialog: fullScreen,
                builder: (context) => widget,
              ),
            );
            return page ?? Container();
          },
        )
        .then((value) {
          if (context.mounted) {
            then?.call(value);
          }
        })
        .whenComplete(() {
          if (context.mounted) {
            whenComplete?.call();
          }
        });
  } else {
    showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          isDismissible: enableDrag,
          useRootNavigator: useRootNavigator,
          enableDrag: enableDrag,
          context: context,
          builder: (context) {
            page ??= Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateRoute: (settings) => MaterialPageRoute(
                fullscreenDialog: fullScreen,
                builder: (context) => widget,
              ),
            );
            return page ?? Container();
          },
        )
        .then((value) {
          if (context.mounted) {
            then?.call(value);
          }
        })
        .whenComplete(() {
          if (context.mounted) {
            whenComplete?.call();
          }
        });
  }
}
