import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';

part 'theme_settings_event.dart';
part 'theme_settings_state.dart';

class ThemeSettingsBloc extends Bloc<ThemeSettingsEvent, ThemeSettingsState> {
  ThemeMode theme = locator<ThemeCubit>().state;

  ThemeSettingsBloc()
    : super(ThemeSettingsInitial(theme: locator<ThemeCubit>().state)) {
    on<ThemeSettingsOnChangedTheme>((event, emit) {
      theme = event.newTheme;
      emit(ThemeSettingsUpdated(theme: theme));
    });
    on<ThemeSettingsOnApply>((event, emit) {
      locator<ThemeCubit>().changeTheme(theme);
    });
  }
}
