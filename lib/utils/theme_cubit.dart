import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

enum CustomTheme { light, dark, system }

class ThemeCubit extends Cubit<CustomTheme> {
  final SharedStorage sharedStorage;

  ThemeCubit({required this.sharedStorage}) : super(CustomTheme.light);

  Future<void> changeTheme(CustomTheme newTheme) async {
    switch (newTheme) {
      case CustomTheme.light:
        await sharedStorage.setThemeIsDark(false);
      case CustomTheme.dark:
        await sharedStorage.setThemeIsDark(true);
      case CustomTheme.system:
        await sharedStorage.setThemeIsDark(null);
    }
    await checkThemeStatus();
  }

  Future<void> checkThemeStatus() async {
    var theme = await sharedStorage.getThemeIsDark();
    if (theme == null) {
      emit(CustomTheme.system);
    } else if (theme == true) {
      emit(CustomTheme.dark);
    } else {
      emit(CustomTheme.light);
    }
  }

  Brightness brightness() {
    switch (state) {
      case CustomTheme.dark:
        return Brightness.dark;
      case CustomTheme.light:
        return Brightness.light;
      case CustomTheme.system:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}
