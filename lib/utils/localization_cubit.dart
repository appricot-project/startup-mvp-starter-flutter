import 'package:bloc/bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';
import 'dart:ui' as ui;

class LocalizationCubit extends Cubit<String?> {
  final SharedStorage sharedStorage;

  LocalizationCubit({required this.sharedStorage}) : super(null);

  Future<void> changeLanguage() async {
    String localeCode = '';
    if (state == null) {
      localeCode = ui.PlatformDispatcher.instance.locale.languageCode;
    }
    if (state == 'en') {
      localeCode = 'ru';
    } else {
      localeCode = 'en';
    }
    await sharedStorage.setLocale(localeCode);
    emit(localeCode);
  }

  Future<void> checkLocalizeStatus() async {
    var localeCode = await sharedStorage.getLocale();
    emit(localeCode);
  }
}
