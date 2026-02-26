import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/bloc/onboarding_bloc.dart';
import 'package:startup_mvp_starter_flutter/onboarding/widgets/onboarding_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(
        shared: locator<SharedStorage>(),
      )..add(OnboardingOnAppear()),
      child: OnboardingWidget(),
    );
  }
}
