import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/models/notification_model.dart';

extension NotificationModelFirestore on NotificationModel {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static NotificationModel fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'],
      body: data['body'],
      userId: data['userId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
