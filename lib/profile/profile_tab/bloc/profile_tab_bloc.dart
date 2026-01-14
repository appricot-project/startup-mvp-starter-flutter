import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/models/profile_info.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

part 'profile_tab_event.dart';
part 'profile_tab_state.dart';

class ProfileBloc extends Bloc<ProfileTabEvent, ProfileTabState> {
  ProfileService profileService;
  Loading? loading;
  ProfileInfo? profile;

  ProfileBloc({required this.profileService})
    : super(ProfileTabInitial(loading: null, profile: null)) {
    on<ProfileTabOnAppear>((event, emit) async {
      if (locator<AuthCubit>().state) {
        loading = Loading.initialLoading;
        _updating(emit);
        var response = await profileService.getProfile();
        loading = null;
        response.fold(
          (l) {
            emit(
              ProfileTabError(
                loading: loading,
                error: l.message,
                profile: profile,
              ),
            );
          },
          (r) {
            if (r != null) {
              profile = ProfileInfo.fromDto(r);
            }
            _updating(emit);
          },
        );
      }
    });
    on<ProfileTabOnReturned>((event, emit) {
      _updating(emit);
    });
    on<ProfileTabOnTapped>((event, emit) async {
      switch (event.key) {
        case 'signIn':
          emit(
            ProfileTabShowView(
              loading: loading,
              key: event.key,
              profile: profile,
            ),
          );
        case 'logoutAlert':
          emit(
            ProfileTabShowView(
              loading: loading,
              key: event.key,
              profile: profile,
            ),
          );
        case 'logout':
          await locator<AuthCubit>().logout();
          add(ProfileTabOnAppear());
        case 'editProfile':
          emit(
            ProfileTabShowView(
              loading: loading,
              key: event.key,
              profile: profile,
            ),
          );
      }
    });
  }

  _updating(Emitter<ProfileTabState> emit) {
    emit(ProfileTabUpdated(loading: loading, profile: profile));
  }
}
