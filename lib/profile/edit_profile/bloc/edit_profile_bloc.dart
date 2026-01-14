import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_tab/models/profile_info.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileService profileService;
  Map<String, String> textFieldsErrors = {};
  Loading? loading = Loading.initialLoading;
  ProfileInfo? profileInfo;

  EditProfileBloc({required this.profileService})
    : super(
        EditProfileInitial(
          loading: Loading.initialLoading,
          textFieldsErrors: {},
          profileInfo: null,
        ),
      ) {
    on<EditProfileOnAppear>((event, emit) async {
      var profile = await profileService.getProfile();
      loading = null;
      profile.fold(
        (l) {
          emit(
            EditProfileError(
              loading: loading,
              error: l.message,
              textFieldsErrors: Map<String, String>.from(textFieldsErrors),
              profileInfo: profileInfo,
            ),
          );
        },
        (r) {
          if (r != null) {
            profileInfo = ProfileInfo.fromDto(r);
          }
          emit(
            EditProfileUpdatedUserInfo(
              loading: loading,
              textFieldsErrors: textFieldsErrors,
              profileInfo: profileInfo,
            ),
          );
        },
      );
    });
    on<EditProfileOnBackButtonTapped>((event, emit) {
      emit(
        EditProfileBack(
          loading: loading,
          textFieldsErrors: Map<String, String>.from(textFieldsErrors),
          profileInfo: profileInfo,
        ),
      );
    });
    on<EditProfileOnButtonTapped>((event, emit) async {
      var date = event.fields['date'];
      var dateValid = validate('date', date ?? '');
      updating(emit);
      if (dateValid) {
        loading = Loading.actionLoading;
        updating(emit);
        DateTime? birthdayConverted;
        if (date != '' && date != null) {
          birthdayConverted = DateFormat('dd.MM.yyyy').parse(date);
        }
        var response = await profileService.sendProfile(
          name: event.fields['name'],
          phone: event.fields['phonee'],
          birthday: birthdayConverted,
        );
        loading = null;
        response.fold(
          (l) {
            emit(
              EditProfileError(
                loading: loading,
                error: l.message,
                textFieldsErrors: Map<String, String>.from(textFieldsErrors),
                profileInfo: profileInfo,
              ),
            );
          },
          (r) {
            emit(
              EditProfileBack(
                loading: loading,
                textFieldsErrors: Map<String, String>.from(textFieldsErrors),
                profileInfo: profileInfo,
              ),
            );
          },
        );
      }
    });
    on<EditProfileOnTextChanged>((event, emit) {
      if (event.newValue is DateTime) {
        validate(event.key, DateFormat("dd.MM.yyyy").format(event.newValue));
      } else {
        validate(event.key, event.newValue);
      }
      updating(emit);
    });
  }

  void updating(Emitter<EditProfileState> emit) {
    emit(
      EditProfileUpdated(
        loading: loading,
        textFieldsErrors: Map<String, String>.from(textFieldsErrors),
        profileInfo: profileInfo,
      ),
    );
  }

  bool validate(String key, String value) {
    switch (key) {
      case 'date':
        if (value == '') {
          textFieldsErrors[key] = '';
          return true;
        }
        if (value.length < 10) {
          textFieldsErrors[key] = 'requiredField';
          return false;
        }
        if (DateFormat('dd.MM.yyyy').format(DateTime.now()) == value) {
          textFieldsErrors[key] = 'errorBirthdayCuttent';
          return false;
        }
        if (DateFormat('dd.MM.yyyy').parse(value).isAfter(DateTime.now())) {
          textFieldsErrors[key] = 'errorBirthdayGreater';
          return false;
        }
        textFieldsErrors[key] = '';
        return true;
      default:
        return false;
    }
  }
}
