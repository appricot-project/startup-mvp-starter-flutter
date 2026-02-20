import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/bloc/notification_list_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/widgets/notification_list_widget.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

@RoutePage()
class NotificationListPage extends StatelessWidget {
  const NotificationListPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationListBloc(profileService: locator<ProfileService>())
            ..add(NotificationListOnAppear()),
      child: NotificationListWidget(),
    );
  }
}
