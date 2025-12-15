import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:startup_mvp_starter_flutter/navigation/home_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/tab_item.dart';
import 'package:startup_mvp_starter_flutter/ui_testing_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

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
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    print("Theme changed: $brightness");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru')],
      locale: const Locale('ru'),
      theme: ThemeData(
        dividerColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        appBarTheme: AppBarTheme(backgroundColor: ColorConstants.background),
        scaffoldBackgroundColor: ColorConstants.background,
      ),
      home: Scaffold(body: HomePage(delegate: Detegate())),
    );
  }
}

class Detegate implements BottomNavigationDataSource {
  List<TabNavigatorItem> items() {
    return [
      TabNavigatorItem(
        activeIcon: Container(height: 24, width: 24, color: Colors.green),
        name: 'Test',
        icon: Container(height: 24, width: 24, color: Colors.grey),
      ),
      TabNavigatorItem(
        activeIcon: Container(height: 24, width: 24, color: Colors.green),
        name: 'TwoTest',
        icon: Container(height: 24, width: 24, color: Colors.grey),
      ),
    ];
  }

  Widget tabWidget(int tabIndex, {String? additionalParam}) {
    return Container();
  }
}
