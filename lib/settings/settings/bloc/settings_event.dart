part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsOnReturned extends SettingsEvent {}

enum ActionKey { language, them, notifications }

class SettingsOnTapItem extends SettingsEvent {
  final ActionKey key;

  SettingsOnTapItem({required this.key});

  @override
  List<Object?> get props => [super.props, key];
}
