import 'package:bloc/bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';
import 'dart:ui' as ui;

class LocalizationCubit extends Cubit<String> {
  final SharedStorage sharedStorage;

  LocalizationCubit({required this.sharedStorage}) : super("en");

  Future<void> changeLocalize(String newLocaleCode) async {
    await sharedStorage.setLocale(newLocaleCode);
    emit(newLocaleCode);
  }

  Future<void> checkLocalizeStatus() async {
    var localeCode = await sharedStorage.getLocale();
    if (localeCode == null) {
      localeCode = ui.PlatformDispatcher.instance.locale.languageCode;
      sharedStorage.setLocale(localeCode);
    }
    emit(localeCode);
  }
}
