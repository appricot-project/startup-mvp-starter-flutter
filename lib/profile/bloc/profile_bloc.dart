import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Loading? loading;

  ProfileBloc() : super(ProfileInitial(loading: Loading.initialLoading)) {
    on<ProfileOnAppear>((event, emit) async {
      await Future.delayed(Duration(seconds: 1));
      loading = null;
      _updating(emit);
    });
    on<ProfileOnReturned>((event, emit) {});
    on<ProfileOnTapped>((event, emit) {
      emit(ProfileShowView(loading: loading, key: event.key));
    });
  }

  _updating(Emitter<ProfileState> emit) {
    emit(ProfileUpdated(loading: loading));
  }
}
