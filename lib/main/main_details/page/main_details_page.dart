import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/bloc/main_details_bloc.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/widgets/main_details_widget.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

@RoutePage()
class MainDetailsPage extends StatelessWidget {
  final String startupId;
  const MainDetailsPage({required this.startupId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainDetailsBloc(
        startupId: startupId,
        mainService: locator<MainService>(),
        sharedStorage: locator<SharedStorage>(),
      )..add(MainDetailsOnAppear()),
      child: MainDetailsWidget(),
    );
  }
}
