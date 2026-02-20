import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String userId;

  NotificationModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.title,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, title, body, createdAt, userId];
}
