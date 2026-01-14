import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/date_text_field.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/phone_text_field.dart';

class EditProfileWidget extends StatefulWidget {
  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    nameController = TextEditingController();
    dateController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileBack) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context, rootNavigator: true).pop();
          });
        }
        if (state is EditProfileUpdatedUserInfo) {
          nameController.text = state.profileInfo?.name ?? '';
          phoneController.text = state.profileInfo?.phone ?? '';
          emailController.text = state.profileInfo?.email ?? '';
          dateController.text = state.profileInfo?.birthday ?? '';
        }
        if (state is EditProfileError) {
          showErrorAlert(context: context, error: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          leadingWidth: 8,
          title: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<EditProfileBloc>().add(
                            EditProfileOnBackButtonTapped(),
                          );
                        },
                        child: PlatformComponents.lineArrowLeftIcon(),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.profilePersonalData,
                    style: CustomTextStyle.mobileH1(),
                  ),
                ],
              );
            },
          ),
        ),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: LoadingIndicator(
                initialLoading: state.loading == Loading.initialLoading,
                loading: state.loading == Loading.actionLoading,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.h,
                            BasicTextField(
                              controller: nameController,
                              hintText: '',
                              error: state.textFieldsErrors['name'],
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                  EditProfileOnTextChanged(
                                    key: 'name',
                                    newValue: value,
                                  ),
                                );
                              },
                              label: AppLocalizations.of(
                                context,
                              )!.profileNameLabel,
                            ),
                            16.h,
                            PhoneTextField(
                              controller: phoneController,
                              hintText: '',
                              error: state.textFieldsErrors['phone'],
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                  EditProfileOnTextChanged(
                                    key: 'phone',
                                    newValue: value,
                                  ),
                                );
                              },
                              label: AppLocalizations.of(
                                context,
                              )!.profilePhoneNumber,
                            ),
                            16.h,
                            BasicTextField(
                              controller: emailController,
                              isEnabled: false,
                              hintText: '',
                              onChanged: (_) {},
                              label: AppLocalizations.of(
                                context,
                              )!.profileEmailLabel,
                            ),
                            16.h,
                            DateTextField(
                              controller: dateController,
                              error: state.textFieldsErrors['date'],
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                  EditProfileOnTextChanged(
                                    key: 'date',
                                    newValue: value,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            text: AppLocalizations.of(context)!.commonSave,
                            onPressed: () {
                              context.read<EditProfileBloc>().add(
                                EditProfileOnButtonTapped(
                                  fields: {
                                    'name': nameController.text,
                                    'date': dateController.text,
                                    'phone': phoneController.text,
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? decodeError(String? errorCode) {
    switch (errorCode) {
      case 'requiredField':
        return AppLocalizations.of(context)!.errorsRequiredField;
      case 'errorBirthdayCuttent':
        return AppLocalizations.of(context)!.errorBirthdayCuttent;
      case 'errorBirthdayGreater':
        return AppLocalizations.of(context)!.errorBirthdayGreater;
    }
    return null;
  }
}
