import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/main/main/bloc/main_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class MainWidget extends StatelessWidget {
  const MainWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  _showCupertinoBottomSheet(context, state.currentSortType);
                },
                icon: Icon(Icons.sort, color: Theme.of(context).primaryColor),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initial,
                child: ListView.separated(
                  itemCount: state.startups.length,
                  padding: EdgeInsets.all(8),
                  separatorBuilder: (context, index) => Container(height: 16),
                  itemBuilder: (context, index) {
                    StartupModel startup = state.startups[index];
                    return Stack(
                      children: [
                        Opacity(
                          opacity: state.viewedIds.contains(startup.id)
                              ? 0.7
                              : 1,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (startup.imageUrl != null) {
                                      return Center(
                                        child: SizedBox(
                                          height: 200,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: startup.imageUrl!,
                                            placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Container(
                                          height: 200,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.outline,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                8.h,
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    startup.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                ),
                                4.h,
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    startup.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              context.read<MainBloc>().add(
                                MainOnActionButtonTapped(
                                  type: ActionType.favourite,
                                  value: startup.id,
                                ),
                              );
                            },
                            icon: state.favoriteIds.contains(startup.id)
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
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
