import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/notification_center.dart';

class MyRouterObserver extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    NotificationCenter().notify(NotificationKey.routeChanged);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    NotificationCenter().notify(NotificationKey.routeChanged);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    NotificationCenter().notify(NotificationKey.routeChanged);
  }
}
