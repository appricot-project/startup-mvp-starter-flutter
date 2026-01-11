part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final Loading? loading;

  ProfileState({required this.loading});

  @override
  List<Object?> get props => [loading];
}

enum Loading { initialLoading, actionLoading }

class ProfileInitial extends ProfileState {
  ProfileInitial({required super.loading});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required super.loading, required this.error});

  @override
  List<Object?> get props => [super.props, error];
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated({required super.loading});
}

class ProfileShowView extends ProfileState {
  final String key;

  ProfileShowView({required super.loading, required this.key});

  @override
  List<Object?> get props => [super.props, key];
}