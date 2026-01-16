// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return EditProfilePage();
    },
  );
}

/// generated route for
/// [FavouritesTabPage]
class FavouritesTabRoute extends PageRouteInfo<void> {
  const FavouritesTabRoute({List<PageRouteInfo>? children})
    : super(FavouritesTabRoute.name, initialChildren: children);

  static const String name = 'FavouritesTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouritesTabPage();
    },
  );
}

/// generated route for
/// [HomeShellPage]
class HomeShellRoute extends PageRouteInfo<void> {
  const HomeShellRoute({List<PageRouteInfo>? children})
    : super(HomeShellRoute.name, initialChildren: children);

  static const String name = 'HomeShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeShellPage();
    },
  );
}

/// generated route for
/// [MainTabPage]
class MainTabRoute extends PageRouteInfo<void> {
  const MainTabRoute({List<PageRouteInfo>? children})
    : super(MainTabRoute.name, initialChildren: children);

  static const String name = 'MainTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainTabPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [ProfileTabPage]
class ProfileTabRoute extends PageRouteInfo<void> {
  const ProfileTabRoute({List<PageRouteInfo>? children})
    : super(ProfileTabRoute.name, initialChildren: children);

  static const String name = 'ProfileTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileTabPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return SettingsPage();
    },
  );
}

/// generated route for
/// [SettingsTabPage]
class SettingsTabRoute extends PageRouteInfo<void> {
  const SettingsTabRoute({List<PageRouteInfo>? children})
    : super(SettingsTabRoute.name, initialChildren: children);

  static const String name = 'SettingsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsTabPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return SignInPage();
    },
  );
}

/// generated route for
/// [UiTestingPage]
class UiTestingRoute extends PageRouteInfo<void> {
  const UiTestingRoute({List<PageRouteInfo>? children})
    : super(UiTestingRoute.name, initialChildren: children);

  static const String name = 'UiTestingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return UiTestingPage();
    },
  );
}

/// generated route for
/// [VerificationEmailPage]
class VerificationEmailRoute extends PageRouteInfo<VerificationEmailRouteArgs> {
  VerificationEmailRoute({
    required String gmail,
    required Duration expireIn,
    List<PageRouteInfo>? children,
  }) : super(
         VerificationEmailRoute.name,
         args: VerificationEmailRouteArgs(gmail: gmail, expireIn: expireIn),
         initialChildren: children,
       );

  static const String name = 'VerificationEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationEmailRouteArgs>();
      return VerificationEmailPage(gmail: args.gmail, expireIn: args.expireIn);
    },
  );
}

class VerificationEmailRouteArgs {
  const VerificationEmailRouteArgs({
    required this.gmail,
    required this.expireIn,
  });

  final String gmail;

  final Duration expireIn;

  @override
  String toString() {
    return 'VerificationEmailRouteArgs{gmail: $gmail, expireIn: $expireIn}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerificationEmailRouteArgs) return false;
    return gmail == other.gmail && expireIn == other.expireIn;
  }

  @override
  int get hashCode => gmail.hashCode ^ expireIn.hashCode;
}
