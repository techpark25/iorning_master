import '../../product/model/product.dart';

class Order {
    Order({
        required this.id,
        required this.orderRefNum,
        required this.timeSlot,
        required this.driverId,
        required this.status,
        required this.paymentMode,
        required this.pickupLocation,
        required this.pickupDate,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.total,
        required this.products,
    });

    final int? id;
    final String? orderRefNum;
    final String? timeSlot;
    final dynamic driverId;
    final int? status;
    final String? paymentMode;
    final String? pickupLocation;
    final DateTime? pickupDate;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? userId;
    final int? total;
    final List<Product> products;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            id: json["id"],
            orderRefNum: json["order_ref_num"],
            timeSlot: json["time_slot"],
            driverId: json["driver_id"],
            status: json["status"],
            paymentMode: json["payment_mode"],
            pickupLocation: json["pickup_location"],
            pickupDate: DateTime.tryParse(json["pickup_date"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            userId: json["user_id"],
            total: json["total"],
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_ref_num": orderRefNum,
        "time_slot": timeSlot,
        "driver_id": driverId,
        "status": status,
        "payment_mode": paymentMode,
        "pickup_location": pickupLocation,
        "pickup_date": "${pickupDate?.year.toString().padLeft(4)}-${pickupDate?.month.toString().padLeft(2)}-${pickupDate?.day.toString().padLeft(2)}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "total": total,
        "products": products.map((x) => x?.toJson()).toList(),
    };

}