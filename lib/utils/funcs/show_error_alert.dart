import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/error_alert.dart';

showErrorAlert({
  required BuildContext context,
  required String error,
  void Function()? then,
}) {
  Future.delayed(Duration.zero, () {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return ErrorAlert(content: error);
      },
    ).then((value) {
      then?.call();
    });
  });
}
