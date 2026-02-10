import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/theme_settings/widgers/theme_settings_widgets.dart';

@RoutePage()
class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeSettingsBloc(),
      child: ThemeSettingsWidgets(),
    );
  }
}
