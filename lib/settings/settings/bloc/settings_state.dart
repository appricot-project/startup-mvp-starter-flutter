part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {}

enum ShowView { notifications, them, language }

class SettingsShowView extends SettingsState {
  final ShowView show;

  SettingsShowView({required this.show});

  @override
  List<Object?> get props => [super.props, show];
}
