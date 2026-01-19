part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsOnReturned extends SettingsEvent {}

enum TapItem { language, them, notifications }

class SettingsOnTapItem extends SettingsEvent {
  final TapItem tap;

  SettingsOnTapItem({required this.tap});

  @override
  List<Object?> get props => [super.props, tap];
}
