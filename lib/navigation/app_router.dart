import 'package:auto_route/auto_route.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/page/sign_in_page.dart';
import 'package:startup_mvp_starter_flutter/auth/verification_email/page/verification_email_page.dart';
import 'package:startup_mvp_starter_flutter/main/main/page/main_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/home_shell_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/modal_bottom_sheet_autoroute.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/favourites_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/main_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/profile_tab_page.dart';
import 'package:startup_mvp_starter_flutter/navigation/wrappers/settings_tab_page.dart';
import 'package:startup_mvp_starter_flutter/profile/edit_profile/page/edit_profile_page.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/page/profile_page.dart';
import 'package:startup_mvp_starter_flutter/settings/language_settings/page/language_settings_page.dart';
import 'package:startup_mvp_starter_flutter/settings/settings/page/settings_page.dart';
import 'package:startup_mvp_starter_flutter/settings/theme_settings/page/theme_settings_page.dart';
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
            AutoRoute(path: '', page: MainRoute.page, initial: true),
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
            AutoRoute(path: '', page: ProfileRoute.page, initial: true),
            AutoRoute(path: '', page: EditProfileRoute.page),
            // ..._commonTabChildren,
          ],
        ),
        AutoRoute(
          path: 'settings',
          page: SettingsTabRoute.page,
          children: [
            AutoRoute(path: '', page: SettingsRoute.page, initial: true),
            AutoRoute(path: '', page: LanguageSettingsRoute.page),
            AutoRoute(path: '', page: ThemeSettingsRoute.page),
            // ..._commonTabChildren,
          ],
        ),
      ],
    ),

    // ModalBottomSheetAutoRoute(page: SignInRoute.page, enableDrag: false),
    ModalBottomSheetAutoRoute(
      path: '/modal/auth',
      page: ModalAuth.page,
      children: [
        AutoRoute(path: '', page: SignInRoute.page, initial: true),
        AutoRoute(path: 'verificationEmail', page: VerificationEmailRoute.page),
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
