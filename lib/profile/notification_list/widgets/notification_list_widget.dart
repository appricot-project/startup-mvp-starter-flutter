import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/bloc/notification_list_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class NotificationListWidget extends StatefulWidget {
  const NotificationListWidget({super.key});

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationListBloc, NotificationListState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.notificationList,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: BlocBuilder<NotificationListBloc, NotificationListState>(
          builder: (context, state) {
            return SafeArea(
              child: LoadingIndicator(
                initialLoading: state.loading == Loading.initialLoading,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 16, right: 16),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Text(index.toString());
                    },
                    separatorBuilder: (_, _) {
                      return 8.h;
                    },
                    itemCount: state.notifications.length,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
