import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/favourites/favourites/bloc/favourites_bloc.dart';
import 'package:startup_mvp_starter_flutter/favourites/favourites/widgets/favourites_widget.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

@RoutePage()
class FavouritesPage extends StatelessWidget {
  const FavouritesPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(
        mainService: locator<MainService>(),
        sharedStorage: locator<SharedStorage>(),
      )..add(FavouritesOnAppear()),
      child: FavouritesWidget(),
    );
  }
}
