import 'order.dart';

class OrderDetailResponse {
    OrderDetailResponse({
        required this.orders,
        required this.overallTotal,
    });

    final Order? orders;
    final int? overallTotal;

    factory OrderDetailResponse.fromJson(Map<String, dynamic> json){ 
        return OrderDetailResponse(
            orders: json["data"] == null ? null : Order.fromJson(json["data"]),
            overallTotal: json["overall_total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "data": orders?.toJson(),
        "overall_total": overallTotal,
    };

}



class Product {
    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.image,
        required this.subcategoryId,
        required this.createdAt,
        required this.updatedAt,
        required this.total,
        required this.pivot,
    });

    final int? id;
    final String? name;
    final String? price;
    final String? image;
    final int? subcategoryId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? total;
    final Pivot? pivot;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            name: json["name"],
            price: json["price"],
            image: json["image"],
            subcategoryId: json["subcategory_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            total: json["total"],
            pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "subcategory_id": subcategoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total": total,
        "pivot": pivot?.toJson(),
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
