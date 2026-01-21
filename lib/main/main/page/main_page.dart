import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main/bloc/main_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main/widgets/main_widget.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(
        sharedStorage: locator<SharedStorage>(),
        mainService: locator<MainService>(),
      )..add(MainOnAppear()),
      child: MainWidget(),
    );
  }
}
