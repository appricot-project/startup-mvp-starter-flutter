import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

enum CustomTheme { light, dark, system }

class ThemeState extends Equatable {
  final Brightness brightness;
  final CustomTheme theme;

  ThemeState({required this.brightness, required this.theme});

  @override
  List<Object?> get props => [brightness, theme];
}

class ThemeCubit extends Cubit<ThemeState> {
  final SharedStorage sharedStorage;

  ThemeCubit({required this.sharedStorage})
    : super(ThemeState(brightness: Brightness.light, theme: CustomTheme.light));

  Future<void> changeTheme({
    CustomTheme? newTheme,
    Brightness? brightness,
  }) async {
    if (newTheme != null) {
      await sharedStorage.setTheme(newTheme);
      emit(_setupState(newTheme, brightness: brightness));
    } else {
      emit(_setupState(state.theme, brightness: brightness));
    }
  }

  Future<void> checkThemeStatus() async {
    var theme = await sharedStorage.getTheme();
    emit(_setupState(theme));
  }

  ThemeState _setupState(CustomTheme theme, {Brightness? brightness}) {
    switch (theme) {
      case CustomTheme.light:
        return ThemeState(brightness: Brightness.light, theme: theme);
      case CustomTheme.dark:
        return ThemeState(brightness: Brightness.dark, theme: theme);
      case CustomTheme.system:
        return ThemeState(
          brightness:
              brightness ??
              SchedulerBinding.instance.platformDispatcher.platformBrightness,
          theme: theme,
        );
    }
  }
}
