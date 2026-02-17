import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/bloc/notification_list_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/widgets/notification_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class NotificationListWidget extends StatefulWidget {
  const NotificationListWidget({super.key});

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationListBloc, NotificationListState>(
      listener: (context, state) {
        if (state is NotificationListError) {
          showErrorAlert(context: context, error: state.error);
        }
      },
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
                refreshController: _refreshController,
                onPullToRefresh: () async {
                  final bloc = context.read<NotificationListBloc>();
                  final future = bloc.stream.firstWhere(
                    (state) => state.loading != Loading.refresh,
                  );
                  bloc.add(NotificationListOnPullToRefresh());
                  await future;
                  _refreshController.refreshCompleted();
                },
                initialLoading: state.loading == Loading.initialLoading,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NotificationCellWidget(
                        notification: state.notifications[index],
                      );
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
