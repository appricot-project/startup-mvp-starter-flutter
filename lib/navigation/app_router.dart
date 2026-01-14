import 'package:auto_route/auto_route.dart';
import 'package:startup_mvp_starter_flutter/navigation/home_shell_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/favourites_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/main_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/profile_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/settings_tab_page.dart';
import 'package:startup_mvp_starter_flutter/ui_testing_widget.dart';

part 'app_router.gr.dart';

const ModalAuth = EmptyShellRoute('ModalAuth');

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  /// Общее для всех вкладок
  // static final List<AutoRoute> _commonTabChildren = [
  // AutoRoute(path: 'product', page: ProductDetailsRoute.page),
  // ];

  @override
  List<AutoRoute> get routes => [
    // * MARK: Tabs
    AutoRoute(
      path: '/',
      page: HomeShellRoute.page,
      initial: true,
      children: [
        AutoRoute(
          path: 'main',
          page: MainTabRoute.page,
          children: [
            AutoRoute(path: '', page: UiTestingRoute.page, initial: true),
            // ..._commonTabChildren,
          ],
        ),

        AutoRoute(
          path: 'favourites',
          page: FavouritesTabRoute.page,
          children: [
            AutoRoute(path: '', page: UiTestingRoute.page, initial: true),
            // ..._commonTabChildren,
          ],
        ),
        AutoRoute(
          path: 'profile',
          page: ProfileTabRoute.page,
          children: [
            AutoRoute(path: '', page: ProfileTabRoute.page, initial: true),
            // ..._commonTabChildren,
          ],
        ),
        AutoRoute(
          path: 'settings',
          page: SettingsTabRoute.page,
          children: [
            AutoRoute(path: '', page: UiTestingRoute.page, initial: true),
            // ..._commonTabChildren,
          ],
        ),
      ],
    ),

    // * MARK: Modals
    // ModalBottomSheetAutoRoute(page: SelectCityRoute.page, enableDrag: false),

    // ModalBottomSheetAutoRoute(
    //   path: '/modal/auth',
    //   page: ModalAuth.page,
    //   children: [
    //     AutoRoute(path: '', page: SignInRoute.page, initial: true),
    //     AutoRoute(path: 'confirmation', page: SmsConfirmationRoute.page),
    //     AutoRoute(path: 'agreements', page: ArticleDetailsRoute.page),
    //   ],
    // ),
  ];
}
