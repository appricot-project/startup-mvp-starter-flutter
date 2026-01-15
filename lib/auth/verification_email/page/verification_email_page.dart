import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/verification_email/bloc/verification_email_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/verification_email/widgets/verification_email_widget.dart';

@RoutePage()
class VerificationEmailPage extends StatelessWidget {
  final String gmail;
  final Duration expireIn;
  const VerificationEmailPage({required this.gmail, required this.expireIn});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VerificationEmailBloc(expireIn: expireIn, gmail: gmail)
            ..add(VerificationEmailOnAppear()),
      child: VerificationEmailWidget(),
    );
  }
}
