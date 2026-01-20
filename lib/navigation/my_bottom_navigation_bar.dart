import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final TabsRouter navigationShell;
  // final ValueNotifier<int> checkoutCount;
  // final ValueNotifier<int> favouritesCount;

  const MyBottomNavigationBar({
    required this.navigationShell,
    // required this.checkoutCount,
    // required this.favouritesCount,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: BottomNavigationBar(
        backgroundColor: ColorConstants.background,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConstants.primary,
        unselectedItemColor: ColorConstants.unselectedNavigation,
        currentIndex: navigationShell.activeIndex,
        onTap: (index) {
          if (navigationShell.activeIndex == index) {
            navigationShell.stackRouterOfIndex(index)?.popUntilRoot();
          } else {
            navigationShell.setActiveIndex(index);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.navigationHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.navigationFavorite,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppLocalizations.of(context)!.navigationProfile,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.navigationSettings,
          ),
        ],
      ),
    );
  }
}
