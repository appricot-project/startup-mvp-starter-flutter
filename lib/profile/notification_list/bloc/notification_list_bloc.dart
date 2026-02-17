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
  Loading? loading = Loading.initialLoading;

  NotificationListBloc({required this.profileService})
    : super(
        NotificationListInitial(
          loading: Loading.initialLoading,
          notifications: [],
        ),
      ) {
    on<NotificationListOnAppear>((event, emit) async {
      var response = await profileService.getNotifications();
      loading = null;
      response.fold(
        (l) {
          emit(
            NotificationListError(
              loading: loading,
              error: l.message,
              notifications: notifications,
            ),
          );
        },
        (r) {
          notifications = r ?? [];
          _updating(emit);
        },
      );
    });
    on<NotificationListOnPullToRefresh>((event, emit) {
      loading = Loading.refresh;
      _updating(emit);
      add(NotificationListOnAppear());
    });
  }
  _updating(Emitter<NotificationListState> emit) {
    emit(
      NotificationListUpdated(
        loading: loading,
        notifications: List<NotificationModel>.from(notifications),
      ),
    );
  }
}
