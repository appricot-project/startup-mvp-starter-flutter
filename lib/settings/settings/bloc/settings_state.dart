part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {}

class SettingsShowView extends SettingsState {
  final String key;

  SettingsShowView({required this.key});

  @override
  List<Object?> get props => [super.props, key];
}
