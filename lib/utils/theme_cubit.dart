import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class ThemeCubit extends Cubit<Brightness> {
  final SharedStorage sharedStorage;

  ThemeCubit({required this.sharedStorage}) : super(Brightness.light);

  Future<void> changeTheme(Brightness newTheme) async {
    await sharedStorage.setThemeIsDark(newTheme == Brightness.dark);
    emit(newTheme);
  }

  Future<void> checkThemeStatus() async {
    var theme = await sharedStorage.getThemeIsDark();
    if (theme == null) {
      emit(SchedulerBinding.instance.platformDispatcher.platformBrightness);
    } else if (theme == true) {
      emit(Brightness.dark);
    } else {
      emit(Brightness.light);
    }
  }
}
