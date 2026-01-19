part of 'language_settings_bloc.dart';

abstract class LanguageSettingsState extends Equatable {
  final Language language;

  LanguageSettingsState({required this.language});

  @override
  List<Object?> get props => [language];
}

enum Language { en, ru }

class LanguageSettingsInitial extends LanguageSettingsState {
  LanguageSettingsInitial({required super.language});
}

class LanguageSettingsUpdated extends LanguageSettingsState {
  LanguageSettingsUpdated({required super.language});
}