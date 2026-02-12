import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class SignInWidget extends StatefulWidget {
  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInClose) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state is SignInError) {
          showErrorAlert(context: context, error: decodeError(state.error));
        }
        if (state is SignInSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
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
                          state.isSignUp ? l10n.authSignUp : l10n.authSignin,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 12),
                        BasicTextField(
                          hintText: 'example@mail.com',
                          controller: _emailController,
                          onChanged: (value) {
                            context.read<SignInBloc>().add(
                              SignInOnTextChanged(
                                key: TextFieldKey.email,
                                value: value,
                              ),
                            );
                          },
                          keyboardType: TextInputType.emailAddress,
                          error: decodeFieldError(
                            state.textFieldsErrors[TextFieldKey.email],
                          ),
                          label: l10n.authEnterEmail,
                        ),
                        SizedBox(height: 12),
                        BasicTextField(
                          hintText: l10n.authPassword,
                          controller: _passwordController,
                          obscureText: true,
                          onChanged: (value) {
                            context.read<SignInBloc>().add(
                              SignInOnTextChanged(
                                key: TextFieldKey.password,
                                value: value,
                              ),
                            );
                          },
                          error: decodeFieldError(
                            state.textFieldsErrors[TextFieldKey.password],
                          ),
                          label: l10n.authPassword,
                        ),
                        SizedBox(height: 16),
                        CustomButton(
                          text: state.isSignUp
                              ? l10n.authSignUp
                              : l10n.authSignin,
                          onPressed: () {
                            context.read<SignInBloc>().add(
                              SignInOnSubmitButtonTapped(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            context.read<SignInBloc>().add(
                              SignInOnToggleMode(),
                            );
                          },
                          child: Text(
                            state.isSignUp
                                ? l10n.authHaveAccount
                                : l10n.authNoAccount,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
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

  String? decodeFieldError(String? errorCode) {
    final l10n = AppLocalizations.of(context)!;
    switch (errorCode) {
      case 'requiredField':
        return l10n.errorsRequiredField;
      case 'invalidEmail':
        return l10n.errorsInvalidEmail;
      case 'passwordTooShort':
        return l10n.errorsPasswordTooShort;
    }
    return null;
  }

  String decodeError(String errorCode) {
    final l10n = AppLocalizations.of(context)!;
    switch (errorCode) {
      case 'authWrongPassword':
        return l10n.authWrongPassword;
      case 'authUserNotFound':
        return l10n.authUserNotFound;
      case 'authEmailAlreadyInUse':
        return l10n.authEmailAlreadyInUse;
      case 'authWeakPassword':
        return l10n.authWeakPassword;
      default:
        return l10n.errorsSomethingWentWrong;
    }
  }
}
