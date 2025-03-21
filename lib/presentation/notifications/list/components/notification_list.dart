import 'package:flutter/material.dart';
import 'notification_card.dart';

import '../../../../data/notification/model/notification.dart' as no;

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.notifications});
  final List<no.Notification> notifications;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            notification: notifications[index],
          );
        },
      ),
    );
  }
}
