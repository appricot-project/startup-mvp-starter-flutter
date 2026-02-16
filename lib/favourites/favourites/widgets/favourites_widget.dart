import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/favourites/favourites/bloc/favourites_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/main/widgets/startup_card.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/route_visibility.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class FavouritesWidget extends StatefulWidget {
  const FavouritesWidget();

  @override
  State<FavouritesWidget> createState() => _FavouritesWidgetState();
}

class _FavouritesWidgetState extends State<FavouritesWidget>
    with RouteVisibility<FavouritesWidget> {
  late RefreshController _refreshController;

  @override
  void didBecomeActive() {
    context.read<FavouritesBloc>().add(FavouritesOnPullToRefresh());
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
    return BlocListener<FavouritesBloc, FavouritesState>(
      listener: (context, state) {
        if (state is FavouritesError) {
          showErrorAlert(context: context, error: state.error);
        }
        if (state is FavouritesShowView) {
          context.pushRoute(MainDetailsRoute(startupId: state.startupId)).then((
            _,
          ) {
            context.read<FavouritesBloc>().add(FavouritesOnReturned());
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.navigationFavorite),
        ),
        body: SafeArea(
          child: BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initial,
                refreshController: _refreshController,
                onPullToRefresh: () async {
                  final bloc = context.read<FavouritesBloc>();
                  final future = bloc.stream.firstWhere(
                    (state) => state.loading != Loading.refresh,
                  );
                  bloc.add(FavouritesOnPullToRefresh());
                  await future;
                  _refreshController.refreshCompleted();
                },
                child: state.startups.isEmpty
                    ? SizedBox(
                      height: 600,
                      child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.favouritesEmpty,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                    )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.startups.length,
                        padding: EdgeInsets.all(8),
                        separatorBuilder: (context, index) =>
                            Container(height: 16),
                        itemBuilder: (context, index) {
                          StartupModel startup = state.startups[index];
                          return StartupCard(
                            startup: startup,
                            isFavorite: true,
                            isViewed: false,
                            onTap: () {
                              context.read<FavouritesBloc>().add(
                                FavouritesOnStartupTapped(
                                  startupId: startup.id,
                                ),
                              );
                            },
                            onFavoriteTap: () {
                              context.read<FavouritesBloc>().add(
                                FavouritesOnRemoveFavorite(
                                  startupId: startup.id,
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
}
