import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

part 'language_settings_event.dart';
part 'language_settings_state.dart';

class LanguageSettingsBloc
    extends Bloc<LanguageSettingsEvent, LanguageSettingsState> {
  Language language = Language.ru;

  LanguageSettingsBloc()
    : super(LanguageSettingsInitial(language: Language.ru)) {
    on<LanguageSettingsOnAppear>((event, emit) async {
      switch (locator<LocalizationCubit>().state) {
        case 'en':
          language = Language.en;
        case 'ru':
          language = Language.ru;
      }
      _updating(emit);
    });
    on<LanguageSettingsOnChangedLanguage>((event, emit) {
      language = event.newLanguage;
      _updating(emit);
    });
    on<LanguageSettingsOnApply>((event, emit) {
      locator<LocalizationCubit>().changeLocalize(localeCode());
    });
  }

  _updating(Emitter<LanguageSettingsState> emit) {
    emit(LanguageSettingsUpdated(language: language));
  }

  String localeCode() {
    switch (language) {
      case Language.en:
        return 'en';
      case Language.ru:
        return 'ru';
    }
  }
}
