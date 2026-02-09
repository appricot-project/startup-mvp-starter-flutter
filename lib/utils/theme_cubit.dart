import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedStorage sharedStorage;

  ThemeCubit({required this.sharedStorage}) : super(ThemeMode.system);

  Future<void> changeTheme(ThemeMode newTheme) async {
    await sharedStorage.setTheme(newTheme);
    emit(newTheme);
  }

  Future<void> checkThemeStatus() async {
    var theme = await sharedStorage.getTheme();
    emit(theme);
  }
}
