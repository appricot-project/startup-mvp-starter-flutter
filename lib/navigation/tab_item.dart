import 'package:flutter/material.dart';

abstract class BottomNavigationDataSource<
  TabItemState extends TabNavigatorItem
> {
  List<TabItemState> items();
  Widget tabWidget(int tabIndex, {String? additionalParam});
}

class TabNavigatorItem {
  final String name;
  final Widget icon;
  final Widget activeIcon;

  TabNavigatorItem({
    required this.activeIcon,
    required this.name,
    required this.icon,
  });
}
