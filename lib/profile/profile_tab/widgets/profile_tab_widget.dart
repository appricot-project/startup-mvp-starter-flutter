import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/page/sign_in_page.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/bloc/profile_tab_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/models/profile_info.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/widgets/logout_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/custom_modal_bottom_sheet.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class ProfileTabWidget extends StatefulWidget {
  const ProfileTabWidget({super.key});

  @override
  State<ProfileTabWidget> createState() => _ProfileTabWidgetState();
}

class _ProfileTabWidgetState extends State<ProfileTabWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileTabState>(
      listener: (context, state) async {
        if (state is ProfileTabShowView) {
          switch (state.key) {
            case 'signIn':
              showMyModalBottomSheet(
                context: context,
                widget: SignInPage(),
                then: (_) {
                  context.read<ProfileBloc>().add(ProfileTabOnAppear());
                },
              );
            case 'logoutAlert':
              showDialog(
                context: context,
                builder: (newContext) {
                  return LogoutAlert(
                    onYes: () {
                      context.read<ProfileBloc>().add(
                        ProfileTabOnTapped(key: 'logout'),
                      );
                      Navigator.of(newContext).pop();
                    },
                    onNo: () {
                      Navigator.of(newContext).pop();
                    },
                  );
                },
              ).then((value) {
                context.read<ProfileBloc>().add(ProfileTabOnAppear());
              });
            case 'editProfile':
              Navigator.of(context, rootNavigator: true)
                  .push(
                    MaterialPageRoute(builder: (context) => Container()),
                  )
                  .then((value) {
                    context.read<ProfileBloc>().add(ProfileTabOnReturned());
                  });
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileTabState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initialLoading,
                loading: state.loading == Loading.actionLoading,
                child: Column(
                  children: [
                    BlocBuilder<AuthCubit, bool>(
                      builder: (context, isAuthorized) {
                        if (!isAuthorized) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 24,
                            ),
                            child: Column(
                              children: [
                                12.h,
                                Text(
                                  AppLocalizations.of(context)!.profileSignIn,
                                  style: CustomTextStyle.title1(),
                                ),
                                24.h,
                                CustomButton(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.authSignin,
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                      ProfileTabOnTapped(key: 'signIn'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                              left: 16,
                              right: 16,
                            ),
                            child: Column(
                              children: [
                                profileUserInfo(state.profile),
                                24.h,
                                SizedBox(
                                  height: 44,
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.authLogout,
                                        style: CustomTextStyle.buttonText(),
                                      ),
                                    ),
                                    onTap: () {
                                      context.read<ProfileBloc>().add(
                                        ProfileTabOnTapped(key: 'logoutAlert'),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget profileUserInfo(ProfileInfo? profileInfo) {
    if (profileInfo == null) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PlatformComponents.profileUserIcon(),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileInfo.name, style: CustomTextStyle.mobileH2()),
                      SizedBox(height: 4),
                      Text(
                        profileInfo.phone,
                        style: CustomTextStyle.body2(
                          color: ColorConstants.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.read<ProfileBloc>().add(
                    ProfileTabOnTapped(key: 'editProfile'),
                  );
                },
                child: PlatformComponents.arrowRightIcon(),
              ),
            ],
          ),
          16.h,
          BasicTextField(
            hintText: '',
            onChanged: (_) {},
            label: AppLocalizations.of(context)!.profileEmailLabel,
            controller: TextEditingController(text: profileInfo.email),
            isEnabled: false,
          ),
        ],
      ),
    );
  }
}
