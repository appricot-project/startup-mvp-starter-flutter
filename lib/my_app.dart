import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/my_router_obsever.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/theme_data_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

final appRouter = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocalizationCubit, String>(
          builder: (context, localeState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale('en'), Locale('ru')],
              locale: Locale(localeState),
              themeMode: themeMode,
              theme: ThemeDataConstants.lightTheme(),
              darkTheme: ThemeDataConstants.darkTheme(),
              routerConfig: appRouter.config(
                navigatorObservers: () => [MyRouterObserver()],
              ),
            );
          },
        );
      },
    );
  }
}
