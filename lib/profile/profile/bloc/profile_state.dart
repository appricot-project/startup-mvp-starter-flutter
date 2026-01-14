part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final Loading? loading;
  final ProfileInfo? profile;

  ProfileState({required this.loading, required this.profile});

  @override
  List<Object?> get props => [loading, profile];
}

enum Loading { initialLoading, actionLoading }

class ProfileInitial extends ProfileState {
  ProfileInitial({required super.loading, required super.profile});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({
    required super.loading,
    required this.error,
    required super.profile,
  });

  @override
  List<Object?> get props => [super.props, error];
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated({required super.loading, required super.profile});
}

class ProfileShowView extends ProfileState {
  final String key;

  ProfileShowView({
    required super.loading,
    required this.key,
    required super.profile,
  });

  @override
  List<Object?> get props => [super.props, key];
}
