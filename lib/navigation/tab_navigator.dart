import 'package:flutter/material.dart';

class TabNavigator<TabItem> extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.tabItemWidget,
    required this.additionalParams,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget tabItemWidget;
  final Map<TabItem, String> additionalParams;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        // Widget currentPage;
        // switch (tabItem) {
        //   case TabItem.menu:
        //     String? additionalParam = additionalParams[TabItem.menu];
        //     String? categoryId;
        //     if ((additionalParam?.contains('category=')) ?? false) {
        //       categoryId = additionalParam?.split('category=').last;
        //     }
        //     currentPage = MenuPage(
        //       showOrderTracking: additionalParam == 'showOrderTracking',
        //       categoryId: categoryId,
        //     );
        //     break;
        //   case TabItem.support:
        //     currentPage = SupportPage();
        //     break;
        //   case TabItem.basket:
        //     currentPage = ShoppingCartPage();
        //     break;
        //   case TabItem.more:
        //     currentPage = ProfilePage();
        //     break;
        // }
        return MaterialPageRoute(builder: (context) => tabItemWidget);
      },
    );
  }
}
