part of 'notification_settings_bloc.dart';

abstract class NotificationSettingsState extends Equatable {
  final bool notificationEnabled;

  NotificationSettingsState({required this.notificationEnabled});

  @override
  List<Object?> get props => [notificationEnabled];
}

enum Notification { on, off }

class NotificationSettingsInitial extends NotificationSettingsState {
  NotificationSettingsInitial({required super.notificationEnabled});
}

class NotificationSettingsUpdated extends NotificationSettingsState {
  NotificationSettingsUpdated({required super.notificationEnabled});
}

enum ViewKey { deviceSettings }

class NotificationSettingsShowView extends NotificationSettingsState {
  final ViewKey key;

  NotificationSettingsShowView({
    required super.notificationEnabled,
    required this.key,
  });

  @override
  List<Object?> get props => [super.props, key];
}
