part of 'theme_settings_bloc.dart';

abstract class ThemeSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ThemeSettingsOnApply extends ThemeSettingsEvent {}

class ThemeSettingsOnChangedTheme extends ThemeSettingsEvent {
  final ThemeMode newTheme;

  ThemeSettingsOnChangedTheme({required this.newTheme});

  @override
  List<Object?> get props => [super.props, newTheme];
}
