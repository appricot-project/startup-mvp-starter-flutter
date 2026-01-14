import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/bloc/profile_tab_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/widgets/profile_tab_widget.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(profileService: locator<ProfileService>())
            ..add(ProfileTabOnAppear()),
      child: const ProfileTabWidget(),
    );
  }
}
