import 'order.dart';

class OrderListResponse {
    OrderListResponse({
        required this.message,
        required this.data,
    });

    final String? message;
    final List<Order> data;

    factory OrderListResponse.fromJson(Map<String, dynamic> json){ 
        return OrderListResponse(
            message: json["message"],
            data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
    };

}




class Pivot {
    Pivot({
        required this.orderId,
        required this.productId,
        required this.quantity,
    });

    final int? orderId;
    final int? productId;
    final int? quantity;

    factory Pivot.fromJson(Map<String, dynamic> json){ 
        return Pivot(
            orderId: json["order_id"],
            productId: json["product_id"],
            quantity: json["quantity"],
        );
    }

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
    };

}
