import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/language_settings/bloc/language_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/language_settings/widgets/language_settings_widget.dart';

@RoutePage()
class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LanguageSettingsBloc()..add(LanguageSettingsOnAppear()),
      child: LanguageSettingsWidget(),
    );
  }
}
