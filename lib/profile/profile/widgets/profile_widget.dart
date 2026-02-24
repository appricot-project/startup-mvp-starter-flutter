import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/bloc/profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/models/profile_info.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/widgets/logout_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is ProfileShowView) {
          switch (state.key) {
            case ViewKey.signIn:
              context.pushRoute(ModalAuth()).then((_) {
                context.read<ProfileBloc>().add(ProfileOnAppear());
              });
            case ViewKey.logoutAlert:
              showDialog(
                context: context,
                builder: (newContext) {
                  return LogoutAlert(
                    onYes: () {
                      context.read<ProfileBloc>().add(
                        ProfileOnTapped(key: ActionKey.logout),
                      );
                      Navigator.of(newContext).pop();
                    },
                    onNo: () {
                      Navigator.of(newContext).pop();
                    },
                  );
                },
              ).then((value) {
                context.read<ProfileBloc>().add(ProfileOnAppear());
              });
            case ViewKey.editProfile:
              context.pushRoute(EditProfileRoute()).then((_) {
                context.read<ProfileBloc>().add(ProfileOnReturned());
              });
            case ViewKey.notificationList:
              context.pushRoute(NotificationListRoute()).then((_) {
                context.read<ProfileBloc>().add(ProfileOnReturned());
              });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.navigationProfile),
          actions: [
            BlocBuilder<AuthCubit, bool>(
              builder: (context, isAuthorized) {
                return Visibility(
                  visible: isAuthorized,
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                        ProfileOnTapped(key: ActionKey.notificationList),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
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
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                24.h,
                                CustomButton(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.authSignin,
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                      ProfileOnTapped(key: ActionKey.signIn),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
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
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                    ),
                                    onTap: () {
                                      context.read<ProfileBloc>().add(
                                        ProfileOnTapped(
                                          key: ActionKey.logoutAlert,
                                        ),
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
          GestureDetector(
            onTap: () {
              context.read<ProfileBloc>().add(
                ProfileOnTapped(key: ActionKey.editProfile),
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PlatformComponents.profileUserIcon(),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileInfo.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 4),
                          Text(
                            profileInfo.phone,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  PlatformComponents.arrowRightIcon(),
                ],
              ),
            ),
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
