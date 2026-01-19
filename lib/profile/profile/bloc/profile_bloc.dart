import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/profile/models/profile_info.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/auth_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileService profileService;
  Loading? loading;
  ProfileInfo? profile;

  ProfileBloc({required this.profileService})
    : super(ProfileInitial(loading: null, profile: null)) {
    on<ProfileOnAppear>((event, emit) async {
      _updating(emit);
      if (locator<AuthCubit>().state) {
        loading = Loading.initialLoading;
        _updating(emit);
        var response = await profileService.getProfile();
        loading = null;
        response.fold(
          (l) {
            emit(
              ProfileError(
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
    on<ProfileOnReturned>((event, emit) {
      _updating(emit);
    });
    on<ProfileOnTapped>((event, emit) async {
      switch (event.key) {
        case ActionKey.signIn:
          emit(
            ProfileShowView(
              loading: loading,
              key: ViewKey.signIn,
              profile: profile,
            ),
          );
        case ActionKey.logoutAlert:
          emit(
            ProfileShowView(
              loading: loading,
              key: ViewKey.logoutAlert,
              profile: profile,
            ),
          );
        case ActionKey.logout:
          await locator<AuthCubit>().logout();
          add(ProfileOnAppear());
        case ActionKey.editProfile:
          emit(
            ProfileShowView(
              loading: loading,
              key: ViewKey.editProfile,
              profile: profile,
            ),
          );
      }
    });
  }

  _updating(Emitter<ProfileState> emit) {
    emit(ProfileUpdated(loading: loading, profile: profile));
  }
}
