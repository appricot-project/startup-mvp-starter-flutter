import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/navigation/tab_item.dart';

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation({
    super.key,
    required this.currentTabIndex,
    required this.onSelectTab,
    required this.tabs,
  });

  final int currentTabIndex;
  final ValueChanged<int> onSelectTab;
  final List<TabNavigatorItem> tabs;

  // final Map<TabItem, MyTab> tabs = {
  //   TabItem.menu: MyTab(name: 'Меню', icon: 'assets/images/tabBar_menu.svg'),
  //   TabItem.support: MyTab(
  //     name: 'Поддержка',
  //     icon: 'assets/images/tabBar_support.svg',
  //   ),
  //   TabItem.basket: MyTab(
  //     name: 'Корзина',
  //     icon: 'assets/images/tabBar_basket.svg',
  //   ),
  //   TabItem.more: MyTab(
  //     name: 'Профиль',
  //     icon: 'assets/images/tabBar_profile.svg',
  //   ),
  // };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // selectedItemColor: ColorConstants.darkText,
      // backgroundColor: ColorConstants.mainWhite,
      // unselectedItemColor: ColorConstants.unselectedNavigation,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTabIndex,
      items: _buildItems(),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {
        onSelectTab(index);
      },
    );
  }

  List<BottomNavigationBarItem> _buildItems() {
    return tabs.map((tab) {
      return BottomNavigationBarItem(
        icon: tab.icon,
        activeIcon: tab.activeIcon,
        // icon: SvgPicture.asset(
        //   value.icon,
        //   colorFilter: ColorFilter.mode(
        //     ColorConstants.unselectedNavigation,
        //     BlendMode.srcIn,
        //   ),
        // ),
        // activeIcon: SvgPicture.asset(
        //   value.icon,
        //   colorFilter: ColorFilter.mode(
        //     ColorConstants.darkText,
        //     BlendMode.srcIn,
        //   ),
        // ),
        label: tab.name,
      );
    }).toList();
  }
}
