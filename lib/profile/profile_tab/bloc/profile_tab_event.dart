part of 'profile_tab_bloc.dart';

abstract class ProfileTabEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileTabOnAppear extends ProfileTabEvent {}

class ProfileTabOnReturned extends ProfileTabEvent {}

class ProfileTabOnTapped extends ProfileTabEvent {
  final String key;

  ProfileTabOnTapped({required this.key});

  @override
  List<Object?> get props => [super.props, key];
}