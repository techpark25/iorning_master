import 'notification.dart';

class NotificationDetailResponse {
    NotificationDetailResponse({
        required this.code,
        required this.message,
        required this.data,
    });

    final int? code;
    final String? message;
    final Notification? data;

    factory NotificationDetailResponse.fromJson(Map<String, dynamic> json){ 
        return NotificationDetailResponse(
            code: json["code"],
            message: json["message"],
            data: json["data"] == null ? null : Notification.fromJson(json["data"]),
        );
    }

}


