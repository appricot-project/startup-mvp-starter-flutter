part of 'notification_list_bloc.dart';

abstract class NotificationListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationListOnAppear extends NotificationListEvent {}

class NotificationListOnPullToRefresh extends NotificationListEvent {}

class NotificationListOnLoadMore extends NotificationListEvent {}