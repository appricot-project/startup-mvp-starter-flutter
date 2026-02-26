import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/main/main/bloc/main_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/main/widgets/startup_card.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/route_visibility.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class MainWidget extends StatefulWidget {
  const MainWidget();

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget>
    with RouteVisibility<MainWidget> {
  late RefreshController _refreshController;

  @override
  void didBecomeActive() {
    context.read<MainBloc>().add(MainOnPullToRefresh());
  }

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
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainError) {
          showErrorAlert(context: context, error: state.error);
        }
        if (state is MainShowView) {
          switch (state.key) {
            case ViewKey.details:
              String startupId = state.data as String;
              context.pushRoute(MainDetailsRoute(startupId: startupId)).then((
                _,
              ) {
                context.read<MainBloc>().add(MainOnReturned());
              });
              break;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  _showCupertinoBottomSheet(context, state.currentSortType);
                },
                icon: Icon(Icons.sort),
              );
            },
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initial,
                refreshController: _refreshController,
                onPullToRefresh: () async {
                  final bloc = context.read<MainBloc>();
                  final future = bloc.stream.firstWhere(
                    (state) => state.loading != Loading.refresh,
                  );
                  bloc.add(MainOnPullToRefresh());
                  await future;
                  _refreshController.refreshCompleted();
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.startups.length,
                  padding: EdgeInsets.all(8),
                  separatorBuilder: (context, index) => Container(height: 16),
                  itemBuilder: (context, index) {
                    StartupModel startup = state.startups[index];
                    return StartupCard(
                      startup: startup,
                      isFavorite: state.favoriteIds.contains(startup.id),
                      isViewed: state.viewedIds.contains(startup.id),
                      onTap: () {
                        context.read<MainBloc>().add(
                          MainOnActionButtonTapped(
                            type: ActionType.details,
                            value: startup.id,
                          ),
                        );
                      },
                      onFavoriteTap: () {
                        context.read<MainBloc>().add(
                          MainOnActionButtonTapped(
                            type: ActionType.favourite,
                            value: startup.id,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _showCupertinoBottomSheet(BuildContext context, SortType currentSortType) {
    var actions = SortType.values
        .map(
          (e) => CupertinoActionSheetAction(
            onPressed: () {
              context.read<MainBloc>().add(MainOnSortSelected(sortType: e));
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              switch (e) {
                SortType.newest => AppLocalizations.of(context)!.sortTypeNewest,
                SortType.favorites => AppLocalizations.of(
                  context,
                )!.sortTypeFavorites,
                SortType.recentViewed => AppLocalizations.of(
                  context,
                )!.sortTypeRecentViewed,
              },
              style: TextStyle(
                fontSize: 17,
                fontWeight: currentSortType == e
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: Colors.blue,
              ),
            ),
          ),
        )
        .toList();
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        useRootNavigator: true,
        builder: (context) => CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.commonCancel,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        context: context,
      );
    } else {
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext neContext) {
          return Container(
            width: double.infinity,
            height: 32 + (48 * SortType.values.length).toDouble(),
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: SortType.values
                  .map(
                    (element) => TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () {
                        context.read<MainBloc>().add(
                          MainOnSortSelected(sortType: element),
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text(
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: currentSortType == element
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        switch (element) {
                          SortType.newest => AppLocalizations.of(
                            context,
                          )!.sortTypeNewest,
                          SortType.favorites => AppLocalizations.of(
                            context,
                          )!.sortTypeFavorites,
                          SortType.recentViewed => AppLocalizations.of(
                            context,
                          )!.sortTypeRecentViewed,
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
    }
  }
}
