part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  final Loading? loading;
  final Map<String, String> textFieldsErrors;
  final ProfileInfo? profileInfo;

  const EditProfileState({
    required this.loading,
    required this.textFieldsErrors,
    required this.profileInfo,
  });

  @override
  List<Object?> get props => [
    loading,
    textFieldsErrors,
    profileInfo,
  ];
}

enum Loading { initialLoading, actionLoading }

final class EditProfileInitial extends EditProfileState {
  const EditProfileInitial({
    required super.loading,
    required super.textFieldsErrors,
    required super.profileInfo,
  });
}

final class EditProfileBack extends EditProfileState {
  const EditProfileBack({
    required super.loading,
    required super.textFieldsErrors,
    required super.profileInfo,
  });
}

final class EditProfileUpdated extends EditProfileState {
  const EditProfileUpdated({
    required super.loading,
    required super.textFieldsErrors,
    required super.profileInfo,
  });
}

final class EditProfileUpdatedUserInfo extends EditProfileState {
  const EditProfileUpdatedUserInfo({
    required super.loading,
    required super.textFieldsErrors,
    required super.profileInfo,
  });
}

final class EditProfileError extends EditProfileState {
  final String error;

  const EditProfileError({
    required super.loading,
    required this.error,
    required super.textFieldsErrors,
    required super.profileInfo,
  });

  @override
  List<Object> get props => [super.props, error];
}
