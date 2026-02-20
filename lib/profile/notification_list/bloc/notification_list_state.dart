part of 'notification_list_bloc.dart';

abstract class NotificationListState extends Equatable {
  final Loading? loading;
  final List<NotificationModel> notifications;
  final bool hasMore;

  NotificationListState({
    required this.loading,
    required this.notifications,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [loading, notifications, hasMore];
}

enum Loading { initialLoading, refresh, moreLoading }

class NotificationListInitial extends NotificationListState {
  NotificationListInitial({
    required super.loading,
    required super.notifications,
    required super.hasMore
  });
}

class NotificationListUpdated extends NotificationListState {
  NotificationListUpdated({
    required super.loading,
    required super.notifications,
    required super.hasMore
  });
}

class NotificationListError extends NotificationListState {
  final String error;

  NotificationListError({
    required super.loading,
    required this.error,
    required super.notifications,
    required super.hasMore
  });
}
