import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/my_bottom_navigation_bar.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

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
    return BlocBuilder<AuthCubit, bool>(
      builder: (context, isAuthorized) {
        return AutoTabsRouter(
          key: ValueKey(isAuthorized),
          routes: [
            MainTabRoute(),
            FavouritesTabRoute(),
            ProfileTabRoute(),
            SettingsTabRoute(),
          ],
          builder: (context, child) {
            final router = AutoTabsRouter.of(context);
            return BlocBuilder<ThemeCubit, Brightness>(
              builder: (context, state) {
                return Scaffold(
                  body: child,
                  bottomNavigationBar: MyBottomNavigationBar(
                    navigationShell: router,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
