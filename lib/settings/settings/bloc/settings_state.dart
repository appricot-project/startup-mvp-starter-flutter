part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {}

enum ViewKey { notifications, them, language }

class SettingsShowView extends SettingsState {
  final ViewKey key;

  SettingsShowView({required this.key});

  @override
  List<Object?> get props => [super.props, ViewKey];
}
