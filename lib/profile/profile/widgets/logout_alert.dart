import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';

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
          style: CustomTextStyle.title1(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onNo.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonNo,
              style: CustomTextStyle.body1(),
            ),
          ),
          TextButton(
            onPressed: () {
              onYes.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonYes,
              style: CustomTextStyle.body1(),
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          AppLocalizations.of(context)!.profileLogoutConfirm,
          style: CustomTextStyle.mobileH1(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onNo.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonNo,
              style: CustomTextStyle.body1(),
            ),
          ),
          TextButton(
            onPressed: () {
              onYes.call();
            },
            child: Text(
              AppLocalizations.of(context)!.commonYes,
              style: CustomTextStyle.body1(),
            ),
          ),
        ],
      );
    }
  }
}
