part of 'notification_list_bloc.dart';

abstract class NotificationListState extends Equatable {
  final Loading? loading;
  final List<NotificationModel> notifications;

  NotificationListState({required this.loading, required this.notifications});

  @override
  List<Object?> get props => [loading, notifications];
}

enum Loading { initialLoading }

class NotificationListInitial extends NotificationListState {
  NotificationListInitial({
    required super.loading,
    required super.notifications,
  });
}

class NotificationListUpdated extends NotificationListState {
  NotificationListUpdated({
    required super.loading,
    required super.notifications,
  });
}

class NotificationListError extends NotificationListState {
  final String error;

  NotificationListError({
    required super.loading,
    required this.error,
    required super.notifications,
  });
}
