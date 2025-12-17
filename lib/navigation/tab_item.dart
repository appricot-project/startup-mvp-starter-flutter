import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';

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

  factory TabNavigatorItem.fromSvg({
    required String name,
    required String icon,
  }) {
    return TabNavigatorItem(
      name: name,
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          ColorConstants.unselectedNavigation,
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          ColorConstants.selectedNavigation,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
