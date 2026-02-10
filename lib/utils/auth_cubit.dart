import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:startup_mvp_starter_flutter/auth/auth_service/auth_service.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class AuthCubit extends Cubit<bool> {
  final SharedStorage sharedStorage;

  AuthCubit({required this.sharedStorage}) : super(false);

  Future<void> login() async {
    debugPrint('AuthCubit login');
    // await sharedStorage.setAuthorized(true);
    emit(true);
  }

  Future<void> logout() async {
    debugPrint('AuthCubit logout');
    await locator<AuthService>().signOut();
    // await sharedStorage.clearAuthData();
    // await sharedStorage.setAuthorized(false);
    emit(false);
  }

  Future<void> checkAuthStatus() async {
    try {
      final isAuthorized = FirebaseAuth.instance.currentUser != null;
      // await sharedStorage.setAuthorized(isAuthorized);
      emit(isAuthorized);
    } catch (e) {
      debugPrint('checkAuthStatus error: $e');
      // final isAuthorized = await sharedStorage.isAuthorized();
      emit(false);
    }
  }
}
