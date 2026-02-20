import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/navigation/route_visibility.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/bloc/notification_list_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/widgets/notification_cell_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/my_circular_progress_indicator.dart';

class NotificationListWidget extends StatefulWidget {
  const NotificationListWidget({super.key});

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget>
    with RouteVisibility<NotificationListWidget> {
  late RefreshController _refreshController;
  late ScrollController _scrollController;

  @override
  void didBecomeActive() {
    context.read<NotificationListBloc>().add(NotificationListOnPullToRefresh());
  }

  @override
  void initState() {
    _refreshController = RefreshController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final threshold = 50;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= threshold) {
      final state = context.read<NotificationListBloc>().state;

      if (state.hasMore && state.loading != Loading.moreLoading) {
        context.read<NotificationListBloc>().add(NotificationListOnLoadMore());
      }
    }
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
                scrollController: _scrollController,
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
                child: state.notifications.isEmpty
                    ? SizedBox(
                        height: 600,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.notificationListEmpty,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              state.notifications.length +
                              (state.loading == Loading.moreLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= state.notifications.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: MyCircularProgressIndicator(),
                                ),
                              );
                            }
                            final notification = state.notifications[index];
                            return NotificationCellWidget(
                              notification: notification,
                            );
                          },
                          separatorBuilder: (_, _) => 8.h,
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
