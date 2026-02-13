import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_settings_event.dart';
part 'notification_settings_state.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  bool notificationEnabled = false;
  NotificationSettingsBloc()
    : super(NotificationSettingsInitial(notificationEnabled: false)) {
    on<NotificationSettingsOnAppear>((event, emit) async {
      NotificationSettings settings = await FirebaseMessaging.instance
          .getNotificationSettings();
      notificationEnabled =
          (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional);
      _updating(emit);
    });
    on<NotificationSettingsOnChanged>((event, emit) async {
      if (!event.value) {
        emit(
          NotificationSettingsShowView(
            notificationEnabled: notificationEnabled,
            key: ViewKey.deviceSettings,
          ),
        );
      } else {
        if (Platform.isIOS) {
          emit(
            NotificationSettingsShowView(
              notificationEnabled: notificationEnabled,
              key: ViewKey.deviceSettings,
            ),
          );
        } else {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          final settings = await messaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
                alert: true,
                badge: true,
                sound: true,
              );
          notificationEnabled =
              (settings.authorizationStatus == AuthorizationStatus.authorized ||
              settings.authorizationStatus == AuthorizationStatus.provisional);
        }
      }
      _updating(emit);
    });
  }

  _updating(Emitter<NotificationSettingsState> emit) {
    emit(NotificationSettingsUpdated(notificationEnabled: notificationEnabled));
  }
}
