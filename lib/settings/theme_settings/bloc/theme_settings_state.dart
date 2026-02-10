part of 'theme_settings_bloc.dart';

abstract class ThemeSettingsState extends Equatable {
  final ThemeMode theme;

  ThemeSettingsState({required this.theme});

  @override
  List<Object?> get props => [theme];
}

class ThemeSettingsInitial extends ThemeSettingsState {
  ThemeSettingsInitial({required super.theme});
}

class ThemeSettingsUpdated extends ThemeSettingsState {
  ThemeSettingsUpdated({required super.theme});
}
