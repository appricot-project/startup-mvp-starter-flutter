import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/ui_testing_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

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
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    locator<ThemeCubit>().changeTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Brightness>(
      builder: (context, them) {
        return BlocBuilder<LocalizationCubit, String>(
          builder: (context, localeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale('en'), Locale('ru')],
              locale: Locale(localeState),
              theme: ThemeData(
                dividerColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                appBarTheme: AppBarTheme(
                  backgroundColor: ColorConstants.background,
                ),
                scaffoldBackgroundColor: ColorConstants.background,
              ),
              home: Scaffold(body: UiTestingWidget()),
            );
          },
        );
      },
    );
  }
}
