import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/notification_settings/bloc/notification_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/notification_settings/widgets/%20notification_settings_widget.dart';

@RoutePage()
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationSettingsBloc()..add(NotificationSettingsOnAppear()),
      child: NotificationSettingsWidget(),
    );
  }
}
