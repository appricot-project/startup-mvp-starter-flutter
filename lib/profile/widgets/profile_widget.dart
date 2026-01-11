import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/bloc/profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

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
            case 'signIn':
            case '':
          }
        }
      },
      child: Scaffold(
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
                                  'Войдите в профиль',
                                  style: CustomTextStyle.title1(
                                    // color: ColorConstants.greyDarkActive,
                                  ),
                                ),
                                24.h,
                                CustomButton(
                                  text: 'Войти',
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(
                                      ProfileOnTapped(key: 'signIn'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 16),
                    //   child: ListView.builder(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           context.read<ProfileBloc>().add(
                    //             ProfileOnItemTapped(
                    //               key: state.items[index].key,
                    //             ),
                    //           );
                    //         },
                    //         child: Container(
                    //           height: 60,
                    //           decoration: BoxDecoration(
                    //             border: Border(
                    //               bottom: BorderSide(
                    //                 width: 0.33,
                    //                 color: Color.fromRGBO(84, 84, 86, 0.34),
                    //               ),
                    //             ),
                    //           ),
                    //           child: Center(
                    //             child: Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   state.items[index].title,
                    //                   style: CustomTextStyle.body1(),
                    //                 ),
                    //                 Expanded(child: Container()),
                    //                 Padding(
                    //                   padding: EdgeInsets.only(right: 16),
                    //                   child: SizedBox(
                    //                     height: 32,
                    //                     width: 8,
                    //                     child: PlatformComponents.drillInIcon(),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     itemCount: state.items.length,
                    //   ),
                    // ),
                    BlocBuilder<AuthCubit, bool>(
                      builder: (context, isAuthorize) {
                        return Visibility(
                          visible: isAuthorize,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                              left: 16,
                              right: 16,
                            ),
                            child: SizedBox(
                              height: 44,
                              child: GestureDetector(
                                child: Center(
                                  child: Text(
                                    'Выйти из профиля',
                                    style: CustomTextStyle.buttonText(
                                      // color: ColorConstants.greyDark,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  context.read<ProfileBloc>().add(
                                    ProfileOnTapped(key: 'logout'),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // bottomStickyWidget: Padding(
                //   padding: EdgeInsets.only(top: 16, bottom: 24),
                //   child: Text(
                //     'Версия ${_appVersion}',
                //     style: CustomTextStyle.body2(
                //       color: ColorConstants.greyMedium,
                //     ),
                //   ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
