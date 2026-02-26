import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/navigation/my_bottom_navigation_bar.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

@RoutePage()
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  TabsRouter? tabsRouter;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final shared = locator<SharedStorage>();
    final wasShown = await shared.isShowOnboarding();
    if (wasShown && mounted) {
      context.router.push(const OnboardingRoute());
    }
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
  }
}
