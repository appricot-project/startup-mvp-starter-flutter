import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/my_app.dart';
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(flavor: Flavor.prod);
  runApp(
    BlocProvider<AuthCubit>.value(
      value: locator<AuthCubit>(),
      child: BlocProvider.value(
        value: locator<LocalizationCubit>(),
        child: BlocProvider.value(
          value: locator<ThemeCubit>(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
