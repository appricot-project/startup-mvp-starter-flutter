import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/verification_email/page/verification_email_page.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class SignInWidget extends StatefulWidget {
  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInClose) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state is SignInError) {
          showErrorAlert(context: context, error: state.error);
        }
        if (state is SignInShowVerification) {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) {
                    return VerificationEmailPage(
                      gmail: state.gmail,
                      expireIn: Duration(minutes: 1),
                    );
                  },
                ),
              )
              .then((_) {
                context.read<SignInBloc>().add(SignInOnReturned());
              });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CloseButton(
                onPressed: () {
                  context.read<SignInBloc>().add(SignInOnCloseButtonTapped());
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return LoadingIndicator(
                loading: state.loading == Loading.actionLoading,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8, left: 8, bottom: 16),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.authSignin,
                          style: CustomTextStyle.mobileH2(
                            color: ColorConstants.primary,
                          ),
                        ),
                        SizedBox(height: 12),
                        BasicTextField(
                          hintText: 'example@mail.com',
                          controller: _controller,
                          onChanged: (value) {
                            context.read<SignInBloc>().add(
                              SignInOnTextChanged(key: 'email', value: value),
                            );
                          },
                          keyboardType: TextInputType.emailAddress,
                          error: state.textFieldsErrors['email'],
                          label: AppLocalizations.of(context)!.authEnterEmail,
                        ),
                        SizedBox(height: 16),
                        CustomButton(
                          text: AppLocalizations.of(context)!.authGetCode,
                          onPressed: () {
                            context.read<SignInBloc>().add(
                              SignInOnGetCodeButtonTapped(
                                textFields: {'email': _controller.text},
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
