import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/widgets/sign_in_widget.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc()..add(SignInOnAppear()),
      child: SignInWidget(),
    );
  }
}
