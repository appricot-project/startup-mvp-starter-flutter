import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class AuthCubit extends Cubit<bool> {
  final SharedStorage sharedStorage;

  AuthCubit({required this.sharedStorage}) : super(false);

  Future<void> login({
    required String refreshToken,
    required String accessToken,
  }) async {
    debugPrint('AuthCubit login');
    await sharedStorage.setAuthorized(true);
    await sharedStorage.saveRefreshToken(refreshToken);
    await sharedStorage.saveToken(accessToken);
    emit(true);
  }

  Future<void> logout() async {
    debugPrint('AuthCubit logout');
    await sharedStorage.clearAuthData();
    await sharedStorage.setAuthorized(false);
    emit(false);
  }

  Future<void> checkAuthStatus() async {
    var isAuthorized = await sharedStorage.isAuthorized();
    emit(isAuthorized);
    return;
  }
}
