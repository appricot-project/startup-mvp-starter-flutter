import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/widgets/sign_in_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignInBloc(authService: locator<AuthService>())
            ..add(SignInOnAppear()),
      child: SignInWidget(),
    );
  }
}
