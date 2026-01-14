import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/edit_profile/widgets/edit_profile_widget.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileBloc(profileService: locator<ProfileService>())
            ..add(EditProfileOnAppear()),
      child: EditProfileWidget(),
    );
  }
}
