part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileOnAppear extends ProfileEvent {}

class ProfileOnReturned extends ProfileEvent {}

enum ActionKey { logout, signIn, logoutAlert, editProfile, notificationList }

class ProfileOnTapped extends ProfileEvent {
  final ActionKey key;

  ProfileOnTapped({required this.key});

  @override
  List<Object?> get props => [super.props, key];
}
