part of 'notification_settings_bloc.dart';

abstract class NotificationSettingsEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NotificationSettingsOnAppear extends NotificationSettingsEvent {}

class NotificationSettingsOnChanged extends NotificationSettingsEvent {

  final bool value;

  NotificationSettingsOnChanged({required this.value});

  @override
  List<Object?> get props => [super.props, value];
}
