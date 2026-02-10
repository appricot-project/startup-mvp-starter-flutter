import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/my_bottom_navigation_bar.dart';

@RoutePage()
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  TabsRouter? tabsRouter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        MainTabRoute(),
        FavouritesTabRoute(),
        ProfileTabRoute(),
        SettingsTabRoute(),
      ],
      builder: (context, child) {
        final router = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: MyBottomNavigationBar(navigationShell: router),
        );
      },
    );
  }
}
