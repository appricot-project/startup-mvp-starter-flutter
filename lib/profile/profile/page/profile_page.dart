import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/bloc/profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/widgets/profile_widget.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(profileService: locator<ProfileService>())
            ..add(ProfileOnAppear()),
      child: const ProfileWidget(),
    );
  }
}
