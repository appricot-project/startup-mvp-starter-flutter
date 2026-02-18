import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/models/notification_model.dart';

class NotificationPage {
  final List<NotificationModel> notifications;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  NotificationPage({
    required this.notifications,
    required this.lastDocument,
    required this.hasMore,
  });
}
