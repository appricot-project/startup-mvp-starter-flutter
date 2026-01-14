part of 'profile_tab_bloc.dart';

abstract class ProfileTabState extends Equatable {
  final Loading? loading;
  final ProfileInfo? profile;

  ProfileTabState({required this.loading, required this.profile});

  @override
  List<Object?> get props => [loading, profile];
}

enum Loading { initialLoading, actionLoading }

class ProfileTabInitial extends ProfileTabState {
  ProfileTabInitial({required super.loading, required super.profile});
}

class ProfileTabError extends ProfileTabState {
  final String error;

  ProfileTabError({
    required super.loading,
    required this.error,
    required super.profile,
  });

  @override
  List<Object?> get props => [super.props, error];
}

class ProfileTabUpdated extends ProfileTabState {
  ProfileTabUpdated({required super.loading, required super.profile});
}

class ProfileTabShowView extends ProfileTabState {
  final String key;

  ProfileTabShowView({
    required super.loading,
    required this.key,
    required super.profile,
  });

  @override
  List<Object?> get props => [super.props, key];
}
