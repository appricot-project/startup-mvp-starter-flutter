import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/models/notification_model.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:intl/intl.dart';

class NotificationCellWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCellWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 4),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlatformComponents.notificationIcon(),
          12.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                4.h,
                Text(
                  notification.body,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          4.w,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(notification.createdAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                DateFormat('HH:mm').format(notification.createdAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
