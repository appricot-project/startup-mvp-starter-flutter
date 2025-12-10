import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String? title;
  final String content;
  final VoidCallback? onPressed;
  const ErrorAlert({
    super.key,
    this.title,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Builder(
          builder: (context) {
            if (title != null) {
              return Text(title ?? '');
            } else {
              return Container();
            }
          },
        ),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              if (onPressed == null) {
                Navigator.of(context).pop();
              }
              onPressed?.call();
            },
            child: Text('Ok'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        title: Builder(
          builder: (context) {
            if (title != null) {
              return Text(title ?? '');
            } else {
              return Container();
            }
          },
        ),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              if (onPressed == null) {
                Navigator.of(context).pop();
              }
              onPressed?.call();
            },
            child: Text('Ok'),
          ),
        ],
      );
    }
  }
}
