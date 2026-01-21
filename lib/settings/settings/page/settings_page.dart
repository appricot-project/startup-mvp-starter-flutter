import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/settings/bloc/settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/settings/widgets/settings_widgets.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: SettingsWidgets(),
    );
  }
}
