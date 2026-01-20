part of 'language_settings_bloc.dart';

abstract class LanguageSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LanguageSettingsOnAppear extends LanguageSettingsEvent {}

class LanguageSettingsOnReturned extends LanguageSettingsEvent {}

class LanguageSettingsOnApply extends LanguageSettingsEvent {}

class LanguageSettingsOnChangedLanguage extends LanguageSettingsEvent {
  final Language newLanguage;

  LanguageSettingsOnChangedLanguage({required this.newLanguage});

  @override
  List<Object?> get props => [super.props, newLanguage];
}
