import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/bloc/profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // locator<AnalyticsService>().logEvent(eventName: 'screen_view');
    return BlocProvider(
      create: (context) => ProfileBloc(
        // storage: locator<SharedStorage>(),
        // profileService: locator<ProfileService>(),
      )..add(ProfileOnAppear()),
      child: const ProfileWidget(),
    );
  }
}
