import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service.dart';
import 'package:startup_mvp_starter_flutter/firebase_options/dev/firebase_options.dart';
import 'package:startup_mvp_starter_flutter/my_app.dart';
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(
    flavor: Flavor.dev,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );

  final currentUser = FirebaseAuth.instance.currentUser;
  print('Current user: $currentUser');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<AuthCubit>()),
        BlocProvider.value(value: locator<LocalizationCubit>()),
        BlocProvider.value(value: locator<ThemeCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}
