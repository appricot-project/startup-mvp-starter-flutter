import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';

class LogoutAlert extends StatelessWidget {
  final void Function() onYes;
  final void Function() onNo;
  const LogoutAlert({super.key, required this.onYes, required this.onNo});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          AppLocalizations.of(context)!.profileLogoutConfirm,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              onNo.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonNo,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              onYes.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonYes,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          AppLocalizations.of(context)!.profileLogoutConfirm,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              onNo.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonNo,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              onYes.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonYes,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
    }
  }
}
