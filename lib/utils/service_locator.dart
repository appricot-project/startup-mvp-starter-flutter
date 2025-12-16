import 'package:get_it/get_it.dart';
import 'package:startup_mvp_starter_flutter/utils/app_config.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/rest_client.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage_impl.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator({required Flavor flavor}) async {
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
  await locator<AuthCubit>().checkAuthStatus();
}
