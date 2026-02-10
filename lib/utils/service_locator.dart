import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service_impl.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service_impl.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service_impl.dart';
import 'package:startup_mvp_starter_flutter/utils/user_document_service.dart';
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/rest_client.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage_impl.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator({
  required Flavor flavor,
  required FirebaseOptions firebaseOptions,
}) async {
  await Firebase.initializeApp(options: firebaseOptions);
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerSingleton<SharedStorage>(SharedStorageImpl());
  locator.registerSingleton<AppConfig>(AppConfig.create(flavor: flavor));
  locator.registerSingleton<RestClient>(
    RestClient(
      shared: locator<SharedStorage>(),
      appConfig: locator<AppConfig>(),
    ),
  );
  locator.registerSingleton<AuthCubit>(
    AuthCubit(sharedStorage: locator<SharedStorage>()),
  );
  locator.registerSingleton<LocalizationCubit>(
    LocalizationCubit(sharedStorage: locator<SharedStorage>()),
  );
  locator.registerSingleton<ThemeCubit>(
    ThemeCubit(sharedStorage: locator<SharedStorage>()),
  );
  locator.registerLazySingleton<UserDocumentService>(
    () => UserDocumentService(),
  );
  locator.registerSingleton<ProfileService>(
    ProfileServiceImpl(
      userDocumentService: locator<UserDocumentService>(),
    ),
  );
  await locator<AuthCubit>().checkAuthStatus();
  await locator<LocalizationCubit>().checkLocalizeStatus();
  await locator<ThemeCubit>().checkThemeStatus();
  locator.registerLazySingleton<MainService>(
    () => MainServiceImpl(
      userDocumentService: locator<UserDocumentService>(),
      sharedStorage: locator<SharedStorage>(),
    ),
  );
}
