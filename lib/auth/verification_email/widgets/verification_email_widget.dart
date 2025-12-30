import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/verification_email/bloc/verification_email_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_back_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/pin_code_text_field.dart';

class VerificationEmailWidget extends StatefulWidget {
  @override
  State<VerificationEmailWidget> createState() =>
      _VerificationEmailWidgetState();
}

class _VerificationEmailWidgetState extends State<VerificationEmailWidget> {
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
    return BlocListener<VerificationEmailBloc, VerificationEmailState>(
      listener: (context, state) {
        if (state is VerificationEmailClose) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context, rootNavigator: true).pop();
          });
        }
        if (state is VerificationEmailBack) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pop();
          });
        }
        if (state is VerificationEmailError) {
          _controller.text = '';
          showErrorAlert(context: context, error: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            onPressed: () {
              context.read<VerificationEmailBloc>().add(
                VerificationEmailOnBack(),
              );
            },
          ),
          leadingWidth: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CloseButton(
                onPressed: () {
                  context.read<VerificationEmailBloc>().add(
                    VerificationEmailOnClose(),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<VerificationEmailBloc, VerificationEmailState>(
          builder: (context, state) {
            return SafeArea(
              child: LoadingIndicator(
                loading: state.loading == Loading.actionLoading,
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 9),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(
                                  context,
                                )!.authVerificationTitle +
                                ':\n ${state.gmail}',
                            style: CustomTextStyle.mobileH1(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      16.h,
                      PinCodeTextField(length: 4),
                      16.h,
                      CustomButton(
                        text:
                            AppLocalizations.of(context)!.authGetNewCode +
                            '${state.time.inSeconds == 0 ? '' : ' ${AppLocalizations.of(context)!.authAfterThrough} ${formatDuration(state.time)}'}',
                        onPressed: () {
                          context.read<VerificationEmailBloc>().add(
                            VerificationEmailOnNewCode(),
                          );
                        },
                        isEnabled:
                            ((state.time.inSeconds == 0) &&
                            (state.loading == null)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
