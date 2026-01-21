import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsOnReturned>((event, emit) {
      emit(SettingsUpdated());
    });
    on<SettingsOnTapItem>((event, emit) {
      switch (event.key) {
        case ActionKey.language:
          emit(SettingsShowView(key: ViewKey.language));
        case ActionKey.notifications:
          emit(SettingsShowView(key: ViewKey.notifications));
        case ActionKey.theme:
          emit(SettingsShowView(key: ViewKey.theme));
      }
    });
  }
}
