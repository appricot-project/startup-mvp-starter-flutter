import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/navigation/bottom_navigation.dart';
import 'package:startup_mvp_starter_flutter/navigation/tab_item.dart';
import 'package:startup_mvp_starter_flutter/navigation/tab_navigator.dart';

class HomePage<TabItem extends TabNavigatorItem> extends StatefulWidget {
  final BottomNavigationDataSource<TabItem> delegate;

  HomePage({super.key, required this.delegate});

  @override
  State<HomePage> createState() => _HomePageState(delegate);
}

class _HomePageState<TabItem extends TabNavigatorItem> extends State<HomePage>
    with WidgetsBindingObserver {
  BottomNavigationDataSource<TabItem> _delegate;

  _HomePageState(this._delegate);

  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  int _currentTab = 0;
  Map<TabItem, String> _additionalParams = {};
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = _delegate
        .items()
        .map((_) => GlobalKey<NavigatorState>())
        .toList();
    // WidgetsBinding.instance.addObserver(this);
    // NotificationCenter().subscribe('internalDeepLink', (value) {
    //   if (value is String) {
    //     _processingDeepLink(DeepLinkModel(
    //       value: value,
    //       type: DeepLinkType.app,
    //     ));
    //   }
    // });
    // DeepLinksService.shared.deepLinkStream
    //     .listen((deepLink) => _processingDeepLink(deepLink));
    // FirebaseHelper.shared.deepLinkStream
    //     .listen((deepLink) => _processingDeepLink(deepLink));
    // _checkInitialDeepLink();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // NotificationCenter().unsubscribe('internalDeepLink');
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final newValue = bottomInset > 10;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  _selectTab(
    int tabItemIndex, {
    Map<TabItem, String> additionalParams = const {},
  }) {
    _additionalParams = additionalParams;
    if (tabItemIndex == _currentTab) {
      _navigatorKeys[tabItemIndex].currentState!.popUntil(
        (route) => route.isFirst,
      );
    } else {
      setState(() => _currentTab = tabItemIndex);
    }
  }

  // void _processingDeepLink(DeepLinkModel deepLink) async {
  //   switch (deepLink.type) {
  //     case DeepLinkType.category:
  //       if (_currentTab == TabItem.menu) {
  //         NotificationCenter().notify('category', data: deepLink.value);
  //       } else {
  //         _selectTab(
  //           TabItem.menu,
  //           additionalParams: {TabItem.menu: 'category=${deepLink.value}'},
  //         );
  //       }
  //     case DeepLinkType.product:
  //       final SelectedAddressModel? selectedAddress =
  //           await Shared.getSelectedAddress();
  //       if (selectedAddress == null) {
  //         Future.delayed(Duration.zero, () {
  //           Navigator.of(context, rootNavigator: true).push(
  //             SlideFromBottomRoute(
  //               page: SelectAddressPage(),
  //             ),
  //           );
  //         });
  //       } else {
  //         showMyModalBottomSheet(
  //           context: context,
  //           useRootNavigator: true,
  //           widget: ProductDetailsPage(
  //             productId: deepLink.value,
  //           ),
  //         );
  //       }
  //     case DeepLinkType.app:
  //       switch (deepLink.value) {
  //         case 'goOnBag':
  //           _selectTab(TabItem.basket);
  //         case 'goOnOrderDetails':
  //           _selectTab(
  //             TabItem.menu,
  //             additionalParams: {TabItem.menu: 'showOrderTracking'},
  //           );
  //         case 'goOnMenu':
  //           _selectTab(TabItem.menu);
  //         default:
  //           break;
  //       }
  //     case DeepLinkType.orderTracking:
  //       if (deepLink.value.isNotEmpty) {
  //         try {
  //           int orderNo = int.parse(deepLink.value);
  //           showMyModalBottomSheet(
  //             context: context,
  //             useRootNavigator: true,
  //             widget: OrderTrackingPage(
  //               orderNo: orderNo,
  //               isPossibleRepeat: false,
  //             ),
  //           );
  //         } catch (e) {
  //           print(e);
  //         }
  //       }
  //     case DeepLinkType.unknown:
  //   }
  // }

  // _checkInitialDeepLink() async {
  //   DeepLinkModel? deepLink = await Shared.getInitialDeepLink();
  //   if (deepLink != null) {
  //     _processingDeepLink(deepLink);
  //     Shared.deleteInitialDeepLink();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(_delegate.items());
    return Scaffold(
      // backgroundColor: ColorConstants.mainWhite,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(children: <Widget>[_buildOffstageNavigator(_currentTab)]),
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(
        currentTabIndex: _currentTab,
        onSelectTab: _selectTab,
        tabs: _delegate.items(),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return TabNavigator(
      navigatorKey: _navigatorKeys[index],
      tabItemWidget: _delegate.tabWidget(index),
      additionalParams: _additionalParams,
    );
  }
}
