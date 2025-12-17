import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/navigation/tab_item.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: ColorConstants.selectedNavigation,
      backgroundColor: ColorConstants.background,
      unselectedItemColor: ColorConstants.unselectedNavigation,
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
        label: tab.name,
      );
    }).toList();
  }
}
