import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:startup_mvp_starter_flutter/utils/notification_center.dart';

mixin RouteVisibility<T extends StatefulWidget> on State<T> {
  /// Вызывается при активации экрана (когда он верхний)
  void didBecomeActive();

  /// Вызывается, чтобы подавить вызов didBecomeActive() при следующей активации экрана
  void suppressNextDidBecomeActive() {
    _suppressNextDidBecomeActive = true;
  }

  RouteData? _routeData;
  TabsRouter? _tabsRouter;
  bool _suppressNextDidBecomeActive = false;
  bool _didBecomeActiveCalled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _routeData = context.router.current;
      try {
        _tabsRouter = AutoTabsRouter.of(context);
      } catch (e) {
        _tabsRouter = null;
      }
      _tabsRouter?.addListener(_onTabChanged);

      NotificationCenter().subscribe(
        this,
        NotificationKey.routeChanged,
        (value) => WidgetsBinding.instance.addPostFrameCallback(
          (_) => _checkVisibility(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _tabsRouter?.removeListener(_onTabChanged);
    NotificationCenter().unsubscribe(this, NotificationKey.routeChanged);
    super.dispose();
  }

  void _onTabChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || !context.mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !context.mounted) return;

      final top = AutoRouter.of(context).root.topRoute;
      final isNowVisible = top.name == _routeData?.name;

      if (isNowVisible) {
        if (_didBecomeActiveCalled) return;
        _didBecomeActiveCalled = true;
        if (_suppressNextDidBecomeActive) {
          _suppressNextDidBecomeActive = false;
          return;
        }
        didBecomeActive();
      } else {
        _didBecomeActiveCalled = false;
      }
      return;
    });
  }
}
