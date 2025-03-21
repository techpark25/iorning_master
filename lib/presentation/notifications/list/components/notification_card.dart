import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/notification/model/notification.dart' as no;

class NotificationCard extends StatelessWidget {
  final no.Notification notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showNotificationDetails(context, notification);
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  notification.content ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(notification.createdAt!.add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      softWrap: true,
                    ),
                    Text(
                      DateFormat('hh:mm a')
                          .format(notification.createdAt!.add(const Duration(hours: 5, minutes: 30))),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to show a popup dialog with notification details
  void _showNotificationDetails(BuildContext context, no.Notification notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Notification Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.content ?? 'N/A',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Date: ${DateFormat('dd-MM-yyyy').format(notification.createdAt!.add(const Duration(hours: 5, minutes: 30)))}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "Time: ${DateFormat('hh:mm a').format(notification.createdAt!.add(const Duration(hours: 5, minutes: 30)))}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
