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
      switch (event.tap) {
        case TapItem.language:
          emit(SettingsShowView(show: ShowView.language));
        case TapItem.notifications:
          emit(SettingsShowView(show: ShowView.notifications));
        case TapItem.them:
          emit(SettingsShowView(show: ShowView.them));
      }
    });
  }
}
