import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/settings/notification_settings/bloc/notification_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';

class NotificationSettingsWidget extends StatefulWidget {
  @override
  State<NotificationSettingsWidget> createState() =>
      _NotificationSettingsWidgetState();
}

class _NotificationSettingsWidgetState
    extends State<NotificationSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationSettingsBloc, NotificationSettingsState>(
      listener: (context, state) {
        if (state is NotificationSettingsShowView) {
          switch (state.key) {
            case ViewKey.deviceSettings:
              AppSettings.openAppSettings(type: AppSettingsType.notification);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.settingsNotifications,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SafeArea(
          child:
              BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Switch.adaptive(
                              applyCupertinoTheme: false,
                              value: state.notificationEnabled,
                              onChanged: (bool value) {
                                context.read<NotificationSettingsBloc>().add(
                                  NotificationSettingsOnChanged(value: value),
                                );
                              },
                            ),
                            6.w,
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.settingsNotificationsControls,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
