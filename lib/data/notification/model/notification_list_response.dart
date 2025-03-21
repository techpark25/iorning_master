import 'notification.dart';

class NotificationListResponse {
    NotificationListResponse({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Notification> data;

    factory NotificationListResponse.fromJson(Map<String, dynamic> json){ 
        return NotificationListResponse(
            message: json["message"],
            data: json["data"] == null ? [] : List<Notification>.from(json["data"]!.map((x) => Notification.fromJson(x))),
        );
    }

}


