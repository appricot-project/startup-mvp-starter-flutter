import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/models/notification_model.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';

part 'notification_list_event.dart';
part 'notification_list_state.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  final ProfileService profileService;
  List<NotificationModel> notifications = [];
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  Loading? loading = Loading.initialLoading;

  NotificationListBloc({required this.profileService})
    : super(
        NotificationListInitial(
          loading: Loading.initialLoading,
          notifications: [],
          hasMore: true,
        ),
      ) {
    on<NotificationListOnAppear>((event, emit) async {
      lastDocument = null;
      notifications = [];
      hasMore = true;
      await _loadData(emit);
      _updating(emit);
    });
    on<NotificationListOnPullToRefresh>((event, emit) {
      loading = Loading.refresh;
      _updating(emit);
      add(NotificationListOnAppear());
    });
    on<NotificationListOnLoadMore>((event, emit) async {
      loading = Loading.moreLoading;
      _updating(emit);
      await _loadData(emit);
      _updating(emit);
    });
  }

  _loadData(Emitter<NotificationListState> emit) async {
    if (!hasMore) return;
    final response = await profileService.getNotifications(
      lastDocument: lastDocument,
    );
    loading = null;
    response.fold(
      (l) {
        emit(
          NotificationListError(
            loading: loading,
            error: l.message,
            notifications: notifications,
            hasMore: hasMore,
          ),
        );
      },
      (r) {
        notifications.addAll(r?.notifications ?? []);
        lastDocument = r?.lastDocument;
        hasMore = r?.hasMore ?? false;
      },
    );
  }

  _updating(Emitter<NotificationListState> emit) {
    emit(
      NotificationListUpdated(
        loading: loading,
        notifications: List<NotificationModel>.from(notifications),
        hasMore: hasMore,
      ),
    );
  }
}
