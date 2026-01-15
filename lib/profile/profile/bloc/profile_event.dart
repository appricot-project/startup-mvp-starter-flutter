part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileOnAppear extends ProfileEvent {}

class ProfileOnReturned extends ProfileEvent {}

class ProfileOnTapped extends ProfileEvent {
  final String key;

  ProfileOnTapped({required this.key});

  @override
  List<Object?> get props => [super.props, key];
}
