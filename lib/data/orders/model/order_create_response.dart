import 'order.dart';

class OrderCreateResponse {
    OrderCreateResponse({
        required this.message,
        required this.order,
    });

    final String? message;
    final Order? order;

    factory OrderCreateResponse.fromJson(Map<String, dynamic> json){ 
        return OrderCreateResponse(
            message: json["message"],
            order: json["order"] == null ? null : Order.fromJson(json["order"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "order": order?.toJson(),
    };

}
